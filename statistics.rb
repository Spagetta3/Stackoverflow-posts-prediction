require 'csv'

iterations =
[
["vector_5000_tf-20_clusters.csv", "5000.csv", "vector_5000_tf-20_clusters_"],
["vector_5000_tf-20_idf-100_clusters.csv", "5000.csv", "vector_5000_tf-20_idf-100_clusters_"],
["vector_5000_zheng_tf-20_clusters.csv", "5000_zheng.csv", "vector_5000_zheng_tf-20_clusters_"],
["vector_5000_zheng_tf-ge-20_idf-ge-100_clusters.csv", "5000_zheng.csv", "vector_5000_zheng_tf-ge-20_idf-ge-100_clusters_"],
["vector_65536_tf-ge-20_idf-ge-200_clusters.csv", "65536.csv", "vector_65536_tf-ge-20_idf-ge-200_clusters_"],
["vector_65536_tf-ge-20_idf-ge-1000_clusters.csv", "65536.csv", "vector_65536_tf-ge-20_idf-ge-1000_clusters_"],
["vector_65536_zheng_tf-ge-20_idf-ge-1000_clusters.csv", "65536_zheng.csv", "vector_65536_zheng_tf-ge-20_idf-ge-1000_clusters_"],
["vector_double_5000_tf-ge-20_clusters.csv", "5000.csv", "vector_double_5000_tf-ge-20_clusters_"],
["vector_double_5000_tf-ge-20_idf-ge-100_clusters.csv", "5000.csv", "vector_double_5000_tf-ge-20_idf-ge-100_clusters_"],
["vector_double_5000_zheng_tf-ge-20_clusters.csv", "5000_zheng.csv", "vector_double_5000_zheng_tf-ge-20_clusters_"],
["vector_double_5000_zheng_tf-ge-20_idf-ge-100_clusters.csv", "5000_zheng.csv", "vector_double_5000_zheng_tf-ge-20_idf-ge-100_clusters_"],
["vector_double_65536_tf-ge-20_idf-ge-200_clusters.csv", "65536.csv", "vector_double_65536_tf-ge-20_idf-ge-200_clusters_"],
["vector_double_65536_tf-ge-20_idf-ge-1000_clusters.csv", "65536_zheng.csv", "vector_double_65536_tf-ge-20_idf-ge-1000_clusters_"],
["vector_double_65536_zheng_tf-ge-20_idf-ge-1000_clusters.csv", "65536_zheng.csv", "vector_double_65536_zheng_tf-ge-20_idf-ge-1000_clusters_"],
#["", "", ""],
#["", "", ""]
]


iterations.each do |array|
  puts array.join("|")

  clusters = Hash.new     # line => cluster_id
  clusters_csv = CSV.open(File.join("data2","clusters", array[0]), "r:UTF-8")
  clusters_csv.each do |line|
    line_idx = line[0].to_i
    cluster_id = line[1].to_i
    clusters[line_idx] = cluster_id
  end
  puts clusters

  questions_csv = CSV.open(File.join("data2", "questions", array[1]), "r:UTF-8")

  statistics = Hash.new
  line = 1
  questions_csv.each do |content|
    tag_count = content[3].to_i
    cluster_id = clusters[line]

    #puts tag_count
    # puts cluster_id
    hashes = statistics[cluster_id]
    if(hashes == nil)
      hashes = Hash.new
      statistics[cluster_id] =hashes
    end

    tag_count.times do |idx|
      # puts content[4 + idx]
      if(hashes[content[4+idx]] == nil)
        hashes[content[4+idx]] = 1
      else
        hashes[content[4+idx]] += 1
      end
    end
    #puts hashes
    line += 1
  end

  puts statistics

  statistics.size.times do |i|
    out_csv = CSV.open(File.join("data2", array[2] + "" + (i+1).to_s + "_statistics.csv"), "wb:UTF-8")
    #line = []
    #size = statistics[i+1].size
    #line << "size"
    #line << size
    #out_csv << line

    statistics[i+1].each do |key, value|
      line = []
      line << key
      line << value
      #percentage = value.to_f / size
      #line << "%.4f" % percentage

      out_csv << line
    end
    out_csv.flush
    out_csv.close
  end
end
