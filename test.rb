#!/usr/bin/env ruby

require 'sinatra'
require 'data_mapper'

DataMapper::setup(:default, "sqlite3://#{Dir.pwd}/form.db")

class Hi
  include DataMapper::Resource
  property :id, Serial
  property :content, Text, required: true
end

DataMapper.finalize.auto_upgrade!

get '/' do
  @hi = Hi.all
  erb :form
end

post '/form' do
  @data = Hi.new
  @data.content = params[:message]
  @data.save

  redirect '/'
end

post "/:id" do
  @id = Hi.get params[:id]
  @id.destroy

  redirect '/'
end
