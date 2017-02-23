def create_authors(columns, publications)
	authors = []
	names = (@publications.map(&:author).uniq + @columns.map(&:author).uniq).uniq
	names.each_with_index do |author_name, i|
		authors << Author.new([author_name, '', i])
	end
	authors
end