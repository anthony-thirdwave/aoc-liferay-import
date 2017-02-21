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

FileUtils.mkdir('./xml') unless File.directory?('./xml')

FileUtils.mkdir('./xml/columns-xml') unless File.directory?('./xml/columns-xml')

################################################################################
# VARIABLES
@username = "test@thirdwavellc.com"
@password = "test"
################################################################################

# @columns = create_columns_from_column(get_column_files)
@cnwonline_articles = create_cnwo_from_cnwonline(get_cnwonline_files)
@column_articles = []
@publications = []

@cnwonline_articles.each do |article|
	if article.is_a?(ColumnArticle)
		@column_articles << article
	else
		@publications << article
	end
end