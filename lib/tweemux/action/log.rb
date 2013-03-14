class Tweemux::Action::Log < Tweemux::Action
  def run _
    explained_run %w(sudo tail -f /var/log/messages /var/log/secure.log),
      'Watch the logs for incoming connections ("messages" == Linux, "secure.log" == OS X)'
  end
end
