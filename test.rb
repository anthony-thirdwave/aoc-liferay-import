Dir["./helpers/*.rb"].each { |file| require file }
Dir["./classes/*.rb"].each { |file| require file }
Dir["./script/xml-builder/*.rb"].each { |file| require file }
Dir["./script/object-builder/*.rb"].each { |file| require file }
require 'ruby-progressbar'
require 'fileutils'
require 'nokogiri'
require 'net/http'
require 'json'
require 'csv'
require 'pp'
require 'uri'
require 'date'
require 'awesome_print'
require 'pry'

#logfile = CSV.read('assets/logfile.csv', {:quote_char => "\x00", :col_sep => "\t" })
#file = File.new('assets/wget2.txt', 'w')
#lines = []
#logfile[1..-1].each do |row|
  #if row[3] == "catholicnewworld.com"
    #lines << "wget #{row[1].gsub("%3A", ":")}"
  #end
#end
#file.puts lines.uniq

#f = File.open("/Users/anthony.surganov/Documents/LifeRay/aoc-liferay-import/assets/archive2016.htm") { |f| Nokogiri::HTML(f) }
#ap f
#wget_files = []
#f.xpath('//div[@id="leadins"]/h2').children.each { |child| wget_files << child.attributes["href"].value.prepend("wget -p -nc ") if !child.attributes["href"].nil? }
#f.xpath('//div[@id="toc"]/ul/li').children.each { |child| wget_files << child.attributes["href"].value.prepend("wget -p -nc ") if !child.attributes["href"].nil? }

#sh_file = File.new("assets/2016_test_issues/build_structures.sh", "w")
#sh_commands = []
#wget_files.each do |file|
  #file_array = file.split(" ")
  #uri = URI(file_array.last)
  #folders = uri.path.split("/")[1..-2]
  #folders.each { |folder| sh_commands << "mkdir #{folder}"; sh_commands << "cd #{folder}" }
  #sh_commands << file
  #sh_commands << "cd /Users/anthony.surganov/Documents/LifeRay/aoc-liferay-import/assets/2016_test_issues"
#end

#sh_file.puts sh_commands

columns = create_columns_from_column(get_issue_columns)
cnwonline_articles = create_cnwo_from_cnwonline(get_cnwonline_issue_files)
column_publications = split_articles(cnwonline_articles)

publications = column_publications[1]
columns += column_publications[0]
column_id_rewrite(columns)
authors = create_authors(columns, publications)

#@sh_commands = []
#publications.each { |publication| publication.all_images = create_image_links(grab_images(publication.rotator), publication.file) }
#publications.each { |pub| download_images(pub.all_images, @sh_commands) }

#file = File.new("assets/issue_images/grab_images.sh", "w")
#file.puts @sh_commands

publications.each { |pub| pub.all_images = [create_image_links(grab_images(pub.rotator), pub.file), get_issue_credits(pub.rotator)] }
publications.each { |pub| create_galleries(pub.all_images, pub.title, pub.file) }

#columns = rewrite_cover_image(create_rotator(columns))
#publications = rewrite_cover_image(create_rotator(publications))


#col_galleries = create_related_galleries(columns)
#pub_galleries = create_related_galleries(publications)

#FileUtils.mkdir('./xml/2016_issues') unless File.directory?('./xml/2016_issues')
#FileUtils.mkdir('./xml/2016_issues/galleries-xml') unless File.directory?('./xml/2016_issues/galleries-xml')
#FileUtils.mkdir('./xml/2016_issues/galleries-xml/galleries') unless File.directory?('./xml/2016_issues/galleries-xml/galleries')
#FileUtils.mkdir('./xml/2016_issues/galleries-xml/columns') unless File.directory?('./xml/2016_issues/galleries-xml/columns')
#FileUtils.mkdir('./xml/2016_issues/galleries-xml/publications') unless File.directory?('./xml/2016_issues/galleries-xml/publications')
#FileUtils.mkdir('./xml/2016_issues/columns-xml') unless File.directory?('./xml/2016_issues/columns-xml')
#FileUtils.mkdir('./xml/2016_issues/publications-xml') unless File.directory?('./xml/2016_issues/publications-xml')
#FileUtils.mkdir('./xml/2016_issues/authors-xml') unless File.directory?('./xml/2016_issues/authors-xml')

#columns_fid, publications_fid, col_galleries_fid, pub_galleries_fid, authors_fid = 0, 0, 0, 0, 0

#puts "\nBuilding and POSTing Columns to LifeRay..."
#build_columns_xml(columns, columns_fid)
#puts "\nBuilding and POSTing Publications to LifeRay..."
#build_publications_xml(publications, publications_fid)
#puts "\nBuilding and POSTing Authors to LifeRay..."
#build_author_xml(authors, authors_fid)
#puts "\nBuilding and POSTing Column Galleries to LifeRay..."
#build_galleries_xml(col_galleries, col_galleries_fid)
#puts "\nBuilding and POSTing Publication Galleries to LifeRay..."
#build_galleries_xml(pub_galleries, pub_galleries_fid)



















