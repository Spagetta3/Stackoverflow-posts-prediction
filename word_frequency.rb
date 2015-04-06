class WordFrequency

  def word= word
    @word = word
  end

  def frequency= frequency
    @frequency = frequency
  end

  def documents= documents
    @documents = documents
  end

  def tf_idf=tf_idf
    @tf_idf = tf_idf
  end

  def get_word
    return @word
  end

  def get_frequency
    return @frequency
  end

  def get_number_of_documents
    return @documents
  end

  def get_tf_idf
    return @tf_idf
  end
end

