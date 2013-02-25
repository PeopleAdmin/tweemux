# -*- encoding: utf-8 -*-
require 'working/gemspec'
$:.unshift './lib'
require 'tweemux/version'

Working.gemspec(
  :name => 'tweemux',
  :summary => Working.third_line_of_readme,
  #:description => Working.readme_snippet(/== Usage/, /== TODO/),
  :description => Working.third_line_of_readme,
  :version => Tweemux::VERSION,
  :authors => %w(☈king),
  :email => 'rking-tweemux@sharpsaw.org',
  :github => 'rking/tweemux',
  :deps => %w(),
)
