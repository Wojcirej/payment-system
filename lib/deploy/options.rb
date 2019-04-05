#!/usr/bin/env ruby
require 'optparse'
require_relative 'stages.rb'
require_relative 'deploy.rb'
include Stages

options = {
  stage: :production,
  migrations: false,
  bump: false
}

parser = OptionParser.new do |opts|
  opts.banner = <<DOC
  Usage: ruby deploy.rb [stage] [options]
  Stages: #{stages}
DOC

  opts.on("-m", "--migrate", "Run `heroku run rake db:migrate` on choosen stage.") do |value|
    options[:migrations] = value
  end

  opts.on('-b [TYPE]', '--bump [TYPE]', [:patch, :minor, :major],
        "Bump version,
        [TYPE]: patch, minor, major - patch is default
        - patch - change last number, e.g. 1.2.3 -> 1.2.4
        - minor - change middle number, e.g. 1.2.3 -> 1.3.0
        - major - change first number, e.g. 1.2.3 -> 2.0.0") do |type|
    options[:bump] = type || :patch
  end

  opts.on_tail('-h', '--help', "Prints this help.") do
    puts opts
    exit
  end
end

options[:stage] = parser.parse(ARGV).first
Deploy.run(options)
