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

post "/delete" do

  arr = params[:deleteMe]
  arr.each do |id|
    @id = Hi.get id
    @id.destroy
  end

  redirect '/'
end
