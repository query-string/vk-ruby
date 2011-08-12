require 'rubygems'
require 'net/https'
require 'transformer'
require 'json'
require 'yaml'

%w(core secure serverside standalone).each do |lib|
  require "vk-ruby/#{lib}"
end