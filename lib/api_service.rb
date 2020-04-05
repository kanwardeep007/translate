# frozen_string_literal: true

# This class is communicating layer for all APIs
class ApiService
  extend ApiDefaults
  extend ApiHelpers
  class << self
    def get(endpoint:, options: {})
      merge_method_name(options, 'get')
      managed_perform(endpoint, options)
    end

    def post(endpoint:, options: {})
      merge_method_name(options, 'post')
      managed_perform(endpoint, options)
    end

    private

    def managed_perform(endpoint, options)
      perform(endpoint, options)
    rescue StandardError => error
      ResponseWrapper.new({ message: 'Something Went Wrong' },
                          StatusCode.server_error,
                          false)
    end

    def perform(endpoint, options)
      response = nil
      options = prepare_options(options)
      request = prepare_request(endpoint, options)
      request.on_complete do |api_response|
        response = process_response(request, api_response)
      end
      Rails.logger.info("---- Request being hit => #{request.inspect}")
      request.run
      response
    end

    def prepare_options(options)
      options[:headers] ||= default_headers
      options[:timeout] ||= default_timeout_in_sec
      options[:payload] = json_payload(options) if should_payload_be_json(options)
      options
    end

    def prepare_request(endpoint, options)
      request = typhoeus_request(endpoint, options)
      add_basic_auth(request, options)
      add_payload(request, options)
      request
    end

    def typhoeus_request(endpoint, options)
      request = Typhoeus::Request.new(endpoint,
                                      sslversion: default_ssl_version,
                                      method: options[:method],
                                      params: options[:params],
                                      headers: options[:headers],
                                      timeout: options[:timeout])
      request
    end

    def process_response(request, response)
      Rails.logger.info("---- Got response from the 3rd party client => #{response.inspect}")
      if response.success?
        ResponseWrapper.new(JSON.parse(response.body), response.code, true)
      else
        process_error_response(request, response, false)
      end
    end

    def process_error_response(request, response, success)
      Log.api_failure_log(request, response)
      if response.timed_out?
        Rails.logger.info('Request Timeout')
        # response.code = 0: Could not get an http response, something's wrong.
        ResponseWrapper.new({ message: 'Request timed out' },
                            StatusCode.request_timeout,
                            success)
      elsif response.code.zero?
        Rails.logger.info('Response code zero')
        ResponseWrapper.new({ message: 'Something Went Wrong' },
                            StatusCode.server_error,
                            success)
      else
        Rails.logger.info('Received failure response from the service you are trying to hit')
        # Received a non-successful http response.
        ResponseWrapper.new(response.body, response.code, success)
      end
    end
  end
end
