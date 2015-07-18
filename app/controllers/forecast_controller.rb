require 'open-uri'

class ForecastController < ApplicationController
  def coords_to_weather_form
    # Nothing to do here.
    render("coords_to_weather_form.html.erb")
  end

  def coords_to_weather
    @lat = params[:user_latitude]
    @lng = params[:user_longitude]

    # ==========================================================================
    # Your code goes below.
    # The latitude the user input is in the string @lat.
    # The longitude the user input is in the string @lng.
    # ==========================================================================

    url="https://api.forecast.io/forecast/b0e7cfcc7dba2a9ad8e8fa9d6267b500/37.8267,-122.423"
    open(url)
    raw_data=open(url).read
    parsed_data=JSON.parse(raw_data)
    results=parsed_data["currently"]
    temperature=results["temperature"]
    summary=results["summary"]

    results2=parsed_data["minutely"]
    summary1=results2["summary"]

    results3=parsed_data["hourly"]
    summary2=results3["summary"]

    results4=parsed_data["daily"]
    summary3=results4["summary"]

    @current_temperature = temperature

    @current_summary = summary

    @summary_of_next_sixty_minutes = summary1

    @summary_of_next_several_hours = summary2

    @summary_of_next_several_days = summary3

    render("coords_to_weather.html.erb")
  end
end
