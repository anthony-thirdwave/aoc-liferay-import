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

FileUtils.mkdir('./xml') unless File.directory?('./xml')

FileUtils.mkdir('./xml/columns-xml') unless File.directory?('./xml/columns-xml')
FileUtils.mkdir('./xml/publications-xml') unless File.directory?('./xml/publications-xml')
FileUtils.mkdir('./xml/galleries-xml') unless File.directory?('./xml/galleries-xml')
FileUtils.mkdir('./xml/authors-xml/') unless File.directory?('./xml/authors-xml')

################################################################################
# VARIABLES
@username = "test@thirdwavellc.com"
@password = "test"

@columns_fid = "21219"
@publications_fid = "21225"
@galleries_fid = "21222"
@authors_fid = "21216"
################################################################################

@column_articles = []
@publications = []

@columns = create_columns_from_column((get_column_files << "/Users/anthony.surganov/Documents/LifeRay/aoc-liferay-import/assets/www.chicagocatholic.com/pl/column/archbishop-cupich/2015/12/27/homily-for-opening-of-the-jubilee-of-mercy"))
@cnwonline_articles = create_cnwo_from_cnwonline(get_cnwonline_files)


column_publications = split_articles(@cnwonline_articles)

@column_articles = column_publications[0]
@publications = column_publications[1]
@columns += @column_articles
column_id_rewrite(@columns)


@authors = create_authors(@columns, @publications)
@galleries = create_gallery_objects(get_gallery_files)

# @columns.each do |column|
# 	ap column.file
# 	ap column.all_images
# end