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
```
OpenBreweryDB#list_breweries(options_hash)
options_hash[:state] optional, string
options_hash[:city] optional, string
options_hash[:postal] optional, integer
options_hash[:type] optional, string

OpenBreweryDB#singe_brewery(id)
id: required, string
id is the id assigned to the brewery by OpenBreweryDB
```
## Usage Sample
```ruby
require 'openbrewerydb'
obdb_api = OpenBreweryDB.new

# get a list of large breweries based in Los Angeles
los_angeles_breweries = obdb_api.list_breweries({:city=>"Los Angeles", :type=>"large"})
# get a list of breweries by zip code
san_diego_breweries = breweries = obdb_api.list_breweries({:postal=>92101})
```

## Structure of Brewery Data
```ruby
{"id"=>"cbf3abb3-0bea-4d9c-ae71-d6e0022c49ce", 
"name"=>"Golden Road Brewing", 
"brewery_type"=>"large", 
"address_1"=>"5430 W San Fernando Rd", 
"address_2"=>nil, "address_3"=>nil, 
"city"=>"Los Angeles", 
"state_province"=>"California", 
"postal_code"=>"90039-1015", 
"country"=>"United States", 
"longitude"=>"-118.2744781", 
"latitude"=>"34.15049571", 
"phone"=>"2135426039", 
"website_url"=>"http://www.goldenroad.la", 
"state"=>"California", 
"street"=>"5430 W San Fernando Rd"}
```