madvertise Reporting API
========================

Madvertise offers a HTTP based reporting API which allows access to the data behind the madvertise Visual reports. 

Request format
--------------

To access data with our reporting API you need the following information:

* API endpoint URL: http://app.madvertise.de/visual_reports.json
* Authentication: HTTP Basic access authentication with API token as username and an empty password.
* API token: Please use the madvertise self-service (http://app.madvertise.de/) to create your own API token or ask your madvertise contact.

With this information you're able to create a HTTP GET request to get access to our reporting system. The APi supports the following paramaters:

| Parameter | Possible value | Default Value | Description | Example |
| --------- | -------------- | ------------- | ----------- | ------- |
| start_date | valid date string | Date.today - 7.days | Start date for the report | 2013-08-07 |
| end_date | valid date string | Date.today | End date for the report | 2013-08-14 |
| granularity | one of the granularities | all | Granularity of the report | day |
| dimensions | comma separated list of dimensions | - | Specifies the dimensions of your report | timestamp,country |
| filters | comma separated list of filters | - | Restrics the result by the given filters | country-82,country-75 |
| metrics | comma separated list of metrics | pis,ais,clicks | Specifies the columns of your report | requests,ais,clicks |
| currency | valid currency (iso 4217) | EUR | currently EUR and USD are supported | USD |

The following table shows you the possible parameters you can use.

| Parameter | Value | Demand side | Supply Side |
| --------- | ----- | ----------- | ----------- |
| Granularity | all | x | x | 
| Granularity | day | x | x |
| Granularity | hour | x | x |
| Dimension | timestamp | x | x |
| Dimension | banner_type | x |  |
| Dimension | age | x | x |
| Dimension | gender | x | x |
| Dimension | carrier | x | x |
| Dimension | plattform | x | x |
| Dimension | country | x | x |
| Dimension | site | x | x |
| Dimension | ad_type | x |  |
| Dimension | bidder |  | x |
| Dimension | campaign |  | x |
| Dimension | ad |  | x |
| Filter | ad_type | x |  |
| Filter | country | x | x |
| Filter | site | x | x |
| Filter | campaign |  | x |
| Filter | ad |  | x |
| Metric | requests | x |  |
| Metric | ais | x | x |
| Metric | clicks | x | x |
| Metric | earnings | x |  |
| Metric | cost |  | x |
| Metric | ctr | x |  |
| Metric | e_cpm | x |  |
| Metric | fillrate | x |  |
| Metric | downloads |  | x |


Example: http://app.madvertise.de/visual_reports.json?start_date=2013-08-07&end_date=2013-08-14&granularity=day&metrics=ais,clicks


Response format
---------------

Our reporting API returns a JSON response with all the information you requested. An example response looks like this: 

 ```javascript
	{
		"dimensions"=>[
			"country"
			],
		"columns"=>[
			{"id"=>"timestamp", "name"=>"Timestamp"}, {"id"=>"country", "name"=>"Country"}, {"id"=>"requests", "name"=>"Requests"}, {"id"=>"ais", "name"=>"AIs"}, {"id"=>"clicks", "name"=>"Clicks"}
			],
		"rows"=>[
			{"requests"=>{"value"=>46944, "formatted_value"=>"46944"}, "clicks"=>{"value"=>1, "formatted_value"=>"1"}, "ais"=>{"value"=>81, "formatted_value"=>"81"}, "country"=>{"value"=>98, "name"=>"COUNTRY1"}, "timestamp"=>{"value"=>"2013-08-07T00:00:00.000+02:00", "formatted_value"=>"2013-08-07 00:00:00 +0200"}},
			{"requests"=>{"value"=>90319, "formatted_value"=>"90319"}, "clicks"=>{"value"=>1, "formatted_value"=>"1"}, "ais"=>{"value"=>38, "formatted_value"=>"38"}, "country"=>{"value"=>99, "name"=>"COUNTRY2"}, "timestamp"=>{"value"=>"2013-08-07T00:00:00.000+02:00", "formatted_value"=>"2013-08-07 00:00:00 +0200"}},
			{"requests"=>{"value"=>44868, "formatted_value"=>"44868"}, "clicks"=>{"value"=>0, "formatted_value"=>"0"}, "ais"=>{"value"=>58, "formatted_value"=>"58"}, "country"=>{"value"=>98, "name"=>"COUNTRY1"}, "timestamp"=>{"value"=>"2013-08-08T00:00:00.000+02:00", "formatted_value"=>"2013-08-08 00:00:00 +0200"}},
			{"requests"=>{"value"=>98898, "formatted_value"=>"98898"}, "clicks"=>{"value"=>1, "formatted_value"=>"1"}, "ais"=>{"value"=>34, "formatted_value"=>"34"}, "country"=>{"value"=>99, "name"=>"COUNTRY2"}, "timestamp"=>{"value"=>"2013-08-08T00:00:00.000+02:00", "formatted_value"=>"2013-08-08 00:00:00 +0200"}},
			{"requests"=>{"value"=>48997, "formatted_value"=>"48997"}, "clicks"=>{"value"=>1, "formatted_value"=>"1"}, "ais"=>{"value"=>31, "formatted_value"=>"31"}, "country"=>{"value"=>98, "name"=>"COUNTRY1"}, "timestamp"=>{"value"=>"2013-08-09T00:00:00.000+02:00", "formatted_value"=>"2013-08-09 00:00:00 +0200"}},
			{"requests"=>{"value"=>121058, "formatted_value"=>"121058"}, "clicks"=>{"value"=>2, "formatted_value"=>"2"}, "ais"=>{"value"=>27, "formatted_value"=>"27"}, "country"=>{"value"=>99, "name"=>"COUNTRY2"}, "timestamp"=>{"value"=>"2013-08-09T00:00:00.000+02:00", "formatted_value"=>"2013-08-09 00:00:00 +0200"}},
			{"requests"=>{"value"=>69495, "formatted_value"=>"69495"}, "clicks"=>{"value"=>0, "formatted_value"=>"0"}, "ais"=>{"value"=>47, "formatted_value"=>"47"}, "country"=>{"value"=>98, "name"=>"COUNTRY1"}, "timestamp"=>{"value"=>"2013-08-10T00:00:00.000+02:00", "formatted_value"=>"2013-08-10 00:00:00 +0200"}},
			{"requests"=>{"value"=>125926, "formatted_value"=>"125926"}, "clicks"=>{"value"=>2, "formatted_value"=>"2"}, "ais"=>{"value"=>44, "formatted_value"=>"44"}, "country"=>{"value"=>99, "name"=>"COUNTRY2"}, "timestamp"=>{"value"=>"2013-08-10T00:00:00.000+02:00", "formatted_value"=>"2013-08-10 00:00:00 +0200"}},
			{"requests"=>{"value"=>69124, "formatted_value"=>"69124"}, "clicks"=>{"value"=>0, "formatted_value"=>"0"}, "ais"=>{"value"=>258, "formatted_value"=>"258"}, "country"=>{"value"=>98, "name"=>"COUNTRY1"}, "timestamp"=>{"value"=>"2013-08-11T00:00:00.000+02:00", "formatted_value"=>"2013-08-11 00:00:00 +0200"}},
			{"requests"=>{"value"=>100516, "formatted_value"=>"100516"}, "clicks"=>{"value"=>0, "formatted_value"=>"0"}, "ais"=>{"value"=>223, "formatted_value"=>"223"}, "country"=>{"value"=>99, "name"=>"COUNTRY2"}, "timestamp"=>{"value"=>"2013-08-11T00:00:00.000+02:00", "formatted_value"=>"2013-08-11 00:00:00 +0200"}},
			{"requests"=>{"value"=>60036, "formatted_value"=>"60036"}, "clicks"=>{"value"=>0, "formatted_value"=>"0"}, "ais"=>{"value"=>56, "formatted_value"=>"56"}, "country"=>{"value"=>98, "name"=>"COUNTRY1"}, "timestamp"=>{"value"=>"2013-08-12T00:00:00.000+02:00", "formatted_value"=>"2013-08-12 00:00:00 +0200"}},
			{"requests"=>{"value"=>124365, "formatted_value"=>"124365"}, "clicks"=>{"value"=>1, "formatted_value"=>"1"}, "ais"=>{"value"=>76, "formatted_value"=>"76"}, "country"=>{"value"=>99, "name"=>"COUNTRY2"}, "timestamp"=>{"value"=>"2013-08-12T00:00:00.000+02:00", "formatted_value"=>"2013-08-12 00:00:00 +0200"}},
			{"requests"=>{"value"=>183561, "formatted_value"=>"183561"}, "clicks"=>{"value"=>1, "formatted_value"=>"1"}, "ais"=>{"value"=>13, "formatted_value"=>"13"}, "country"=>{"value"=>98, "name"=>"COUNTRY1"}, "timestamp"=>{"value"=>"2013-08-13T00:00:00.000+02:00", "formatted_value"=>"2013-08-13 00:00:00 +0200"}},
			{"requests"=>{"value"=>166270, "formatted_value"=>"166270"}, "clicks"=>{"value"=>3, "formatted_value"=>"3"}, "ais"=>{"value"=>13, "formatted_value"=>"13"}, "country"=>{"value"=>99, "name"=>"COUNTRY2"}, "timestamp"=>{"value"=>"2013-08-13T00:00:00.000+02:00", "formatted_value"=>"2013-08-13 00:00:00 +0200"}},
			{"requests"=>{"value"=>56542, "formatted_value"=>"56542"}, "clicks"=>{"value"=>1, "formatted_value"=>"1"}, "ais"=>{"value"=>20, "formatted_value"=>"20"}, "country"=>{"value"=>98, "name"=>"COUNTRY1"}, "timestamp"=>{"value"=>"2013-08-14T00:00:00.000+02:00", "formatted_value"=>"2013-08-14 00:00:00 +0200"}},
			{"requests"=>{"value"=>109621, "formatted_value"=>"109621"}, "clicks"=>{"value"=>1, "formatted_value"=>"1"}, "ais"=>{"value"=>15, "formatted_value"=>"15"}, "country"=>{"value"=>99, "name"=>"COUNTRY2"}, "timestamp"=>{"value"=>"2013-08-14T00:00:00.000+02:00", "formatted_value"=>"2013-08-14 00:00:00 +0200"}}]}
 ```

The response contains three different attributes and the value of these attributes is always an array:

* __dimensions:__ Contains a dimensions list which are used for this report.
* __columns:__ Contains a list of reported columns. For every column an id and a name is provided.
* __rows:__ Contains a row list. Every row consists of a mapping from a column id an a pair of values (value and formatted_value). The value contains an internal format of the value (eg. id) the formatted_value is the human readable version of this value. Please be aware that the formated value will be persistent but value may change. This means formatted_value => '10€' will always be formatted like this, but the value can change from 1000000 (microcents) to 1000 (cents). If the value is an entity like a country the other key is name instead of formatted_value. If you have specified any dimensions the rows will still be one list and not contain any sublists.

Return Codes:
-------------
This API uses HTTP return codes. A successful response is 200. In other cases it may return different response codes. For example 401 if your authentication was wrong. 

Example client implementation in Ruby
=====================================

This repository contains an example client implementation to access the madvertise reporting API.

Getting started
---------------

In your Gemfile:

```ruby
gem 'madvertise-reporting-api-client', :git => 'git://github.com/madvertise/madvertise-reporting-api-client.git'
```

In your code:

```ruby
require 'madvertise-api'
```

Usage
-----

```ruby
client = MadvertiseReporting::Client.new 'api_token'
```

returns a client object on which the query method can be called to create a full and valid madvertise api query.

```ruby
client.query({:start_date => '2013-08-07', :end_date => '2013-08-14', :granularity => 'day', :metrics => 'requests,ais,clicks'})
```

returns a hash which contains the response json.
