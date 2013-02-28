class Tweemux::Action::At < Tweemux::Action
  def run args
    host, port = args
    cmd = 'ssh', host
    if port
      cmd.push '-p'+port
      port_parens = " (on port #{port})"
    end
    explained_run cmd + %W(-t tmux -S #{Tweemux::SOCK} attach),
      "Connect to #{host}#{port_parens}, demand a pty, then attach to session"
  end
end
