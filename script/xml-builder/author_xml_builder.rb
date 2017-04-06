BROKENAUTHORS = [
  24,
  25,
  26,
  30,
  34,
  42,
  48,
  56,
  74,
  84,
  91,
  110
]
def build_author_xml(authors, fid)
  progressbar = ProgressBar.create(:total => authors.length)
  authors.each do |author|
    builder = Nokogiri::XML::Builder.new do |xml|
      xml.root('available-locales' => 'en_US', 'default-locale' => 'en_US') {
        xml.send(:"dynamic-element", 'name' => 'About_the_Author', 'type' => 'text_area', 'index-type' => 'keyword', 'index' => '0') {
          xml.send(:"dynamic-content", 'language-id' => 'en_US') {
            xml.cdata "<strong>#{author.name}</strong>"
          }
        }
      }
    end
    if fid == 0
      file = File.new("xml/2016_issues/authors-xml/author-#{author.id}.xml", "w")
      file.puts builder.to_xml
    else
      file = File.new("xml/authors-xml/author-#{author.id}.xml", 'w')
      file.puts builder.to_xml
    end
    #if !BROKENAUTHORS.include?(author.id.to_i)
      #invoke_liferay_api(builder.to_xml, author, fid)
    #end
    progressbar.increment
  end
  puts "Success!"
end
