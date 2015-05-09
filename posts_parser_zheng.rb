require 'nokogiri'
require 'csv'
#require 'fast_stemmer'
require 'lingua/stemmer'

load 'xml_parser.rb'

class Array
  @@stemmer = Lingua::Stemmer.new(:language => "en")
  def stemmify
    self.map {|element| @@stemmer.stem(element) }
  end

  def filter_stop_words
    self.select {|word| not Stop_words.include?(word)}
  end


Stop_words = File.open(File.join("data", "stop_words_zeng.txt"), "r:UTF-8").read.split(/\s+/).stemmify

Regex_to_delete = File.open(File.join("data", "regex_words_to_delete.txt"), "r:UTF-8").read.split(/\s+/)

end

class String
  def filter_characters
    ret = self
    #words = ret.sub('[^\w\s]', ' ', re.sub('<[^<]+?>', ' ', post)).lower().split()
    ret = ret.gsub(/[^\w\s]/, " ").gsub(/<[^<]+?/, " ")
    ret
  end
end

#file = File.join("data", "stack_overflow_posts_sample.xml")
file = File.join("D:", "Posts.xml")

questions = 0
csv_out_file = CSV.open(File.join("data", "sample_output_zheng.csv"), "wb:UTF-8")
Xml::Parser.new(Nokogiri::XML::Reader(File.open(file, "r:UTF-8"))) do
  inside_element 'posts' do
    for_element 'row' do |row|
      post_type = row.attribute "PostTypeId"
      if (post_type == "1")
        questions += 1

        id = row.attribute "Id"

        title = row.attribute "Title"
        filtered_title = title.downcase.filter_characters.split(" ").stemmify.filter_stop_words.join(" ")

        body = row.attribute "Body"
        #puts body
        filtered_body = body.downcase.filter_characters.split(" ").stemmify.filter_stop_words.join(" ")

        tags = row.attribute "Tags"
        tags = tags.gsub(/[<>]/, " ").strip.split(" ")

        csv_line = []
        csv_line << id
        csv_line << filtered_title
        csv_line << filtered_body
        csv_line << tags.length

        tags.each do |t|
          csv_line << t
        end

        csv_out_file << csv_line
        csv_out_file.flush
      end
      puts questions if questions % 500 == 0
    end
  end
end

csv_out_file.close
puts "done"