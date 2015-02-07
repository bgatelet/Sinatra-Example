#!/usr/bin/env ruby

require 'sinatra'
require 'sinatra/activerecord'
require 'haml'

ActiveRecord::Base.establish_connection(
  :adapter => 'sqlite3',
  :database => 'db/test.sqlite3.db'
)

helpers do
  def h(text)
    Rack::Utils.escape_html(text)
  end
end

class Note < ActiveRecord::Base
end

get '/' do
  @hi = Note.all
  haml :form
end

post '/form' do
  @data = Note.new
  @data.content = params[:message]
  if @data.content.length > 0 then @data.save end

  redirect '/'
end

post "/delete" do

  arr = params[:deleteMe]
  if arr != nil
    arr.each do |id|
      Note.find(id).destroy
    end
  end

  redirect '/'
end
