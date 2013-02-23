# encoding: utf-8
class Tweemux
  class DubiousSystemInvocation < RuntimeError; end

  class << self
    def run args
      explained_run %w(tmux -S /tmp/tweemux.sock start-server),
        'brings up the tmux process'
      explained_run %w(tmux -S /tmp/tweemux.sock new-session),
        'starts sesssion "1"'
    end

    def understand args
      true
    end

    def explained_run what, why
      raise DubiousSystemInvocation, "Given string-arg of #{what}" \
        if what.is_a? String
      warn highlight_command(what) + highlight_explanation(why)
      system *what or pseudo_restarts(what)
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
      highlighted = []
      # Index access in Ruby is a smell. @ConradIrwin, help me!!
      socket_idx = arr.find_index '-S'
      arr.inject [] do |a,e|
        a << if socket_idx and e == arr[socket_idx] or e == arr[socket_idx+1]
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
      pry_time = 'p'.color :keypress, :prompt
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

class String
  # Pallete viewable from:
  #   https://github.com/sharpsaw/tmux-dots/blob/master/bin/colortest
  COLORS = {
    :middle_blue => 69,
    :brighty_blue => 39,
    :gray245 => 245,
    :orange => 172,
    :pale_yellow => 180,
    :lemon => 228,

    :keypress => 157,
    :prompt => 35,

    :error => 160,
    :default => 7
  }
  def color this_color, end_on = :default
    [this_color, end_on].each{|e| fail "No color for #{e}" unless COLORS[e]}
    if $stderr.tty?
      "\e[38;5;#{COLORS[this_color]}m#{self}\e[38;5;#{COLORS[end_on]}m"
    else
      self
    end
  end
end
