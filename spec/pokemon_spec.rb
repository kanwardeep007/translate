require 'rails_helper'

describe 'pokemon' do
  it 'description api returns error when it fails' do
    pokemon = Pokemon.new('pikachu')
    response = ResponseWrapper.new('Not Found', 404, false)
    allow(pokemon).to receive(:fetch_desc_from_net) {response}
    expect(pokemon.fetch_description(translator: ShakespeareTranslator.new).body).to eq('Not Found')
    expect(pokemon.fetch_description(translator: ShakespeareTranslator.new).code).to eq(404)
  end
  it 'response does not contain any desciption it fails properly' do
    pokemon = Pokemon.new('pikachu')
    # response = ResponseWrapper.new('Not Found', 404, false)
    api_response = ResponseWrapper.new({'flavor_text_entries'=> []}, 200, true)
    allow(pokemon).to receive(:fetch_desc_from_net) {api_response}
    expect(pokemon.fetch_description(translator: ShakespeareTranslator.new).body).to eq('Unable to fetch pokemon description')
    expect(pokemon.fetch_description(translator: ShakespeareTranslator.new).code).to eq(400)
  end
end
