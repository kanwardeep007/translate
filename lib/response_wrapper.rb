class ResponseWrapper

  attr_reader :body, :code, :success

  def initialize(body, code, success)
    @body = body
    @code = code
    @success = success
  end

  def success?
    success
  end
end