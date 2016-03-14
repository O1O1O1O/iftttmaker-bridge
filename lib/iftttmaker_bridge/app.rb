require "roda"
require_relative "client"

module IFTTTMakerBridge

  class App < Roda

    plugin :halt
    plugin :drop_body
    plugin :json
    plugin :json_parser

    route do |r|
      r.post 'trigger' do
        r.halt 422 unless r['auth'] && r['data']

        client = Client.new(key: r['auth']['key'])
        response.status = client.trigger(r['data']['event'], client.request_data(r['data'])) ? 204 : 400
      end

      r.post 'authorize' do
        r.halt 422 unless r['auth'] && !r['auth']['key'].nil?
        if Client.new(key: r['auth']['key']).authorize
          # response.body = { key: r['auth']['key'] }
          response.status = 201
        else
          response.status = 401
        end
      end
    end
  end
end