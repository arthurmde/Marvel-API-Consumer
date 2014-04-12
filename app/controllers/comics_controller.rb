class ComicsController < ApplicationController
  def show
    @comic = Comic.find(params[:id])
  end
end