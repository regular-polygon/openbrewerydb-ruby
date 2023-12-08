require 'net/http'
require 'json'
require_relative 'constants.rb'

class OpenBreweryDB
  attr_reader :base_url, :states, :brewery_types, :allowed_options

  def initialize
    @base_url = BASE_URL
    @states = STATES
    @brewery_types = BREWERY_TYPES
    @allowed_options = ALLOWED_OPTIONS
  end

  def single_brewery(id="")
    # id refers to the obdb_id assigned to each brewery by OpenBreweryDB
    id = id.to_s
    url = URI.parse("#{@base_url}/#{id}")
    res = Net::HTTP.start(url.host, url.port, :use_ssl => url.scheme == 'https') do |http|
      request = Net::HTTP::Get.new url
      response = http.request request # Net::HTTPResponse object
    end
    if res.message == "OK"
      return JSON.parse(res.body)
    end
  end

  def list_breweries(options={})
    params = make_query_params(options)
    unless params.nil?
      response = call_with_params(params)
      return response
    else
      raise ArgumentError
    end
  end

  private
  def call_with_params(params)
    url = URI.parse(@base_url)
    res = Net::HTTP.start(url.host, url.port, :use_ssl => url.scheme == 'https') do |http|
      url.query = URI.encode_www_form(params)
      request = Net::HTTP::Get.new url
      response = http.request request # Net::HTTPResponse object
    end
    if res.message == "OK"
      JSON.parse(res.body)
    else
      raise ArgumentError
    end

  end

  def make_query_params(options)
    transformed_options = Hash.new
    options.each do |key, value|
      case key.to_s
      when "state"
        unless @states.include?(value.downcase)
          return nil
        end
        transformed_options["by_state"] = value
      when "type"
        unless @brewery_types.include?(value.downcase)
          return nil
        end
        transformed_options["by_type"] = value
      when "city"
        transformed_options["by_city"] = value
      when "postal"
        transformed_options["by_postal"] = value
      else
        return nil
      end
    end
    return transformed_options
  end
end
