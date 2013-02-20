require_relative '../test_helper'

class CLITest < MiniTest::Unit::TestCase
  def test_doc_claims
    claimed_working = File.readlines('README.rdoc').grep /^ {4}tweemux/
    claimed_working.each do |line|
      line.sub! /#.*/, ''
      fake_argv = line.sub(/^\s*tweemux/, '').split.map{|e| e.strip}
      got = Tweemux::CLI.understand fake_argv
      assert got, line
    end
  end
end
