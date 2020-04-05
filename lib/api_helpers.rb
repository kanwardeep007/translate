# frozen_string_literal: true

# Miscellaneous helpers used for APIs
module ApiHelpers
  def should_payload_be_json(options)
    if options[:headers]['Content-Type'] == 'application/json' && \
       options[:payload].present? && \
       options[:payload].is_a?(Hash)
      true
    else
      false
    end
  end

  def json_payload(options)
    options[:payload].to_json
  end

  def merge_method_name(options, name)
    options.merge!(method: name.to_sym)
  end

  def add_basic_auth(request, options)
    return unless options[:basic_auth].present?

    request.options[:userpwd] = options[:basic_auth]
  end

  def add_payload(request, options)
    return unless options[:payload].present?

    request.options[:body] = options[:payload]
  end
end
