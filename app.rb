require 'sinatra'
require_relative 'compose'
require 'newrelic_rpm'

class App < Sinatra::Base

  get '/' do
    content_type :html
    'Go to /:GitHubUsername/:GitHubOtherUsername to get your pair avatar. <br> example: <a href="/ys/r00k">/ys/r00k</a>'
  end

  get '/:a/:b' do
    content_type :png
    Compose.new(params[:a], params[:b]).image
  end
end
