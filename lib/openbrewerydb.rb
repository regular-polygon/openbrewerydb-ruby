require 'net/http'
require 'json'
require_relative 'constants.rb'

class OpenBreweryDB

  # imported from 'constants.rb'
  BASE_URL = BASE_URL
  STATES = STATES
  BREWERY_TYPES = BREWERY_TYPES

  def self.list_breweries(state: nil, city: nil, postal: nil, type: nil)
    if !state.nil? && !@@states.include?(state.downcase)
      raise ArgumentError, "#{state} is not in the list of valid states."
    end
    if !type.nil? && !@@brewery_types.include?(type.downcase)
      raise ArgumentError, "#{type} is not in the list of valid brewery types."
    end
    query_params = Hash.new
    query_params["by_state"] = state
    query_params["by_city"] = city
    query_params["by_postal"] = postal
    query_params["by_type"] = type
    query_params = self.strip_nil_values(query_params)
    return self.call_with_params(query_params)
  end

  private
  def self.call_with_params(params)
    url = URI.parse(@@base_url)
    Net::HTTP.start(url.host, url.port, :use_ssl => url.scheme == 'https') do |http|
      url.query = URI.encode_www_form(params)
      request = Net::HTTP::Get.new url
      response = http.request request # Net::HTTPResponse object
      if response.message == "OK"
        return JSON.parse(response.body)
      else
        return nil
      end
    end
  end

  def self.strip_nil_values(hash)
    hash.each do |key, value|
      if value.nil?
        hash.delete(key)
      end
    end
  end

end
