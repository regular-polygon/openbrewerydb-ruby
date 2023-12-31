# openbrewerydb-ruby

## Installation
Prerequsities 
- Ruby 3.2.2
- RubyGems package manager

```
gem build openbrewerydb.gemspec
gem install ./openbrewerydb-0.0.1.gem
```
## API 
```ruby
OpenBreweryDB.list_breweries(state: nil, city: nil, postal: nil, type: nil)
```
returns a list of hashes containing brewery data
**Parameters**:  
**state**: string, optional  
**city**: string, optional  
**postal**: integer, optional  
**type**: string, optional  

view lists of valid state and type options in `/lib/constants.rb`

```ruby
OpenBreweryDB.random_brewery()
```
returns a random brewery's information
## Example Usage
```ruby
require 'openbrewerydb'

# get a list of large breweries based in Los Angeles
los_angeles_breweries = OpenBreweryDB.list_breweries(city:"Los Angeles", type:"large")
# get a list of breweries by zip code
san_diego_breweries = OpenBreweryDB.list_breweries(postal:92101)
```

## Structure of Brewery Data
```ruby
{"id"=>"786c56e4-c533-4181-8aec-ec976a7bde9f",
  "name"=>"Ballast Point Brewing Company - Little Italy",
  "brewery_type"=>"large",
  "address_1"=>"2215 India St",
  "address_2"=>nil,
  "address_3"=>nil,
  "city"=>"San Diego",
  "state_province"=>"California",
  "postal_code"=>"92101-1725",
  "country"=>"United States",
  "longitude"=>"-117.169738",
  "latitude"=>"32.727777",
  "phone"=>"6192557213",
  "website_url"=>"http://www.ballastpoint.com",
  "state"=>"California",
  "street"=>"2215 India St"}
```