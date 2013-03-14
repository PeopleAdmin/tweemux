require 'tweemux/version'
require 'tweemux/action'
require 'tweemux/core_ext'

class Tweemux
  SOCK = '/tmp/tweemux.sock'

  class << self
    def run args
      action = understand args
      action.call
    rescue Tweemux::Action::NoRestartsException => e
      die e.message.color :error
    end

    def die msg
      warn msg
      exit 1
    end

    def understand args
      args = ['Version'] if args.first[/^--?v/i]
      # dash args are out of fashion!
      args = ['Help'] if args.empty? or args.first[/^-/]
      action = args.shift
      klass = Tweemux::Action.const_get action.capitalize
      klass.new args
    end
  end
end


