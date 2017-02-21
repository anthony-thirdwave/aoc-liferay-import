def create_cnwo_from_cnwonline(files)
	cnwonline = []
	files.each_with_index do |file, i|
		file_a = file.split("/")[-5..-1].join("/")
		params = ['']
		f = File.open("#{file}") { |f| Nokogiri::HTML(f) }
		params << images = get_images(file, f)
		params << title = remove_whitespaces(remove_title_chars(get_title(file, f)))
		params << author = remove_whitespaces(remove_title_chars(get_author(file, f)))
		params << content = get_content(file, f).to_s
		params << intro = remove_whitespaces(remove_content_chars(get_intro(content)))
		params << contributors = get_contributors(file)
		params << date = get_date(file)
		params << id = i + 1
		params << p_file = file_a
		cnwonline << CNWOnline.new(params)
	end
	cnwonline
end