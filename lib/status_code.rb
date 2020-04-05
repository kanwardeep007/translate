# frozen_string_literal: true

# Provides HTTP Status Codes
class StatusCode
  class << self
    def code_for(string)
      Rack::Utils::HTTP_STATUS_CODES.invert[string]
    end

    def message_for(code)
      Rack::Utils::HTTP_STATUS_CODES[code]
    end

    def ok
      code_for('OK')
    end

    def bad_request
      code_for('Bad Request')
    end

    def server_error
      code_for('Internal Server Error')
    end

    def request_timeout
      code_for('Request Timeout')
    end

    def not_found
      code_for('Not Found')
    end
  end
end
