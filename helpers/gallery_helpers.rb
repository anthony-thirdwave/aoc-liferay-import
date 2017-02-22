def get_gallery_files
	files = []
	Dir.glob("#{Dir.pwd}/assets/www.chicagocatholic.com/galleries/*").each do |file|
		files << file if file.include? "img"
	end
	final_files = sort_files(files)
end

def sort_files(files)
	sorted_files = []
	final_files = []
	files.each do |file|
		sorted_files << [file.split("&").last, file.split("&").first].join("&")
	end
	sorted_files.sort!
	sorted_files.each do |file|
		final_files << [file.split("&").last, file.split("&").first].join("&")
	end
	final_files
end

def get_gallery_id(file)
	file.split("=").last
end

def get_gallery_title(f)
	remove_content_chars(f.xpath('//h2[@id="GalleryTitle"]').children.to_s).split(" ").join(" ")
end

def get_gallery_intro(f)
	nokogiri = f.xpath('//p[@id="GalleryDescription"]').children
	nokogiri.empty? ? '' : remove_content_chars(nokogiri.to_s).split(" ").join(" ")
end

def get_gallery_image(f)
	f.xpath('//div[@id="Image"]').children[1].attributes["src"].value
end

def get_credit_caption(f)
	remove_content_chars(f.xpath('//p[@id="ImageCredit"]').children.to_s).split(" ").join(" ")
end

def get_gallery_params(file, f)
	params = []
	params << get_gallery_title(f)
	params << get_gallery_intro(f)
	params << ''
	params << ''
	params << file
	params << ''
end