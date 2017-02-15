def create_cnwo_from_cnwonline(files)
	columns = []
	counter = 0
	files.each_with_index do |file, i|
		f = File.open("#{file}") { |f| Nokogiri::HTML(f) }
		# puts f
		puts '##################################################################################################################################################################'
		puts "--------------#{file}"
		author = remove_chars(remove_whitespaces(f.xpath('//p[@class="author"]').children.to_s.gsub("By", "")))
		author = author == "Author" ? '' : author
		ap title = f.css('#article_head')
		# puts f
	end
end