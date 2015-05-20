require './get_tfidf'

tfidf = Get_tfidf.new

#tfidf.input_file = File.open("/mnt/hgfs/OZNAL/sample_output_hash_num_of_docs_ge_20.csv")

#tfidf.input_file = File.open("/mnt/hgfs/OZNAL/sample_output_65536_filtered_tags.csv")
#tfidf.get_sample_output_vector_csv(tfidf.get_hash_words)

#Hranie sa s vektorom slov - vystup je ten vektor hash
tfidf.input_file = File.open("/home/veronika/RubymineProjects/Stackoverflow-posts-prediction/data/sample_output_hash_new.csv")
#tfidf.set_tf
tfidf.get_hash_words_from_file
#tfidf.get_hash_output(tfidf.get_hash_words)
tfidf.input_file = File.open("/mnt/hgfs/OZNAL/sample_output_65536_filtered_tags.csv")
tfidf.get_sample_output_vector_csv(tfidf.get_hash_words)



#tfidf.get_sample_output_tfidf_csv(tfidf.get_hash_words, tfidf.get_number_of_documents)
#tfidf.get_hash_output(tfidf.get_hash_words)


#tfidf.input_file = File.open("data/sample_output_5000.csv")
#tfidf.get_sample_output_tfidf_csv(tfidf.get_hash_words, tfidf.get_number_of_documents)
#tfidf.input_file = File.open("data/sample_output_hash_num_of_docs_ge_20_tf_ge_1000.csv")

#tfidf.get_hash_words_from_file

#tfidf.input_file = File.open("data/data2/5000.csv")
#tfidf.set_tf
#tfidf.get_hash_output(tfidf.get_hash_words, "data/data2/hash_5000_tf-ge-20.csv")

#tfidf.set_tf


tfidf.input_file = File.open("data/data2/hash_65536_tf-ge-20.csv")
tfidf.get_hash_words_from_file
tfidf.input_file = File.open("data/data2/65536.csv")
#tfidf.get_sample_output_vector_csv(tfidf.get_hash_words, "data/data2/vector_65536_zheng_tf-ge-20.csv")

