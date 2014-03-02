require 'yaml'
require 'sequel'
require 'pg'

libraries = Dir[File.expand_path('../seeds/**/*.rb', __FILE__)]
libraries.each do |path_name|
  require path_name
end
