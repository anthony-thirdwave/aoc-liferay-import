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
		if file.split("/").last == "5min.aspx"
			image = "/images/cnw/logos/5Min.png"
		elsif file.split("/").last == "pride.aspx"
			image = "/images/cnw/logos/parishpride.png"
		elsif file.split("/").last == "familyroom.aspx"
			image = "/images/cnw/logos/familyroom.jpg"
		else
			image = get_image(file, f)
			image = image.include?("katolik.gif") ? "" : image
		end
		params << image.gsub("../../..", "")
		params << title = remove_title_entities(remove_whitespaces(remove_title_chars(get_title(file, f))).gsub(%r{</?[^>]+?>}, ''))
		params << author = remove_whitespaces(remove_title_chars(get_author(file, f))).split(" ").join(" ").gsub(%r{</?[^>]+?>}, '')
		params << content = remove_p_tags((get_content(file, f).to_s).split(" ").join(" "))
		params << intro = remove_whitespaces(remove_content_chars(get_intro(content))).split(" ").join(" ")
		params << contributors = get_contributors(file).gsub(%r{</?[^>]+?>}, '')
		params << date = get_date(file)
		params << id = i + 1
		params << p_file = file_a
		params << all_images = get_all_images(file, f)
		if COLUMNAUTHORS.include? params[3]
			if !file.include? "_pl"
				cnwonline << ColumnArticle.new(params)
			end
		else
			cnwonline << PublicationArticle.new(params)
		end
	end
	cnwonline
end