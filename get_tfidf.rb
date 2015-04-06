require './word_frequency'
require 'csv'

class Get_tfidf
  @hash_words
  @number_of_documents

  def input_file= input_file
    @input_file = input_file
  end

  def get_hash_words
    return @hash_words
  end

  def get_number_of_documents
    return @number_of_documents
  end

  def set_frequency_of_word(w, opt)
    new_word = WordFrequency.new
    new_word.word = w

    if (@hash_words[w] != nil)
      counter = @hash_words[w].get_frequency
      counter += 1
      @hash_words[w].frequency = counter

      if (opt == 0)
        counter = @hash_words[w].get_number_of_documents
        counter += 1
        @hash_words[w].documents = counter
      end
    else
      new_word.frequency = 1
      new_word.documents = 1
      @hash_words[w] = new_word
    end
  end

  def set_tf
    @hash_words = Hash.new
    words = Array.new
    @number_of_documents = 0

    @input_file.each do |line|
      hash_words_in_current_document = Hash.new
      @number_of_documents += 1
      fields = line.split(',')
      words = fields[1].split(' ')
      words.each do |w|
        if (hash_words_in_current_document[w] == nil)
          set_frequency_of_word(w, 0)
          hash_words_in_current_document[w] = w
        else
          set_frequency_of_word(w, 1)
        end
      end

      words = fields[2].split(' ')
      words.each do |w|
        if (hash_words_in_current_document[w] == nil)
          set_frequency_of_word(w, 0)
          hash_words_in_current_document[w] = w
        else
          set_frequency_of_word(w, 1)
        end
      end
    end
  end

  def get_sample_output_tfidf_csv(hash_words, number_of_documents)
    csv_out_file = CSV.open(File.join("data", "sample_output_tfidf.csv"), "wb:UTF-8")
    @input_file.each do |line|
      line = line[0...-1]
      hash_words_in_current_document = Hash.new
      fields = line.split(',')
      words = fields[1].split(' ')

      words.each do |w|
        if (hash_words_in_current_document[w] != nil)
          counter = hash_words_in_current_document[w].get_frequency
          counter += 1
          hash_words_in_current_document[w].frequency = counter
        else
          new_word = WordFrequency.new
          new_word.word = w
          new_word.frequency = 1
          hash_words_in_current_document[w] = new_word
        end
      end

      words = fields[2].split(' ')

      words.each do |w|
        if (hash_words_in_current_document[w] != nil)
          counter = hash_words_in_current_document[w].get_frequency
          counter += 1
          hash_words_in_current_document[w].frequency = counter
        else
          new_word = WordFrequency.new
          new_word.word = w
          new_word.frequency = 1
          hash_words_in_current_document[w] = new_word
        end
      end

      csv_line = []
      csv_line << fields[0]
      csv_line << fields[1]
      csv_line << fields[2]
      csv_line << fields[3]

      limit = fields[3].to_i
      for counter in 1..limit
        csv_line << fields[3+counter]

        tf = 0
        df = 0

        if (hash_words_in_current_document[fields[3+counter]] != nil)
          if (@hash_words[fields[3+counter]] != nil)
            df = @hash_words[fields[3+counter]].get_number_of_documents
          else
            csv_line << 0
            next
          end
          idf = Math::log10(@number_of_documents/df)
          tf_idf = tf * idf
          csv_line << tf_idf
        else
          csv_line << 0
        end
      end


      # sprav tf_idf kazdeho slova a vyber 3 najvacsie

      counter = 0
      words = Array.new

      hash_words_in_current_document.each do |k,v|
        new_word = WordFrequency.new
        new_word.word = hash_words_in_current_document[k].get_word
        tf = hash_words_in_current_document[k].get_frequency

        if (@hash_words[k] != nil)
          df = @hash_words[k].get_number_of_documents
          idf = Math::log10(@number_of_documents/df)
          new_word.tf_idf = tf * idf
        else
          new_word.tf_idf = 0
        end

        words[counter] = new_word
        counter += 1
      end
      
      words = words.sort_by { |a| a.get_tf_idf}.reverse

      csv_line << words[0].get_word
      csv_line << words[0].get_tf_idf
      csv_line << words[1].get_word
      csv_line << words[1].get_tf_idf
      csv_line << words[2].get_word
      csv_line << words[2].get_tf_idf
      csv_out_file << csv_line
    end
    csv_out_file.close
  end

  def write_to_console(hash_words)
    hash_words.each do |k,v|
      puts"Word=#{@hash_words[k].get_word};TF=#{@hash_words[k].get_frequency};DF=#{@hash_words[k].get_number_of_documents}\n"
    end
  end
end