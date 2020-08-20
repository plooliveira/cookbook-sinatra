require "sinatra"
require "sinatra/reloader" if development?
require "pry-byebug"
require "better_errors"
require_relative "repositories/cookbook"

configure :development do
  use BetterErrors::Middleware
  BetterErrors.application_root = File.expand_path('..', __FILE__)
end

get '/' do
  @cookbook = Cookbook.new('recipes.csv').all
  erb :index
end

get '/about' do
  erb :about
end

