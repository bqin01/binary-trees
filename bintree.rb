require 'sinatra'
require 'sinatra/activerecord'
require 'yaml/store'
require './models/node.rb'

set :public_folder, File.dirname(__FILE__)
set :database_file, 'config/database.yml'

class Appl < Sinatra::Base
  get '/' do
    @first_node_id = 0
    erb :index
  end
  post '/create' do
    continue = true
    @new_node_name = params['child_name']
    if @new_node_name == ""
      @new_node_name = "Unnamed Node"
    end
    @old_node = Node.find_by(node_id: params[:oldnode])
    if params[:dir] == 'left'
      continue = (@old_node.left == nil)
    else
      continue = (@old_node.right == nil)
    end
    if continue != true
      erb :createerror
    else
      @new_node_id = 0
      while Node.find_by(node_id: @new_node_id) != nil
        @new_node_id = @new_node_id + 1
      end
      @the_new_node = Node.create(node_id: @new_node_id, content: @new_node_name)
      @the_new_node.parent = params[:oldnode]
      @the_new_node.save
      if params[:dir] == 'left'
        @old_node.left = @new_node_id
      else
        @old_node.right = @new_node_id
      end
      @old_node.save
      erb :create
    end
  end
  get '/node/:nodeid' do
    @first_node_id = params[:nodeid]
    if Node.find_by(node_id: @first_node_id) == nil
      erb :node404
    else
      erb :index
    end
  end
  get '/new/:dir' do
    @dir = params[:dir]
    @nodeid = params[:nodeid]
    if @dir != 'right'
      @dir = 'left'
    end
    erb :new
  end
  post '/delete/:nodeid' do
    to_delete = Node.find_by(node_id: params[:nodeid])
    if to_delete == nil || to_delete.left != nil || to_delete.right != nil || to_delete.node_id == 0
      @nodeid = params[:nodeid]
      erb :deleteerror
    else
      parent_node = Node.find_by(node_id: to_delete.parent)
      if parent_node.left == to_delete.node_id
        parent_node.left = nil
        parent_node.save
      else
        parent_node.right = nil
        parent_node.save
      end
      to_delete.destroy
      erb :delete
    end
  end
  get '/:anythingelse' do
    erb :error404
  end
end
