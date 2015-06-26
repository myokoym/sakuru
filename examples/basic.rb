#!/usr/bin/env ruby

require "sakuru"

db = Sakuru::Database.new

base_dir = File.expand_path("..", File.dirname(__FILE__))
Dir.glob("#{base_dir}/**/*.rb") do |path|
  db.add(path)
end

puts db.files
puts db.search("def")
