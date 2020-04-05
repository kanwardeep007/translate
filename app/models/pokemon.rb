class Pokemon
  ENDPOINT='https://pokeapi.co/api/v2/pokemon-species/'

  attr_reader :name

  def initialize(name)
    @name = name
  end

  def fetch_description(translator: ShakespeareTranslator.new)
    response = fetch_desc_from_net
    return response if response.success? == false

    english_desc = dig_english_description(response)
    return english_desc if english_desc.success? == false

    translator.translate(english_desc.body)
  end

  def fetch_desc_from_net
    endpoint = ENDPOINT + name + '/'
    ApiService.get(endpoint: endpoint)
  end

  private

  def dig_english_description(response)
    return response.body if response.success == false
    description = nil
    response.body['flavor_text_entries'].each do |entry|
      if entry['language']['name'] == 'en'
        description = entry['flavor_text']
        break
      end
    end
    generate_desc_response(description)
  end

  def generate_desc_response(description)
    if description == nil
      ResponseWrapper.new('Unable to fetch pokemon description', 400, false)
    else
      ResponseWrapper.new(description, 200, true)
    end
  end
end