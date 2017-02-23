class Author
	attr_accessor :name, :about, :id

	def initialize(params)
		@name = params[0]
		@about = params[1]
		@id = params[2]
	end
end