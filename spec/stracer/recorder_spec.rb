require 'minitest/autorun'
require 'rr'
require 'stracer/recorder'
describe Stracer::Recorder do
  before do
    @log = Object.new
    @stats = Object.new
    @stracer = Stracer::Recorder.new(@stats, @log, host: "host")
  end

  describe "#error" do
    it "logs errors" do
      mock(@log).error("some cryptic error")
      @stracer.error("some cryptic error")
    end
  end

  describe "#fail" do
    it "logs errors and increment" do
      mock(@log).error("Bad thing just happend")
      mock(@stats).increment("bad.error.host")
      @stracer.fail("bad", "Bad thing just happend")
    end
  end

  describe "#measure" do
    it "measures a block" do
      mock(@stats).time("test.time.host")
      @stracer.measure("test") do
        2 + 2
      end
    end
  end
end
