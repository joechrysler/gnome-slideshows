#!/usr/bin/env ruby
# Iterates through a given directory looking for given file types,
# globs them into an xml file that gnome-desktop can understand.

puts "<background>"
puts "  <starttime>"
puts "    <year>2011</year>"
puts "    <month>03</month>"
puts "    <day>23</day>"
puts "    <hour>00</hour>"
puts "    <minute>00</minute>"
puts "    <second>00</second>"
puts "  </starttime>"

files = Array.new
@image_duration = 900.0
@transition_duration = 5.0

# Process Arguments
path = ARGV[0] unless ARGV.empty? 

ARGV[1..-1].each do |argument|
  Dir["#{path}*.#{argument}"].each do |image|
    files << image
  end
end

def put_image(file)
  puts "  <static>"
  puts "    <duration>#{@image_duration}</duration>"
  puts "    <file>#{file}</file>"
  puts "  </static>"
end

def put_transition(current_file, next_file)
  puts "  <transition>"
  puts "    <duration>#{@transition_duration}</duration>"
  puts "    <from>#{current_file}</from>"
  puts "    <to>#{next_file}</to>"
  puts "  </transition>"
end

files.each_index do |index|
  put_image(files[index])
  put_transition(files[index], files[index+1]) unless index == files.length - 1
  if index == files.length - 1
    put_transition(files[index], files[0])
  end
end

puts "</background>"
