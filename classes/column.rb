class Column
	attr_reader :banner, :cover_image, :title, :intro, :author, :content, :date, :id

	def initialize(params)
		@banner = params[0]
		@cover_image = params[1]
		@title = params[2]
		@intro = params[3]
		@author = params[4]
		@content = params[5]
		@date = params[6]
		@id = params[7]
	end
end
