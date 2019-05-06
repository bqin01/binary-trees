require 'sinatra'
require 'sinatra/activerecord'
require 'yaml/store'
require './models/node.rb'

set :database_file, 'config/database.yml'

class Appl < Sinatra::Base

  get '/' do
    erb :index
  end

end
