def build_sql(galleries, articles, marker)
	file = File.new("sql/#{articles.first.class.to_s.downcase}-gallery-#{marker.to_s}.sql", "w")
	lines = []
	counter = 0
	(marker..(marker + galleries.length * 2)).each do |i|
		if i.even? then next end
		line1 = "INSERT INTO `aoc_default_portal`.`AssetLink` (`linkId`, `companyId`, `userId`, `userName`, `createDate`, `entryId1`, `entryId2`, `type_`, `weight`) VALUES ('#{i}', '20302', '20346', 'Test Test', '2017-03-10 20:37:24', '#{galleries[counter]}', '#{articles[counter]}', '0', '0');"
		line2 = "INSERT INTO `aoc_default_portal`.`AssetLink` (`linkId`, `companyId`, `userId`, `userName`, `createDate`, `entryId1`, `entryId2`, `type_`, `weight`) VALUES ('#{i + 1}', '20302', '20346', 'Test Test', '2017-03-10 20:37:24', '#{articles[counter]}', '#{galleries[counter]}', '0', '0');"
    lines << line1
    lines << line2
    counter += 1
	end
  file.puts lines
  marker += (galleries.length * 2)
end

def associate_content(galleries, articles)
	progressbar = ProgressBar.create(:total => galleries.length)
	ids = { "galleries" => [], "articles" => [] }
	assets = import_json('json/asset_entries.json')
	galleries.each do |gallery|
		articles.each do |article|
			if gallery["classPk"] == article["classPk"]
				assets.each do |asset|
					ids["galleries"] << asset["entryId"] if gallery["resourcePrimKey"] == asset["classPK"]
					ids["articles"] << asset["entryId"] if article["resourcePrimKey"] == asset["classPK"]
				end
			end
		end
		progressbar.increment
	end
	ids
end
