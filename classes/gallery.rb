class Gallery
	attr_accessor :title, :intro, :cover_image, :gallery, :file, :id

	def initialize(params)
		@title = params[0]
		@intro = params[1]
		@cover_image = params[2]
		@gallery = params[3]
		@file = params[4]
		@id = params[5]
	end
end