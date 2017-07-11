# encoding: UTF-8

require 'net/http'
require 'json'

module LiquidM
  class ReportingClient

    def initialize(api_token, reporting_url = "https://platform.liquidm.com/visual_reports.json")
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

    def request(uri, token, params)
      uri.query = URI.encode_www_form(params.merge({auth_token: token}))
      Net::HTTP.get_response(uri)
    end
  end
end
