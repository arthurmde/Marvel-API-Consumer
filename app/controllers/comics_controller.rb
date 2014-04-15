class ComicsController < ApplicationController
  def index
    @comics = Comic.find_all
  end

  def show
    @comic = Comic.find(params[:id])
  end
end