require 'sinatra'
require 'sinatra/activerecord'
require 'yaml/store'
require './models/node.rb'

set :database_file, 'config/database.yml'

class Appl < Sinatra::Base

  get '/' do
    @first_node_id = 0
    erb :index
  end

end
