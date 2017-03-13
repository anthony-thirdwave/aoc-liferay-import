require_relative '../data.rb'

col_galleries = import_json('json/col_galleries.json')
columns = import_json('json/columns.json')

pub_galleries = import_json('json/pub_galleries.json')
publications = import_json('json/publications.json')

puts "\nCreating Column - Galleries associations... Creating SQL Query file..."
g_col = associate_content(col_galleries, columns)
puts "\nCreating Publications - Galleries associations... Creating SQL Query file..."
g_pub = associate_content(pub_galleries, publications)

marker = 0
marker = build_sql(g_pub["galleries"], g_pub["articles"], marker)
build_sql(g_col["galleries"], g_col["articles"], marker)

file = File.new('sql/import_relations.sh', 'w')
lines = [
	"mysql -u root < sql/integer-gallery-0.sql",
	"mysql -u root < sql/integer-gallery-82.sql"
]
file.puts lines