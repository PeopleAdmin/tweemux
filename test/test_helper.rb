# Run this via 'beg'
require 'working/test_helper'

def reload
  Dir['lib/**/*.rb'].each{|e| load e}
end

if defined? Spork
  Spork.each_run do
    reload
  end
else
  reload
end
# Spork.prefork doesn't like when this is missing
