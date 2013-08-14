# encoding: UTF-8

require 'net/http'
require 'json'

module MadvertiseReporting
  class Client

    def initialize(api_token, reporting_url = "http://app.madvertise.de/visual_reports.json")
      raise "Please provide an api-token." unless api_token

      @token = api_token
      @uri = URI.parse(reporting_url)
    end

    def query(params = {})
      result = request(@uri, @token, params)

      raise "Server returned no result." if !result
      raise "Server returned with reponse-code #{result.code}" if result.code != '200'
      
      JSON.parse(result.body) if result.body
    end

    private

    def request(uri, username, params)
      full_path = path_with_params(@uri.path, params)

      request = Net::HTTP::Get.new(full_path, {'Content-Type' =>'application/json'})
      request.basic_auth(username, nil)

      result = Net::HTTP.start(uri.hostname, uri.port) { |http|
        http.request(request)
      }

      result
    end

    def path_with_params(path, params)
      encoded_params = URI.encode_www_form(params)
      [path, encoded_params].join("?")
    end

  end
end
