BADPUBLICATIONS = [
	"www.chicagocatholic.com/cnwonline/2013/0414/5min.aspx",
	"www.chicagocatholic.com/cnwonline/2013/0623/5min.aspx",
	"www.chicagocatholic.com/cnwonline/2013/0707/5min.aspx",
	"www.chicagocatholic.com/cnwonline/2014/0601/9.aspx",
	# NEED TO BE LOOKED AT
	"www.chicagocatholic.com/cnwonline/2016/News/0906b.aspx",
	"www.chicagocatholic.com/cnwonline/2016/News/0929.aspx",
	"www.chicagocatholic.com/cnwonline/2017/0226/8.aspx"
]

HEROIMAGES = [
	"www.chicagocatholic.com/cnwonline/2014/1116/4.aspx",
	"www.chicagocatholic.com/cnwonline/2015/0614/14.aspx",
	"www.chicagocatholic.com/cnwonline/2015/News/0617.aspx",
	"www.chicagocatholic.com/cnwonline/2016/0626/12.aspx"
]

BADCOLUMNS = [
	"www.chicagocatholic.com/cnwonline/2015/News/0824.aspx",
	"www.chicagocatholic.com/cnwonline/2014/News/1118a.aspx",
	"www.chicagocatholic.com/cnwonline/2016/News/1010.aspx"
]

def create_rotator(objects)
	image_store = "./assets/www.chicagocatholic.com/#{objects.first.class}_images"
	FileUtils.rmtree("#{image_store}")
	FileUtils.mkdir("#{image_store}")
	objects.each do |object|
		new_loc = "#{image_store}/#{object.file.split("/").last}-#{object.id}"
		pwd = "/Users/anthony.surganov/Documents/LifeRay/aoc-liferay-import/assets/"
		unless object.rotator.nil?
			new_rotator = []
			creds = []
			object.rotator.each do |node|
				node.xpath('//div[@class="rotator_image"]/img').each do |img|
					if img.attributes["src"].value[0] == "i"
						FileUtils.mkdir(new_loc) unless File.directory?(new_loc)
						dir = object.file.split("/")
						dir.delete(dir.last)
						image_path = pwd + dir.join("/").concat("/").concat(img.attributes["src"].value)
						if File.exist?(image_path)
							FileUtils.cp(image_path, new_loc)
							img_path = (new_loc + "/" + image_path.split("/").last).split("/")[3..-1].join("/").prepend("/")
							new_rotator << img_path
						end
					end
				end
				node.xpath('//div[@class="rotator_image"]/p').each do |cred|
					creds << cred.to_s.gsub(%r{</?[^>]+?>}, '')
				end
			end
			creds.delete(creds.last) if BADCOLUMNS.include? object.file
			object.cover_image = new_rotator[0] if HEROIMAGES.include? object.file
			if HEROIMAGES.include?(object.file) || BADPUBLICATIONS.include?(object.file)
				new_rotator = []
				creds = []
			end
			object.rotator = [new_rotator, creds]
		end
	end
	objects
end

def rewrite_cover_image(objects)
	objects.each do |object|
		if object.cover_image.include? "ads"
			if object.rotator[0].size > 0
				object.cover_image = object.rotator[0].first
			else
				object.cover_image = ""
			end
		end
	end
	objects
end 

def create_related_galleries(objects)
	galleries = []
	objects.each do |object|
		if object.rotator[0].size > 1
			params = []
			params << object.title
			params << ""
			params << object.cover_image
			params << ''
			params << object.file
			params << object.id
			slider = []
			for i in (0..(object.rotator[0].size - 1))
				slider << [object.rotator[0][i], object.rotator[1][i]]
			end
			params[3] = slider
			galleries << Gallery.new(params)
		end
	end
	galleries
end