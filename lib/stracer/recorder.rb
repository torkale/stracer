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

    def trace(label, message = nil)
      @log.debug(message) if message
      @stats.increment "#{label}.#{@host}"
    end

    def fail(label, message)
      error(message)
      @stats.increment "#{label}.error.#{@host}"
    end

    def measure(key)
      @stats.time("#{key}.time.#{@host}") do
        yield
      end
    end
  end
end
