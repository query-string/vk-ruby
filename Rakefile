# encoding: utf-8

require 'rubygems'
require 'bundler'
begin
  Bundler.setup(:default, :development)
rescue Bundler::BundlerError => e
  $stderr.puts e.message
  $stderr.puts "Run `bundle install` to install missing gems"
  exit e.status_code
end
require 'rake'

require 'jeweler'
Jeweler::Tasks.new do |gem|
  gem.name = "vk-ruby"
  gem.homepage = "http://github.com/zinenko/vk-ruby"
  gem.license = "MIT"
  gem.summary = %Q{ Ruby wrapper for vk.com API }
  gem.description = %Q{ Ruby wrapper for vk.com API }
  gem.email = "zinenkoan@gmail.com"
  gem.authors = ["Andrew Zinenko"]
  gem.files.include 'lib/**/*'
  gem.add_runtime_dependency 'transformer'
end