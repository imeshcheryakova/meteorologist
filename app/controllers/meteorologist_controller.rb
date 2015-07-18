require 'open-uri'

class MeteorologistController < ApplicationController
  def street_to_weather_form
    # Nothing to do here.
    render("street_to_weather_form.html.erb")
  end

  def street_to_weather
    @street_address = params[:user_street_address]
    url_safe_street_address = URI.encode(@street_address)

    # ==========================================================================
    # Your code goes below.
    # The street address the user input is in the string @street_address.
    # A URL-safe version of the street address, with spaces and other illegal
    #   characters removed, is in the string url_safe_street_address.
    # ==========================================================================

    url="http://maps.googleapis.com/maps/api/geocode/json?address=#{url_safe_street_address}"
    open(url)
    raw_data=open(url).read
    parsed_data=JSON.parse(raw_data)
    results=parsed_data["results"]
    first=results[0]
    geometry=first["geometry"]
    location=geometry["location"]
    location["lat"]
    location["lng"]

    url="https://api.forecast.io/forecast/b0e7cfcc7dba2a9ad8e8fa9d6267b500/#{location["lat"]},#{location["lng"]}"

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

    render("street_to_weather.html.erb")
  end
end
