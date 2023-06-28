require 'io/console'

class Stopwatch
  def initialize
    @seconds = 0
    @paused = false
    @stopwatch_thread = nil
  end

  def start
    @stopwatch_thread = Thread.new do
      loop do
        sleep 0.1
        @seconds += 0.1 unless @paused
      end
    end

    handle_input
  end

  def handle_input
    loop do
      char = STDIN.getch
      break if char == "\e" # Exit when 'ESC' key is pressed

      if char == 'p'
        @paused = !@paused
        puts @paused ? "stopwatch paused #{@seconds.round(2)} seconds." : 'stopwatch resumed.'
      end
    end

    stop
  end

  def stop
    @stopwatch_thread.kill if @stopwatch_thread
    puts "stopwatch stopped. Total time: #{@seconds.round(2)} seconds."
  end
end

# Usage
stopwatch = Stopwatch.new
stopwatch.start
