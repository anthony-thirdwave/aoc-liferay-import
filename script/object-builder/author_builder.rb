def create_authors(columns, publications)
	authors = []
	names = (@publications.map(&:author).uniq + @columns.map(&:author).uniq).uniq
	names.each_with_index do |author_name, i|
		authors << Author.new([author_name.gsub("<spanclass=\"title\">", "").gsub("<br>", ""), '', i + 1])
	end
	authors.uniq
end