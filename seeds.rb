require 'ostruct'
require 'yaml'
require 'sequel'
require 'pg'

SOURCE = Sequel.connect('postgres://exercism:@localhost/exercism_development')
TARGET = Sequel.connect('postgres://exercism:@localhost/exercism_seeds')

libraries = Dir[File.expand_path('../seeds/**/*.rb', __FILE__)]
libraries.each do |path_name|
  require path_name
end
