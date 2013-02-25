class Tweemux::Action::Share < Tweemux::Action
  def run _
    chmod_a_rw = %w(chmod a+rw) + [Tweemux::SOCK]
    self.class.explained_run chmod_a_rw, 'makes the shared socket shareable'
    self.class.explained_run [ENV['SHELL']], 'prevents the session from ending'
  end
end
