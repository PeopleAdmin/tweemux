class Tweemux::Action::At < Tweemux::Action
  def run args
    host, port = args
    cmd = 'ssh', host
    if port
      cmd.push '-p'+port
      port_parens = " (on port #{port})"
    end
    forced_path_for_osx_people = 'PATH=/usr/local/bin:/usr/bin'
    explained_run cmd + [
      '-t', forced_path_for_osx_people,
      'tmux', '-S', Tweemux::SOCK, 'attach',
    ], "Connect to #{host}#{port_parens}, demand a pty, then attach to session"
  end
end
