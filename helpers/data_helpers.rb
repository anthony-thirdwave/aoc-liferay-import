def split_articles(articles)
	columns = []
	publications = []
	articles.each do |article|
		if article.is_a?(ColumnArticle)
			columns << article
		else
			publications << article
		end
	end
	[columns, publications]
end

def column_id_rewrite(columns)
	columns.each_with_index do |column, index|
		column.id = index + 1
	end
end