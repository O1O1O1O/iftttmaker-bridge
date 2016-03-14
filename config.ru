# $stdout.sync = true

ENV['RACK_ENV'] ||= 'development'

$LOAD_PATH << File.join(__dir__, 'lib')

require 'ifttt_gateway/app'

run IFTTTGateway::App