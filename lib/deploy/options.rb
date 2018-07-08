#!/usr/bin/env ruby
require 'optparse'
require_relative 'stages.rb'
require_relative 'deploy.rb'
include Stages

options = {
  stage: :production,
  migrations: false
}

parser = OptionParser.new do |opts|
  opts.banner = <<DOC
  Usage: ruby deploy.rb [stage] [options]
  Stages: #{stages}
DOC

  opts.on("-m", "--migrate", "Run `heroku run rake db:migrate` on choosen stage.") do |value|
    options[:migrations] = value
  end

  opts.on_tail('-h', '--help', "Prints this help.") do
    puts opts
    exit
  end
end

options[:stage] = parser.parse(ARGV).first
Deploy.run(options)
