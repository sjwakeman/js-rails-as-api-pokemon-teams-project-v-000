require 'pry'
class PokemonsController < ApplicationController
    def index
        pokemons = Pokemon.all
        render json: pokemons
    end

    def show
        pokemon = Pokemon.find(params[:id])
        options = {
            include: [:trainer]
        }
        render json: pokemon
    end

    def create
        trainer = Trainer.find(params[:trainer_id])
        # trainer = Trainer.find(params[:id])
        pokemon = trainer.pokemons.build({
            # db/seeds.rb defined
            nickname: Faker::Name.first_name,
            species: Faker::Games::Pokemon.name
        })
        if pokemon.save
            render json: pokemon
        else
            # binding.pry
                #                           If          Else
            render json: pokemon.save ? pokemon : {message: pokemon.errors.messages[:team_max][0]}

        end
     end

    def destroy
        pokemon = Pokemon.find(params[:id])
        pokemon.destroy
    end
end
