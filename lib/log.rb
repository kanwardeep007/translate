# frozen_string_literal: true

# This class have methods for logging for various errors.
class Log
  class << self
    def api_failure_log(request, response)
      Rails.logger.info '******* Logging Errors ******'
      Rails.logger.info "******* Request - #{request.inspect} *******"
      Rails.logger.info "******* Api CALL ----- RESPONSE #{response.inspect} *******"
    end
  end
end
