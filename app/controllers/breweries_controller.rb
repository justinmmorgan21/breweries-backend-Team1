class BreweriesController < ApplicationController
  def index
    @breweries = Brewery.all
    render :index
  end
end
