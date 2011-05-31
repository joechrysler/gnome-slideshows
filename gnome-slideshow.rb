# Iterates through the current directory looking for pngs and jpgs
# globs them into an xml file that gnome-desktop can understand

puts "<background>"
puts "  <starttime>"
puts "    <year>2011</year>"
puts "    <month>03</month>"
puts "    <day>23</day>"
puts "    <hour>00</hour>"
puts "    <minute>00</minute>"
puts "    <second>00</second>"
puts "  </starttime>"

previous = ''
image_duration = 900.0
transition_duration = 5.0
path = `pwd`
num = 0
firstRun = true
first = ''

Dir.glob("./*.*p*g") do |image|
  image.slice!(0)
  image = "#{path.chomp}#{image.chomp}"
  first = image if firstRun
  unless previous == ''
    puts "  <transition>"
    puts "    <duration>#{transition_duration}</duration>"
    puts "    <from>#{previous}</from>"
    puts "    <to>#{image}</to>"
    puts "  </transition>"
  end
  previous = image

  puts "  <static>"
  puts "    <duration>#{image_duration}</duration>"
  puts "    <file>#{image}</file>"
  puts "  </static>"

  firstRun = false
end

puts "  <transition>"
puts "    <duration>#{transition_duration}</duration>"
puts "    <from>#{previous}</from>"
puts "    <to>#{first}</to>"
puts "  </transition>"

puts "</background>"
