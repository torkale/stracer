module Stracer
  class Recorder
    def initialize(stats, log, opts = {})
      @log = log
      @stats = stats
      @host = opts[:host] || "unknown_host"
    end

    def error(message)
      @log.error(message)
    end

    def trace(label, message)
      @log.debug(message) if message
      @stats.inc "#{label}.#{@host}"
    end

    def fail(label, message = nil)
      error(message)
      @stats.inc "#{label}.error.#{@host}"
    end

    def measure(key)
      @stats.time("#{key}.time.#{@host}") do
        yield
      end
    end
  end
end
