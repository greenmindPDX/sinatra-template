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

class SampleApp < Sinatra::Application
  get '/' do
    'Welcome to the my Sample Application!'
  end

  #Read
  get '/orders' do
    @orders = Order.all
    json @orders
  end
end
