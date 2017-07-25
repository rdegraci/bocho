require 'colored'
require 'open3'

clearing :on

guard :shell do
  watch(/(.*).swift$/) {|m|

    puts "Running tests..."

    output = ""
    errors = ""
    exit_status = Open3.popen3("make test") do |stdin, stdout, stderr, wait_thr|
      stdin.close
      output << stdout.read
      errors << stderr.read
      wait_thr.value
    end

    puts output.yellow

    if exit_status.success?
      puts "Passed".green
    else
      puts errors
      puts "Failed".red
    end
  }
end
