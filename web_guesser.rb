require 'sinatra'
require 'sinatra/fix_951'
require 'sinatra/reloader' if development?

random = rand(101)

get '/' do
  guess = params["guess"].to_i
  message = check_guess(guess, random)
  erb :index, :locals => {:number => random, :message => message}
end

def check_guess(guess, random)
  if guess > random + 5
    "That guess is WAY too high."
  elsif guess < random - 5
    "That guess is WAY too low."
  elsif guess > random
    "That guess is too high."
  elsif guess < random
    "That guess is too low."
  else
    "You have guessed the secret #{random}"   # deteled ()' around interpolation
  end
end
