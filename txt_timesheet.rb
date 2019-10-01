require 'time'

def valid_Time? string
    Time.parse(string) rescue nil
end

def toString array
    array = array.join("\n")
    array = array.split("\n")
end

file = File.open("Timesheet.txt")
f_lines = file.read.split("## Timesheet\n")
f_lines = f_lines[1].split("\n\n")
f_lines = f_lines[0].split("\n")

f_titles = Array.new(4) 
f_hours = Array.new(4)
i = 0

f_lines.each { |l|
    titles, *hours = l.split(/: /)
    f_titles[i] = titles
    f_hours[i] = hours    
    i = i+1
}

f_titles = toString(f_titles)
f_hours = toString(f_hours)

if(valid_Time?(f_hours[2]))
    brb = Time.parse(f_hours[2]).to_f
    finalTime = brb
  else
    puts "Could not parse 'brb lunch', so 'back' was disregarded" 
  end

if(valid_Time?(f_hours[1]))
    morning = Time.parse(f_hours[1]).to_f
    finalTime -= morning
  else
    finalTime = 0
    puts "Could not parse " + f_titles[1] + " , so " + f_titles[2] + "was disregarded"
end
  
  if(valid_Time?(f_hours[4]))
    leaving = Time.parse(f_hours[4]).to_f
    finalTime += leaving
  else
    puts "Could not parse 'leaving'" 
  end
  
  if(valid_Time?(f_hours[3]))
    back = Time.parse(f_hours[3]).to_f
    finalTime -= back
  else
    puts "Could not parse 'back', so 'leaving' was disregarded" 
  end

  puts "Total hours: " + Time.at(finalTime).utc.strftime("%H:%M")