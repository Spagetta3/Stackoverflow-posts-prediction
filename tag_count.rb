# urobi pocetnost tagov na zaklade vybranych otazok
# a potom ich zapise do csv suboru
require 'csv'

tags = Hash.new
File.open(File.join("data", "sample_output_5000.csv"), "r:UTF-8").each do |line|
  content = line.split ","
  tag_count = content[3].to_i
  for i in 4...(4+tag_count)
    tag = content[i]
    if tags[tag] == nil
      tags[tag] = 1
    else
      count = tags[tag]
      count += 1
      tags[tag] = count
    end
  end
end

puts "done reading"




file_out =  CSV.open(File.join("data", "tag_count_5000.csv"), "wb:UTF-8")

tags.each do |key, value|
  csv_line = []
  csv_line << key
  csv_line << value
  file_out << csv_line
  file_out.flush
end
puts "done writing"
file_out.close