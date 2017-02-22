COLUMNAUTHORS = [
	"Cardinal Cupich",
	"Father Donald Sr.",
	"Monsignor Michael Boland",
	"Michelle Martin",
	"Bishop Robert Barron",
	"Father James Keenan",
	"Don Wycliff",
	"Kerry Robinson",
	"Cardinal George"
]

def create_cnwo_from_cnwonline(files)
	cnwonline = []
	files.each_with_index do |file, i|
		file_a = file.split("/")[-5..-1].join("/")
		params = ['']
		f = File.open("#{file}") { |f| Nokogiri::HTML(f) }
		params << images = get_image(file, f)
		params << title = remove_whitespaces(remove_title_chars(get_title(file, f)))
		params << author = remove_whitespaces(remove_title_chars(get_author(file, f)))
		params << content = (get_content(file, f).to_s).split(" ").join(" ")
		params << intro = remove_whitespaces(remove_content_chars(get_intro(content))).split(" ").join(" ")
		params << contributors = get_contributors(file)
		params << date = get_date(file)
		params << id = i + 1
		params << p_file = file_a
		params << all_images = get_all_images(file, f)
		if COLUMNAUTHORS.include? params[3]
			cnwonline << ColumnArticle.new(params)
		else
			cnwonline << CNWOnline.new(params)
		end
	end
	cnwonline
end