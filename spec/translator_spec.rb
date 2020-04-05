# frozen_string_literal: true

require 'rails_helper'

describe 'translator' do
  it 'correctly translates to shakespeare form' do
    translator = ShakespeareTranslator.new
    pokemon = Pokemon.new('charizard')
    msg = 'Charizard is a fire dragon t spits fire on t enemies.'
    response = ResponseWrapper.new(msg, 200, true)
    allow(translator).to receive(:translate) {response}
    expect(pokemon.fetch_description(translator: translator).body).to eq(msg)
  end
end
