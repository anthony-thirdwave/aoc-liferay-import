def titles_to_csv(articles)
	progressbar = ProgressBar.create(:total => articles.length)
	gsubbed = [
		["%", ""],
		["â", "'"],
		["â", "'"],
		["<em>", ""],
		["</em>", ""],
		['<span style=""display -block font-style -italic font-size -75"">', ""],
		['<span style=""display -block font-size -80 font-style -italic"">', ""],
		['â', '']
	]
	CSV.open("csv/article_titles.csv", "wb") do |line|
	 	articles.each do |article|
 			gsubbed.each do |sub|
 				article.title.gsub!(sub[0], sub[1])
 			end
	 		line << [article.title]
		  progressbar.increment
		end
	end
end

def column_titles_csv(columns)
	progressbar = ProgressBar.create(:total => columns.length)
	gsubbed = [
		["%", ""],
		["â", "'"],
		["â", "'"],
		["<em>", ""],
		["</em>", ""],
		['<span style=""display -block font-style -italic font-size -75"">', ""],
		['<span style=""display -block font-size -80 font-style -italic"">', ""],
		['â', ''],
		["<br clear=""all""> ", '']
	]
	CSV.open("csv/column_titles.csv", "wb") do |line|
	 	columns.each do |column|
 			gsubbed.each do |sub|
 				column.title.gsub!(sub[0], sub[1])
 			end
	 		line << [column.title]
		  progressbar.increment
		end
	end
end