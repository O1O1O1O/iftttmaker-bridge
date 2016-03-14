require 'httparty'

module IFTTTMakerBridge
  class Client
    BASE_URL = 'https://maker.ifttt.com'
    VALUE_KEYS = [:value1, :value2, :value3]

    def initialize(base_url: BASE_URL, key: nil)
      @base_url = base_url
      maker_key(key)
    end

    def authorize
      trigger('_')
    end

    def trigger(event, data={})
      result = HTTParty.post(
        trigger_url(event, maker_key),
        query: request_data(data)
      ).success?
    end

    def request_data(data)
      data.select { |k, v| VALUE_KEYS.include?(k.to_sym) }
    end

    private
    def maker_key(key = nil)
      @maker_key ||= (key || ENV['MAKER_KEY'])
    end



    def trigger_url(event, key)
      "#{@base_url}/trigger/#{event}/with/key/#{key}"
    end
  end
end