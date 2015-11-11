require 'simplecov'
SimpleCov.start do
  add_filter '/spec/'
end

require 'pry-byebug'

require_relative '../lib/controller'
require_relative '../lib/game'
require_relative '../lib/interface'
