# Run this via 'beg'
require 'working/test_helper'

require 'tweemux'

def load_all_implementation_code
  Dir['lib/**/*.rb'].each{|e| load e}
end

if defined? Spork
  Spork.each_run do
    load_all_implementation_code
  end
  # Spork.prefork doesn't like when this is missing
else
  load_all_implementation_code
end
