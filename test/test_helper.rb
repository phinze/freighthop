$LOAD_PATH << File.expand_path('../lib', File.dirname(__FILE__))

require 'bundler/setup'
require 'minitest/spec'

require 'vagrant'
require 'freighthop'

require 'minitest/autorun'
