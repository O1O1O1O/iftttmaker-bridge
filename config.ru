# $stdout.sync = true

ENV['RACK_ENV'] ||= 'development'

$LOAD_PATH << File.join(__dir__, 'lib')

require 'iftttmaker_bridge/app'

run IFTTTMakerBridge::App