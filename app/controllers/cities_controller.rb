class CitiesController < ApplicationController
  def create
    @city = City.new(city_params)

    if @city.save
      render json: @city.to_json
    else
      render json: { errors: @city.errros.full_messages }
    end
  end

  private

  def city_params
    params.require(:city).permit(:name, :country_code)
  end
end
