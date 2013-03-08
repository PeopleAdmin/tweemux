require 'formula'

class Tweemux < Formula
  homepage 'http://github.com/PeopleAdmin/tweemux#readme'
  url 'http://github.com/PeopleAdmin/tweemux'
  sha1 'cccdcf5042c6ab463ba34fa0b6b4b80ac3c828e8'

  depends_on 'tmux'
  depends_on 'tweemux' => :ruby

  def install
    tmux_in_default_path = '/usr/bin/tmux'
    system %W(sudo ln -s /usr/local/bin/tmux #{tmux_in_default_path}) \
      unless File.exists? tmux_in_default_path
  end

  def test
    system 'tweemux help'
  end
end
