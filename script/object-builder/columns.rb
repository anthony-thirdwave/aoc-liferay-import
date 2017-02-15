def create_columns(files)
	ds = "senior_small.jpg"
	ab = "Archbishop-Cupich-Informal_sm.jpg"
	columns = []

	files.each_with_index do |file, i|
		f = File.open("#{file}") { |f| Nokogiri::HTML(f) }

		d = f.css('#pubdate').children.to_s[1..-1]
		title = file.split("/").last.gsub("-", " ").split.map(&:capitalize).join(' ')
		file
		filler = f.xpath('//p[@class = "prev-article-link article-link"]').to_s

		if file.split("/")[-5] == "donald-senior"
			content = remove_entities(f.search('//p')[4..-2].to_s.gsub(filler, ""))
			filename = ds
		else
			content = remove_whitespaces(remove_entities(f.search('//p')[3..-1].to_s.gsub(filler, ""))).gsub("<p id=\"column_title\">Perspectives on ScriptureJanuary 8 2017 <a href=\"http  www.usccb.org bible readings 010817.cfm\" target=\"_blank\">The Epiphany of the Lord< a><br>  ", "").gsub("<a href=\"http  www.chicagocatholic.com column archbishop-cupich 2016 08 07 a-church-that-teaches-and-learns\">", "").gsub("<a href=\"http  www.chicagocatholic.com column archbishop-cupich 2016 07 24 families-the-privileged-place-of-gods-revelation\">", "").gsub("< a>", "").gsub("<p class=\"next-article-link article-link\"><a href=\" column donald-senior 2017 01 15 what-am-i-called-to\">Next Second Sunday in Ordinary Time", "")
			filename = file.split("/")[-5] == "archbishop-cupich" ? ab : ''
		end

		intro = content[0..49] + "..."

		author = file.split("/")[-5].gsub("-", " ").split.map(&:capitalize).join(' ')

		date_array = d.gsub(",", "").split(" ")
		date_array[1], date_array[2] = date_array[1].to_i, date_array[2].to_i
		date = DateTime.new(date_array[2], Date::MONTHNAMES.index(date_array[0]), date_array[1])

		if author == "Perspectives On Scripture"
			author = "Donald Senior"
			filename = ds
		end

		params = ['', filename, title, intro, author, content, date, i]
		column = Column.new(params)

		columns << column 
	end
	columns
end