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

FileUtils.mkdir('./xml') unless File.directory?('./xml')

FileUtils.mkdir('./xml/columns-xml') unless File.directory?('./xml/columns-xml')

################################################################################
# VARIABLES
@username = "test@thirdwavellc.com"
@password = "test"
################################################################################

@columns = create_columns(get_column_files)
