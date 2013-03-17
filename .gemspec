# -*- encoding: utf-8 -*-
require 'working/gemspec'
$:.unshift './lib'
require 'tweemux/version'

Working.gemspec(
  :name => 'tweemux',
  :summary => Working.third_line_of_readme,
  #:description => Working.readme_snippet(/== Usage/, /== TODO/),
  :description => 'tweemux host; tweemux at some_machine; plus some more stuff',
  :version => Tweemux::VERSION,
  :authors => %w(☈king Ogredude ryanf Spaceghost),
  :email => 'muchmux@sharpsaw.org',
  :github => 'PeopleAdmin/tweemux',
  :deps => %w(),
)
