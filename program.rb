require './get_tfidf'

tfidf = Get_tfidf.new
tfidf.input_file = File.open("data/sample_output.csv")
tfidf.set_tf
tfidf.input_file = File.open("data/sample_output.csv")
tfidf.get_sample_output_tfidf_csv(tfidf.get_hash_words, tfidf.get_number_of_documents)


