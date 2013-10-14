require "stracer/version"
require "stracer/recorder"
require "statsd"
require "log4r"
require 'log4r-gelf'
require 'log4r/yamlconfigurator'
module Stracer
  def self.recorder(opts)
    env = opts[:environment].to_s
     stats = Statsd.new(opts[:statsd_host], 8125).tap do
       |st| st.namespace = "#{env}.#{opts[:service_name]}"
     end
    Log4r::YamlConfigurator.load_yaml_file(opts[:log4r_config])
    log = Log4r::Logger[env]
    Recorder.new(stats, log, host: Socket.gethostname.gsub(/\./,'_'))
  end
end
