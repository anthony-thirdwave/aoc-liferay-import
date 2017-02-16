class CNWOnline
	attr_reader :banner, :cover_image, :title, :intro, :author, :content, :date, :id

	def initialize(params)
		@banner = params[0]
		@cover_image = params[1]
		#@title = params[2]
		#@intro = params[3]
		#@author = params[4]
		#@content = params[5]
		@contributors = params[6]
		#@date = params[7]
		#@id = params[8]
	end
end
