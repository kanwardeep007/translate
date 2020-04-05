# frozen_string_literal: true

# Methods to set defaults when using APIs
module ApiDefaults
  def default_headers
    { 'Content-Type' => 'application/json' }
  end

  def default_timeout_in_sec
    10
  end

  def default_ssl_version
    'tlsv1_2'.to_sym
  end
end
