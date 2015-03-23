require 'sinatra'
require 'sinatra/fix_951'
require 'sinatra/reloader' if development?

@@guess_count = 0

get '/' do
  random = randomizer
  cheat_code = check_cheat(params["cheat"])
  guess = params["guess"].to_i
  erb :index, :locals => {:number => random, :data => check_guess(guess, random), cheat: cheat_code}
end

def check_cheat(cheat)
  return "The secret is #{@@rand}" if cheat == "true"
end

def randz
  @@rand = rand(101)
end

def randomizer
  if @@guess_count == 0
    @@guess_count = 1
    randz
  elsif @@guess_count == 5
    @@guess_count = 1
    randz
  else
    @@guess_count += 1
    @@rand
  end
end

def check_guess(guess, random)
  if guess == 0
    {message: "Make a guess!", background: "#8C8C8C", count: @@guess_count}
  elsif guess > random + 5
    {message: "That guess is WAY too high.", background: "#D90000", count: @@guess_count}
  elsif guess < random - 5
    {message: "That guess is WAY too low.", background: "#D90000", count: @@guess_count}
  elsif guess > random
    {message: "That guess is too high.", background: "orange", count: @@guess_count}
  elsif guess < random
    {message: "That guess is too low.", background: "orange", count: @@guess_count}
  else
    {message: "You have guessed the secret (#{random})", background: "green", count: @@guess_count}
  end
end
