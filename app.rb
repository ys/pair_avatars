require 'sinatra'
require_relative 'compose'
require 'newrelic_rpm'

class App < Sinatra::Base

  get '/:a/:b' do
    content_type :png
    Compose.new(params[:a], params[:b]).image
  end
end
