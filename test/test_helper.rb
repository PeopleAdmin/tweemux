# Run this via 'beg'
require 'working/test_helper'
Spork.each_run do
  Dir['lib/**/*.rb'].each{|e| load e}
end
# Spork.prefork doesn't like when this is missing
