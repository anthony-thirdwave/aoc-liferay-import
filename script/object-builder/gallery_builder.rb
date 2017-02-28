def create_gallery_objects(files)
	galleries = []
	slider = []
	params = []
	gallery_tracker = get_gallery_id(files.first)
	files.each do |file|
		f = File.open("#{file}") { |f| Nokogiri::HTML(f) }
		if gallery_tracker == get_gallery_id(file)
			if params.empty?
				params = get_gallery_params(file, f)
			end
			slider << [remap_image(get_gallery_image(f)), get_credit_caption(f)]
		else
			params[3] = slider
			params[5] = gallery_tracker
			galleries << Gallery.new(params)
			params = get_gallery_params(file, f)
			slider = []
			slider << [remap_image(get_gallery_image(f)), get_credit_caption(f)]
			gallery_tracker = get_gallery_id(file)
		end
	end
	galleries
end