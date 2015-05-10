require 'csv'



questions_csv = CSV.open(File.join("data", "questions_5000.csv"), "r:UTF-8")

clusters = Hash.new     # line => cluster_id
clusters_csv = CSV.open(File.join("data", "kmeans_clusters_110.csv"), "r:UTF-8")
clusters_csv.each do |line|
  line_idx = line[0].to_i
  cluster_id = line[1].to_i
  clusters[line_idx] = cluster_id
end
puts clusters

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
  out_csv = CSV.open(File.join("data", "clusters_" + (i+1).to_s + "_statistics.csv"), "wb:UTF-8")
  line = []
  size = statistics[i+1].size
  line << "size"
  line << size
  out_csv << line

  statistics[i+1].each do |key, value|
    line = []
    line << key
    percentage = value.to_f / size
    line << "%.4f" % percentage

    out_csv << line
  end
  out_csv.flush
  out_csv.close
end