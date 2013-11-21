require 'sinatra'
require_relative 'compose'
require 'newrelic_rpm'
require 'scrolls'
require 'dalli'
require 'rack-cache'

class App < Sinatra::Base

  if ENV["MEMCACHEDCLOUD_SERVERS"]
    cache = Dalli::Client.new(ENV["MEMCACHEDCLOUD_SERVERS"].split(","),
                              {:username => ENV["MEMCACHEDCLOUD_USERNAME"],
                               :password => ENV["MEMCACHEDCLOUD_PASSWORD"],
                               :failover => true,
                               :socket_timeout => 1.5,
                               :socket_failure_delay => 0.2
    })
    use Rack::Cache,
      verbose: true,
      metastore:   cache,
      entitystore: cache
  end
  get '/' do
    cache_control :public, max_age: (3600 * 12)
    content_type :html
    'Go to /:GitHubUsername/:GitHubOtherUsername to get your pair avatar. <br> example: <a href="/ys/r00k">/ys/r00k</a>'
  end

  get '/:a/:b' do
    cache_control :public, max_age: (3600 * 12)
    content_type :png
    Scrolls.context(app: 'pairs', t: Time.now.iso8601) do
      Scrolls.log(a: params[:a], b: params[:b])
    end
    Compose.new(params[:a], params[:b]).image
  end
end
