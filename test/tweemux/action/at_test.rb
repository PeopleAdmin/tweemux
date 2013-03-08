require_relative 'on_test'
class Tweemux::Action::AtTest < Tweemux::Action::OnTest
  def argv; %w'at sharpsaw.org 2233' end
end
