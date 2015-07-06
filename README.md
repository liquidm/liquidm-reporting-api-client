LiquidM Reporting API
========================

LiquidM offers a HTTP based reporting API which allows access to the data behind the LiquidM visual reports.

Request format
--------------

To access data with our reporting API you need the following information:

* API endpoint URL: http://app.liquidm.com/visual_reports.json
* Authentication: HTTP Basic access authentication with API token as username and an empty password.
* API token: Please ask your LiquidM account manager for our API token.

With this information you're able to create a HTTP GET request to get access to our reporting system. The API supports the following paramaters:

| Parameter   | Possible value                     | Default Value       | Description                              | Example               |
| ----------- | ---------------------------------- | ------------------- | ---------------------------------------- | --------------------- |
| start_date  | valid date string                  | Date.today - 7.days | Start date for the report                | 2013-08-07            |
| end_date    | valid date string                  | Date.today          | End date for the report                  | 2013-08-14            |
| granularity | all, day, hour           | all                 | Granularity of the report              | day                   |
| dimensions  | comma separated list of dimensions | -                   | Specifies the dimensions of your report  | timestamp,country     |
| filters     | comma separated list of filters    | -                   | Restrics the result by the given filters | country-82,country-75 |
| metrics     | comma separated list of metrics    | bids,ais,clicks      | Specifies the columns of your report     | bids,ais,clicks   |
| currency    | ISO 4217 currency code             | EUR                 | All currencies supported defined by 'ISO 4217 - Currency codes'      | USD                   |

The following table shows you the possible parameters you can use.

| Parameter | Value                |
| --------- | -------------------- |
| Dimension | ad                   |
| Dimension | advertiser_account   |
| Dimension | age                  |
| Dimension | banner_height        |
| Dimension | banner_width         |
| Dimension | campaign             |
| Dimension | carrier              |
| Dimension | category             |
| Dimension | country              |
| Dimension | gender               |
| Dimension | mraid                |
| Filter    | account              |
| Filter    | ad                   |
| Filter    | banner_height        |
| Filter    | banner_width         |
| Filter    | campaign             |
| Filter    | country              |
| Metric    | ais                  |
| Metric    | bid_cpm              |
| Metric    | bids                 |
| Metric    | clicks               |
| Metric    | downloads            |
| Metric    | downloads2            |
| Metric    | downloads3            |
| Metric    | e_cpc                |
| Metric    | e_cpx1                |
| Metric    | e_cpx2                |
| Metric    | e_cpx3                |
| Metric    | e_cpm                |


Example: http://app.liquidm.com/visual_reports.json?start_date=2013-08-07&end_date=2013-08-14&granularity=day&metrics=ais,clicks


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
  :start_date => '2013-08-07',
  :end_date => '2013-08-14',
  :granularity => 'day',
  :metrics => 'requests,ais,clicks'
})
```

returns a hash which contains the response json.
