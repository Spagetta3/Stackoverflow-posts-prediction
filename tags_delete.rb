# z parsovanych otazok vymaze podla suboru 'tag_count_*.csv' vsetky tagy, ktore sa tam nenachadzaju.
# ak ostane otazka bez tagov, bude vymazana cela otazka
# potom zapise do noveho csv suboru

require 'csv'

tags = Hash.new
File.open(File.join("data", "tag_count_65536_greater_50.csv"), "r:UTF-8").each do |line|
  content = line.split ","
  tags[content[0]] = content[1].to_i
end

puts "done tag reading"

csv_out_file = CSV.open(File.join("data", "sample_questions_65536_zheng_parser_deleted_tags.csv"), "wb:UTF-8")

sample_file = File.open(File.join("data", "sample_questions_65536_zheng_parser.csv"), "r:UTF-8")
sample_file.each do |line|
  content = line.split(",")
  id = content[0].to_i
  title = content[1]
  body = content[2]
  tag_count = content[3].to_i

  new_tags = []
  tag_count.times do |i|
    actual_tag = content[4 + i]
    new_tags << actual_tag if(tags[actual_tag] != nil)
  end

  if(new_tags.length > 0)
    csv_line = []
    csv_line << id
    csv_line << title
    csv_line << body
    csv_line << new_tags.length

    new_tags.each do |t|
      csv_line << t
    end

    csv_out_file << csv_line
    csv_out_file.flush
  end
end

csv_out_file.close
puts "done writing csv"
