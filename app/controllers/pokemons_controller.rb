class PokemonsController < ApplicationController
  def show
    pokemon = Pokemon.new(params[:id])
    description_resp = pokemon.fetch_description
    if description_resp.success?
      render({json: generate_response(params[:id], description_resp.body),
             status: description_resp.code})
    else
      render({json: {message: description_resp.body}, status: description_resp.code})
    end
  end

  private

  def generate_response(name, desc)
    {
      name: name,
      description: desc
    }
  end
end
