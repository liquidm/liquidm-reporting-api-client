LiquidM Reporting API
========================

The LiquidM Reporting API provides you access to the reporting data that also is available via the reporting user interface in the LiquidM platform. In order to use the Reporting API you need a valid authentication token.

Authentication Token
--------------

In order to use the Reporting API you need an Authentication Token (Auth_Token).
If you do not yet have it, please create your AUTH_TOKEN be doing a GET request via your preferred tool or browser to this URL:

https://platform.liquidm.com/api/auth?email=[EMAIL]&password=[PASSWORD]&api=true

Use the LiquidM login credentials you have received from your dedicated account manager.
The generated AUTH_TOKEN is necessary for all future requests.
If you request a new AUTH_TOKEN, the old one will no longer be valid.

Request Format
--------------

To access data with our reporting API you need the following information:

* API endpoint URL with AUTH_TOKEN: https://platform.liquidm.com/visual_reports.json?auth_token=[AUTH_TOKEN]

With this information you're able to create a HTTP GET request to get access to our reporting system.
When referring to the IAB standards, please see http://www.iab.com/wp-content/uploads/2016/03/OpenRTB-API-Specification-Version-2-5-FINAL.pdf

The API supports the following paramaters
-----------------------------------------

|Parameter|Possible Value|Default Value|Description|Example|
|---------|---------------|-------------|------------|-------|
|start_date|valid date string|Date.today - 7.days|Start date for the report|2017-07-01|
|end_date|valid date string|Date.today|End date for the report|2017-12-31|
|granularity|all, day, hour|all|Generates a report aggregated by granularity|day|
|currency|ISO 4217 currency code|EUR|All currencies supported defined by 'ISO 4217 - Currency codes'|USD|
|time_zone|All constants under https://apidock.com/rails/TimeZone |Your user's default currency in the LiquidM platform|You can request any timezone that has an offset of one hour to UTC. 30 minutes offset is not possible|UTC|
|dimensions|comma separated list of dimensions|-|Splits the result per requested dimension|See list of possible dimensions below|
|filters|comma separated list of filters|-|Filters the result by filtered entity only|See list of possible filters below|
|metrics|comma separated list of metrics|ais,cost|Define which metrics you want to see in your report|See list of possible metrics below|

List of all available dimensions
-----------------------------------------

|Dimension|Name in Visual Reports|Description|
|---------|----------------------|------------|
|advertiser_customer|Advertiser Customer|Splits the result of your query, if you manage multiple customers in LiquidM|
|advertiser_account|Advertiser Account|Split the results per account, if you manage multiple accounts in LiquidM|
|campaign|Campaign|Split per campaign|
|ad|Ad|Split per ad|
|account|Publisher Account|Split per SSP|
|site|Site|Split per site|
|supply_type|Supply Type|Split between app / site|
|age|Age|Split per age group|
|gender|Gender|Split per gender|
|country|Country|Split per country|
|carrier|Carrier|Split per carrier / ISP|
|region|Region|Split per region (region, city, ZIP code)|
|category|Category|Split per IAB category|
|devicetype|Device Type|Split per IAB device type|
|device_brand|Device Brand|Split per device manufacturer|
|model|Device Model|Split per device model|
|os|OS|Split per Operating System|
|os_version|OS version|Split per OS version|


List of all available filters (Details see Dimensions above)
-----------------------------------------

|Filter|Example|
|------|-------|
|advertiser_customer|12345|
|advertiser_account|54321|
|campaign|99999|
|ad|1234567|
|account|6789|
|site|123456789|


List of all available metrics
-----------------------------------------

|Metric|Name in Visual Reports|Description|
|------|----------------------|------------|
|ais|Ad Impressions|Amount of delivered impressions|
|bids|Bids|Amount of Bid Responses|
|bid_requests|Bid Requests|Amount of all Auctions|
|clicks|Clicks|Amount of clicks tracked|
|ctr|CTR|clicks/ais|
|downloads|Conversion 1 (Downloads)|Amount of conversions pinged to the LiquidM|
|downloads2|Conversion 2|Amount of 2nd level funnel events pinged to LiquidM|
|downloads3|Conversion 3|Amount of 3nd level funnel events pinged to LiquidM|
|downloads_value|Conversion Value|Value added to conversion event (Example: 1.99)|
|e_cpc|eCPC|cost/clicks|
|e_cpx1|eCPX 1|cost/downloads|
|e_cpx2|eCPX 2|cost/downloads2
|e_cpx3|eCPX 3|cost/downloads2
|e_cpm|eCPM|cost/ais * 1000|
|earnings|Cost|Supply Cost|
|win_rate|Win Rate|ais/bids|
|conversion_rate|Conversion Rate|downloads1/ais|
|video_firstquartile|Video 25% Viewed|Video 25% Viewed|
|video_midpoint|Video 50% Viewed|Video 50% Viewed|
|video_thirdquartile|Video 75% Viewed|Video 75% Viewed|
|video_complete|Video 100% Viewed|Video 100% Viewed|

Example: https://platform.liquidm.com/visual_reports.json?auth_token=[AUTH_TOKEN]&start_date=2017-06-07&end_date=2017-06-14&granularity=day&metrics=ais,clicks

Response format
---------------

Our reporting API returns a JSON response with all the information you requested. An example response looks like this:

```json
{
  "columns": [
    {
      "id": "country",
      "name": "Country"
    },
    {
      "id": "ais",
      "name": "AIs"
    },
    {
      "id": "clicks",
      "name": "Clicks"
    }
  ],
  "dimensions": [
    "country"
  ],
  "rows": [
    {
      "ais": {
        "formatted_value": "81",
        "value": 81
      },
      "clicks": {
        "formatted_value": "1",
        "value": 1
      },
      "country": {
        "name": "COUNTRY1",
        "value": 98
      },
    }
    // Additional rows omitted from listing
  ]
}
```

The response contains three different attributes and the value of these attributes is always an array:

* __dimensions:__ Contains a dimensions list which are used for this report.
* __columns:__ Contains a list of reported columns. For every column an id and a name is provided.
* __rows:__ Contains a row list. Every row consists of a mapping from a column id an a pair of values (value and formatted_value). The value contains an internal format of the value (eg. id) the formatted_value is the human readable version of this value. Please be aware that the formated value will be persistent but value may change. This means formatted_value => '10€' will always be formatted like this, but the value can change from 1000000 (microcents) to 1000 (cents). If the value is an entity like a country the other key is name instead of formatted_value. If you have specified any dimensions the rows will still be one list and not contain any sublists.

Return codes
-------------
This API uses HTTP return codes. A successful response is 200. In other cases it may return different response codes. For example 401 if your authentication was wrong.

Example client implementation in Ruby
=====================================

This repository contains an example client implementation to access the LiquidM reporting API.

Getting started
---------------

In your Gemfile:

```ruby
gem 'liquidm-reporting-api-client', git: 'git://github.com/liquidm/liquidm-reporting-api-client.git'
```

In your code:

```ruby
require 'liquidm-reporting-api-client'
```

Usage
-----

```ruby
client = LiquidM::ReportingClient.new('api_token')
```

returns a client object on which the query method can be called to create a full and valid LiquidM API query.

```ruby
client.query({
  :start_date => '2017-07-04',
  :end_date => '2017-07-11',
  :granularity => 'day',
  :filters => ['campaign-99999'],
  :metrics => 'bids,ais,clicks'
})
```

returns a hash which contains the response json.
