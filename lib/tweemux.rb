# encoding: utf-8

require 'tweemux/action'
require 'tweemux/core_ext'

class Tweemux
  class DubiousSystemInvocation < RuntimeError; end

  # I'm not sure how long this should be. On Linux, I've never had to wait. On
  # OS X, it's sometimes definitely more than 3.
  SECONDS_BEFORE_CHMOD = 5

  SOCK = '/tmp/tweemux.sock'

  class << self
    def run args
      tmux_S %w'start-server', 'brings up the tmux process'
      background_chmod_a_rw
      tmux_S %w'new-session', 'starts sesssion "1"'
    end

    def tmux_S args, why
      cmd = %W(tmux -S #{SOCK}) + args
      explained_run cmd, why
    end

    def understand args
      action = args.shift
      klass = Tweemux::Action.const_get action.capitalize
      klass.new args
    end

    def background_chmod_a_rw
      chmod_a_rw = %w(chmod a+rw /tmp/tweemux.sock)
      explain chmod_a_rw, 'makes the shared socket shareable'
      # FIXME: A better way to do this would be to spawn a window in the new
      # session which shows the output of a failure, if any, and otherwise just
      # does this chmod at the right time
      Thread.start do
        sleep SECONDS_BEFORE_CHMOD
        system_or_raise chmod_a_rw
      end
    end

    def explained_run what, why
      raise DubiousSystemInvocation, "Given string-arg of #{what}" \
        if what.is_a? String
      explain what, why
      system_or_raise what
    end

    def explain what, why
      warn highlight_command(what) + highlight_explanation(why)
    end

    def system_or_raise cmd
      system *cmd or pseudo_restarts(*cmd)
    end

    def highlight_command arr
      ': Running'.color(:middle_blue) \
        + '; '.color(:gray245) \
        + colorize_tmux_command(arr)
    end

    def highlight_explanation msg
      '  # '.color(:orange) + msg.color(:lemon)
    end

    def colorize_tmux_command arr
      # Index access in Ruby is a smell. @ConradIrwin, help me!!
      socket_idx = arr.find_index '-S'
      arr.inject [] do |a,e|
        a << if socket_idx and (e == arr[socket_idx] or e == arr[socket_idx+1])
          e.color :gray245
        else
          e.color :brighty_blue
        end
      end.join ' '
    end

    def pseudo_restarts cmd
      warn '# failed ☹'.color :error
      ctrl_c = 'Ctrl+c'.color :keypress, :prompt
      enter = 'Enter'.color :keypress, :prompt
      # TODO: work pry-rescue into this so we can offer a 'try-again'
      # See also: https://github.com/ConradIrwin/pry-rescue/issues/29
      warn <<-EOT.color :prompt
         To give up, hit: #{ctrl_c}
      To run anyway, hit: #{enter}
      EOT
      $stdin.readline
    end

  end
end


