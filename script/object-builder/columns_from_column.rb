def create_columns_from_column(files)
	ds = "/senior_small.jpg"
	ab = "/Archbishop-Cupich-Informal_sm.jpg"
	columns = []

	files.each_with_index do |file, i|
		f = File.open("#{file}") { |f| Nokogiri::HTML(f) }

		d = f.css('#pubdate').children.to_s[1..-1]
		title = file.split("/").last.gsub("-", " ").split.map(&:capitalize).join(' ')

		if file.split("/")[-5] == "donald-senior"
			content = remove_p_tags(f.search('//p')[4..-2].to_s)
			image = ds
		else
			content = remove_p_tags(remove_whitespaces(f.search('//p')[3..-1].to_s))
			image = file.split("/")[-5] == "archbishop-cupich" ? ab : ''
		end
		intro = (content[0..100] + "...").gsub(%r{</?[^>]+?>}, '')

		date_array = d.gsub(",", "").split(" ")
		date_array[1], date_array[2] = date_array[1].to_i, date_array[2].to_i
		
		author = file.split("/")[-5].gsub("-", " ").split.map(&:capitalize).join(' ')
		if author == "Perspectives On Scripture"
			author = "Donald Senior"
			image = ds
		end
		author = author == "Archbishop Cupich" ? "Cardinal Cupich" : author

		author = author.gsub(%r{</?[^>]+?>}, '')
		title = remove_title_entities(title.gsub(%r{</?[^>]+?>}, ''))

		date = get_column_date(file)

		if file.split("/").last != "homily-for-opening-of-the-jubilee-of-mercy"
			params = ['', image, title, author, content.split(" ").join(" "), intro.split(" ").join(" "), '', date, i + 1, file, '']
		else
			params = ['', image.gsub("../../..", ""), title, author, content.split(" ").join(" "), intro.split(" ").join(" "), '', date, 27, file, '']
		end

		if !file.include? "_pl"
			column = ColumnArticle.new(params)
			columns << column 
		end
	end
	columns
end