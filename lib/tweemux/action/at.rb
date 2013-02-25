class Tweemux::Action::At < Tweemux::Action
  def run args
    host, port = args
    port ||= 22
    explained_run %W(ssh #{host} -p#{port} -t tmux -S #{Tweemux::SOCK} attach),
      "Connect to #{host} on port #{port}, demand a pty, then attach to session"
  end
end
