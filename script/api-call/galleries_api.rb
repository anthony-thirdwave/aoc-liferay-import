require_relative '../../data.rb'
puts "\nBuilding XML Structures for General Galleries... Calling LifeRay API..."
build_galleries_xml(@galleries, @galleries_fid)
puts "\nBuilding XML Structures for Column Galleries... Calling LifeRay API..."
build_galleries_xml(@col_galleries, @col_galleries_fid)
puts "\nBuilding XML Structures for Publication Galleries... Calling LifeRay API..."
build_galleries_xml(@pub_galleries, @pub_galleries_fid)