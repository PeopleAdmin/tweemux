# encoding: utf-8

class Tweemux
  class Action
    def initialize args; @args = args end

    def call
      run @args
    end

    def run args; raise 'Unimplemented' end

    class DubiousSystemInvocation < RuntimeError; end
    class << self
      def tmux_S args, why
        cmd = %W(tmux -S #{SOCK}) + args
        explained_run cmd, why
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
          ':Running'.color(:middle_blue) \
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
            a <<
              if socket_idx and (e == arr[socket_idx] or e == arr[socket_idx+1])
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

        def load_all!
          dir = __FILE__.sub /\.rb$/, ''
          Dir[dir + '/*.rb'].each do |e|
            require e.sub /.*(tweemux\/.+)\.rb$/, '\1'
          end
        end
      end
  end
end

Tweemux::Action.load_all!
