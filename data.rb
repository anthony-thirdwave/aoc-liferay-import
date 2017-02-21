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
require 'pry-rescue'
require 'pry-stack_explorer'

COLUMNAUTHORS = [
	"Cardinal Cupich",
	"Father Donald Sr.",
	"Monsignor Michael Boland",
	"Michelle Martin",
	"Bishop Robert Barron",
	"Father James Keenan",
	"Don Wycliff",
	"Kerry Robinson",
	"Cardinal George"
]

FileUtils.mkdir('./xml') unless File.directory?('./xml')

FileUtils.mkdir('./xml/columns-xml') unless File.directory?('./xml/columns-xml')

################################################################################
# VARIABLES
@username = "test@thirdwavellc.com"
@password = "test"
################################################################################

# @columns = create_columns_from_column(get_column_files)
@cnwonline_articles = create_cnwo_from_cnwonline(get_cnwonline_files)

@cnwonline_articles.each do |article|
	puts article.file
	p article.cover_image
end