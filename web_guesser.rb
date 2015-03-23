require 'sinatra'
require 'sinatra/fix_951'
require 'sinatra/reloader' if development?

random = rand(101)

get '/' do
  "#{random}"
end
