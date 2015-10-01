require 'data_sports_group/version'
require 'nokogiri'
require 'rest_client'
require 'time'

module DataSportsGroup
  class Api
    attr_accessor :key, :client, :user, :password
    def initialize(key, client, user, password)
      @key = key
      @client = client
      @user = user
      @password = password
    end

    def get_uri(url)
      "http://#{@user}:#{@password}@api.datasportsgroup.com/clients/#{@client}#{url}"
    end

    def get_params(params)
      return {authkey: @key, client: @client} if params.nil?
      params.merge( authkey: @key, client: @client)
    end

    #  def self.get_auth
    #    'Basic ' + Base64.encode64("#{@user}:#{@password}").chomp
    #  end

    def generic_request(url, params)
      begin
        return RestClient.get(get_uri(url), params: get_params(params))
      rescue RestClient::RequestTimeout => timeout
        raise DataSportsGroup::Exception, 'The API did not respond in a reasonable amount of time'
      rescue RestClient::Exception => e
        raise DataSportsGroup::Exception, e.response.to_s
      end
    end
  end
end