class BinaryDistance

  def self.jaccard(seq1, seq2)
    j11 = 0
    j10 = 0
    j01 = 0
    min_len = [seq1.length, seq2.length].min
    min_len.times do |i|
      num1 = seq1[i]
      num2 = seq2[i]

      if(num1 == "1" && num2 == "1")
        j11 += 1
      elsif(num1 == "1" && num2 == "0")
        j10 += 1
      elsif(num1 == "0" && num2 == "1")
        j01 += 1
      end
    end
    jaccard_similarity = j11.to_f / (j11 + j10 + j10).to_f
    1 - jaccard_similarity
  end

  def self.hamming(seq1, seq2)
    min_len = [seq1.length, seq2.length].min
    diff = 0
    min_len.times do |i|
      diff += 1 if seq1[i] != seq2[i]
    end
    diff
  end

  def self.tanimoto(seq1, seq2)
    t11 = 0
    t10 = 0
    t01 = 0
    min_len = [seq1.length, seq2.length].min
    min_len.times do |i|
      num1 = seq1[i]
      num2 = seq2[i]

      t11 += 1 if(num1 == "1" && num2 == "1")
      t10 += 1 if(num1 == "1")
      t01 += 1 if(num2 == "1")

    end
    1 - (t11.to_f/(t01 + t10 - t11))
  end

end