require 'time'

file = IO.readlines("Timesheet.txt")

morning, brb, back, leaving, finalTime = 0

def get_Lines(file, string)
  file.each { |l|
    morning, brb, back, leaving = 0
  }
end

def valid_Time? string
  Time.parse(string) rescue nil
end

file.each { |l|
  if(l.match?(/morning: (.*)/))
    morning = l.sub(/.*?:/, '')
  elsif(l.match?(/brb lunch: (.*)/))
    brb = l.sub(/.*?:/, '')
  elsif(l.match?(/back: (.*)/))
    back = l.sub(/.*?:/, '')
  elsif(l.match?(/leaving: (.*)/))
    leaving = l.sub(/.*?:/, '')
  end
}

if(valid_Time?(brb))
  brb = Time.parse(brb).to_f
  finalTime = brb
else
  puts "Could not parse 'brb lunch', so 'back' was disregarded" 
end

if(valid_Time?(morning))
  morning = Time.parse(morning).to_f
  finalTime -= morning
else
  finalTime = 0
  puts "Could not parse 'morning', so 'brb lunch' was disregarded" 
end

if(valid_Time?(leaving))
  leaving = Time.parse(leaving).to_f
  finalTime += leaving
else
  puts "Could not parse 'leaving'" 
end

if(valid_Time?(back))
  back = Time.parse(back).to_f
  finalTime -= back
else
  puts "Could not parse 'back', so 'leaving' was disregarded" 
end

puts "Total hours: " + Time.at(finalTime).utc.strftime("%H:%M")