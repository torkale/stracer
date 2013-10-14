module Stracer
  class Recorder
    def initialize(stats, log, opts = {})
      @log = log
      @stats = stats
      @host = opts[:host] || "unknown_host"
    end

    def error(message, object = nil)
      @log.error(message, object)
    end

    def trace(label, message = nil, object = nil)
      @log.debug(message, object) if message
      @stats.inc "#{label}.#{@host}"
    end

    def fail(label, message, err)
      error(message, err)
      @stats.inc "#{label}.error.#{@host}"
    end

    def measure(key)
      @stats.time("#{key}.time.#{@host}") do
        yield
      end
    end
  end
end
