require_relative '../../data.rb'
build_columns_xml(@columns, @columns_fid)
build_publications_xml(@publications, @publications_fid)
build_galleries_xml(@galleries, @galleries_fid)
build_galleries_xml(@col_galleries, @col_galleries_fid)
build_galleries_xml(@pub_galleries, @pub_galleries_fid)
build_author_xml(@authors, @authors_fid)