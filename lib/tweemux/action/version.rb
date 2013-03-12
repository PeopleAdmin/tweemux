class Tweemux::Action::Version < Tweemux::Action
  def run _
    warn Tweemux::VERSION
  end
end
