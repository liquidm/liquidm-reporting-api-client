# encoding: UTF-8

require 'spec_helper'

describe LiquidM::ReportingClient do

  it 'returns response on 200' do
    result = {"dimensions"=>[], "columns"=>[{"id"=>"pis", "name"=>"PIs"}, {"id"=>"ais", "name"=>"AIs"}, {"id"=>"clicks", "name"=>"Clicks"}], "rows"=>[{"clicks"=>{"value"=>376771, "formatted_value"=>"376771"}, "pis"=>{"value"=>494821129, "formatted_value"=>"494821129"}, "ais"=>{"value"=>106624642, "formatted_value"=>"106624642"}}]} 
    stub_request(:get, "http://api_token:@app.liquidm.com/visual_reports.json?")
      .to_return(:status => 200, :body => result.to_json)

    client = LiquidM::ReportingClient.new('api_token')
    client.query == result
  end

  it 'raises on request failure' do
    stub_request(:get, "http://api_token:@app.liquidm.com/visual_reports.json?")
      .to_return(:status => 401, :body => nil)

    client = LiquidM::ReportingClient.new('api_token')
    expect{ client.query }.to raise_error
  end

  it 'raises on missing api token' do
    expect{ LiquidM::ReportingClient.new(nil) }.to raise_error
  end

end
