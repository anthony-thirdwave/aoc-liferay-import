require_relative '../../data.rb'

puts "\nBuilding and POSTing Columns to LifeRay..."
build_columns_xml(@columns, @columns_fid)
puts "\nBuilding and POSTing Publications to LifeRay..."
build_publications_xml(@publications, @publications_fid)
puts "\nBuilding and POSTing Galleries to LifeRay..."
build_galleries_xml(@galleries, @galleries_fid)
puts "\nBuilding and POSTing Column Galleries to LifeRay..."
build_galleries_xml(@col_galleries, @col_galleries_fid)
puts "\nBuilding and POSTing Publication Galleries to LifeRay..."
build_galleries_xml(@pub_galleries, @pub_galleries_fid)
puts "\nBuilding and POSTing Authors to LifeRay..."
build_author_xml(@authors, @authors_fid)