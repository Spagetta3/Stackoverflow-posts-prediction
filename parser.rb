require 'nokogiri'
require 'csv'

#Stop_words_long = File.open(File.join("data", "stop_words_long.txt"), "r").read.split(/\s+/)
#Stop_words_mysql = File.open(File.join("data", "stop_words_mysql.txt"), "r").read.split(/\s+/)
Stop_words = File.open(File.join("data", "stop_words_zeng.txt"), "r:UTF-8").read.split(/\s+/)
Regex_to_delete = File.open(File.join("data", "regex_words_to_delete.txt"), "r:UTF-8").read.split(/\s+/)

def delete_words(word)
  Regex_to_delete.each do |w|
    word.gsub!(Regexp.new(w), " ")
  end
  word
end

def filter_stop_words(words)
  words.select! {|word| not Stop_words.include?(word.downcase)}
  words
end


file = File.open(File.join("data", "stack_overflow_posts_sample.xml"), "r:UTF-8")
xml = Nokogiri::XML(file)

question_rows = xml.xpath("//row[@PostTypeId=1]")

csv_out_file = CSV.open(File.join("data", "sample_output.csv"), "wb:UTF-8")
question_rows.each do |row|
  id = row.at_xpath("@Id").content.downcase

  title = row.at_xpath("@Title").content.downcase
  title = delete_words(title)
  filtered_title = filter_stop_words(title.split(" ")).join(" ")


  body = row.at_xpath("@Body").content.downcase
  body = delete_words(body)
  filtered_body = filter_stop_words(body.split(" ")).join(" ")

  tags = row.at_xpath("@Tags").content.downcase
  tags = tags.gsub!(/[<>]/, " ").strip.split(" ")

  csv_line = []
  csv_line << id
  csv_line << filtered_title
  csv_line << filtered_body
  csv_line << tags.length

  tags.each do |t|
    csv_line << t
  end

  csv_out_file << csv_line
end

csv_out_file.close

puts "done"