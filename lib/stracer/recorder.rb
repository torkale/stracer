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

    def log(message)
      @log.info(message)
    end

    def trace(label, message = nil)
      @log.debug(message) if message
      @stats.increment "#{label}.#{@host}"
    end

    def fail(label, message)
      error(message)
      @stats.increment "error.#{label}.#{@host}"
    end

    def measure(key)
      start = Time.now
      result = yield
      timing(key, ((Time.now - start) * 1000).round)
      result
    end

    def timing(key, value)
      @stats.timing("#{key}.#{@host}", value)
      @log.debug("Traced total of #{value} for #{key}")
    end
  end
end
