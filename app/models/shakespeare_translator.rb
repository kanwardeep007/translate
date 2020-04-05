# This class is responsible for translating
# english to shakespeare form
class ShakespeareTranslator

  ENDPOINT='https://api.funtranslations.com/translate/shakespeare'

  def translate(string)
    # return ResponseWrapper.new("some fixed value", 200, true)
    fetch_translation(string)
  end

  private

  def fetch_translation(string)
    response = ApiService.post(endpoint: ENDPOINT, options: {payload: {text: string}})
    if response.success?
      ResponseWrapper.new(response.body['contents']['translated'], response.code, response.success)
    else
      response
    end
  end
end