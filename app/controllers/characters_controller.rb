class CharactersController < ApplicationController
  def index
    @characters = Character.find_all
  end

  def show
    @character = Character.find(params[:id])
  end
end
