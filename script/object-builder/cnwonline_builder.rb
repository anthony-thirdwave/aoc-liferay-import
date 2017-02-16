def create_cnwo_from_cnwonline(files)
	columns = []
	counter = 0
	files.each_with_index do |file, i|
		f = File.open("#{file}") { |f| Nokogiri::HTML(f) }
		date = get_date(file)
		title = remove_whitespaces(remove_title_chars(get_title(file, f)))
		author = get_author(file, f)
		content = get_content(file, f)
		intro = get_intro(content)
		contributors = get_contributors(file)
		id = i + 1
		p '##################################################################################################################################################################################################################################################################'
		ap file
		ap contributors
	end
end
