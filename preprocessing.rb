require 'nokogiri'

stop_words = File.open("data\\english_stop_words_mysql.txt", "r").read
file = File.open("data\\stack_overflow_posts_sample.xml", "r")

xml = Nokogiri::XML(file)

question_rows = xml.xpath("//row[@PostTypeId=1]")
#puts question_rows

ids = []
titles = []
bodies = []
tags = []
question_rows.each do |row|
  #puts row
  ids << row.at_xpath("@Id").content
  title = row.at_xpath("@Title").content

  title = title.split(" ").select { |word| not stop_words.include?(word)}.join(" ")
  titles << title

  body = row.at_xpath("@Body").content
  #puts body
  body = body.gsub(/<code>.*<\/code>/, "").split(" ").select { |word| not stop_words.include?(word)}.join(" ")
  bodies << body

  tag = row.at_xpath("@Tags").content
  tags << tag
end

puts tags
#bodies = titles[15].split(" ").select { |word| not stop_words.include?(word)}.join(" ")
#puts sample_title

