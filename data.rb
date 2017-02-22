Dir["./helpers/*.rb"].each { |file| require file }
Dir["./classes/*.rb"].each { |file| require file }
Dir["./script/xml-builder/*.rb"].each { |file| require file }
Dir["./script/object-builder/*.rb"].each { |file| require file }
require 'ruby-progressbar'
require 'fileutils'
require 'nokogiri'
require 'net/http'
require 'json'
require 'pp'
require 'uri'
require 'date'
require 'awesome_print'
require 'pry'

FileUtils.mkdir('./xml') unless File.directory?('./xml')

FileUtils.mkdir('./xml/columns-xml') unless File.directory?('./xml/columns-xml')
FileUtils.mkdir('./xml/publications-xml') unless File.directory?('./xml/publications-xml')
FileUtils.mkdir('./xml/galleries-xml') unless File.directory?('./xml/galleries-xml')

################################################################################
# VARIABLES
@username = "test@thirdwavellc.com"
@password = "test"

@columns_fid = 23007
@publications_fid = 23010
@galleries_fid = 23013
################################################################################

@column_articles = []
@publications = []

@columns = create_columns_from_column((get_column_files << "/Users/anthony.surganov/Documents/LifeRay/aoc-liferay-import/assets/www.chicagocatholic.com/pl/column/archbishop-cupich/2015/12/27/homily-for-opening-of-the-jubilee-of-mercy"))
@cnwonline_articles = create_cnwo_from_cnwonline(get_cnwonline_files)


column_publications = split_articles(@cnwonline_articles)

@publications = column_publications[1]
@column_articles = column_publications[0]
@columns += @column_articles

@galleries = create_gallery_objects(get_gallery_files)

column_id_rewrite(@columns)