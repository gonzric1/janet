#firepit weather
#Gets API call from OpenWeatherMap
#Finds any Fridays or Saturdays where temp is appropriate for fire pit


require 'httparty'
require 'date'
require 'ostruct'

url = 'http://api.openweathermap.org/data/2.5/forecast?zip=60626,us&units=imperial&appid='
key = '3791e579bb9fd962bf5df662885faaa3'
@query = url + key
@min_temp = 50
@state = {"Friday" => "", "Saturday" => ""}
response = HTTParty.get(@query)
@parsed = response.parsed_response
@last_update ||= DateTime.now

def update_weather
  if (@last_update - (3/24) < DateTime.now)
    response = HTTParty.get(@query)
    @parsed = response.parsed_response
    @last_update = DateTime.now
  end
end

def current_weather
  update_weather
  current_temp = @parsed["list"][0]["main"]["temp"]
  feels_like = @parsed["list"][0]["main"]["feels_like"]
  weather = @parsed["list"][0]["weather"][0]["description"]
  return "It is currently #{current_temp}f, feels like #{feels_like}f with #{weather}"
end

#returns a message with firepit weather.
def firepit?
  update_weather
  @parsed["list"].each do |weather|
    date = DateTime.parse(weather["dt_txt"])
    if (date.friday? || date.saturday?) &&  (date.hour > 15)
        if weather["main"]["temp"] > @min_temp
          if weather["weather"][0]["id"] >= 800
            message = "BY FIRE BE CLEANSED ON " + date.strftime("%A")
            @state[date.strftime("%A")] = message
          else
            message = "WARM BUT WET ON like @Loli1 " + date.strftime("%A") + "conditions: " + weather["weather"][0]["description"]
            @state[date.strftime("%A")] = message
          end
        else
          message = "TOO FUCKING COLD ON " + date.strftime("%A") + " I blame @ditaki" + "---Temp: " + weather["main"]["temp"].to_s + "  Feels like: " + weather["main"]["feels_like"].to_s
           @state[date.strftime("%A")] = message
        end

    end
  end
  return @state
end


