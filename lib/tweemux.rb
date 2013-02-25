require 'tweemux/action'
require 'tweemux/core_ext'

class Tweemux
  SOCK = '/tmp/tweemux.sock'

  class << self
    def run args
      action = understand args
      action.call
    end

    def understand args
      action = args.shift
      klass = Tweemux::Action.const_get action.capitalize
      klass.new args
    end
  end
end


