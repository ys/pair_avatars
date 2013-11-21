require 'sinatra'
require_relative 'compose'
require 'newrelic_rpm'

class App < Sinatra::Base

  get '/' do
    'Go to /:GitHubUsername/:GitHubOtherUsername to get your pair avatar'
  end

  get '/:a/:b' do
    content_type :png
    Compose.new(params[:a], params[:b]).image
  end
end
