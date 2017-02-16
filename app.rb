require 'sinatra'
require 'sinatra/activerecord'
require './lib/models/order'
set :bind, '0.0.0.0'

mime_type :json, "application/json"
before do
 content_type :json
end
helpers do
  def json( dataset )
    if !dataset #.empty?
      return no_data!
     else
       JSON.pretty_generate(JSON.load(dataset.to_json)) + "\n"
    end
  end

  def no_data!
    status 204
     #json :message => "no data"
  end

  def get_page(page)
    @starting_page = page ? page.to_i - 1 : 0
    @item_limit = 10
    @first_item = @starting_page * @item_limit
    @last_item = @first_item +  (@item_limit - 1)
    @posts = Order.limit(10).offset(@first_item).order('id')
    json @posts
  end

  def search(title)
    @title = title
    @post = Post.find_by title (@title)
    json @post
  end
end

class StoreApp < Sinatra::Application
  get '/' do
    'Welcome to the Store!'
  end

  get '/hello' do
    'hello world'
  end

  get '/sup' do
    myhash = {kid1: 'Isaac', kid2: 'Eli'}
    json myhash
  end

  #Read
  get '/orders' do
    @orders = Order.all
    json @orders
  end

  get '/orders/?:page?' do
    get_page(params[:page])
  end
  #Search
  get "/posts/search/:title" do
    search(params[:title])
  end
  #Create
  post "/orders" do
    new_post = MultiJson.load(request.body.read)
     @post = Post.new( new_post )
     if @post.save
       json @post
     else
       no_data!
     end
  end
  #Update
  put "/orders/:id" do
    @post = Post.find_by_id params[:id]
    if !@post
      no_data!
    else
      update_post = MultiJson.load request.body.read
      if @post.update_attributes(update_post)
        json @post
      else
        json @post.errors.messages
      end
    end
  end
  #Delete
  delete "/posts/delete/:id" do
    @post = Post.find_by_id params[:id]
    if !@post
      no_data!
    else
      @post.destroy
    end
  end
end
