def build_publications_xml(publications, fid)
  progressbar = ProgressBar.create(:total => publications.length)
  publications.each do |publication|
    builder = Nokogiri::XML::Builder.new do |xml|
      xml.root('available-locales' => 'en_US', 'default-locale' => 'en_US') {
        xml.send(:"dynamic-element", 'name' => 'Article_Title', 'type' => 'text_box', 'index-type' => 'keyword', 'index' => '0') {
          xml.send(:"dynamic-content", 'language-id' => 'en_US') {
            xml.cdata publication.title
          }
        }
        xml.send(:"dynamic-element", 'name' => 'Cover_Image', 'type' => 'document_library', 'index-type' => 'keyword', 'index' => '0') {
          xml.send(:"dynamic-content", 'language-id' => 'en_US') {
            xml.cdata publication.cover_image
          }
        }
        xml.send(:"dynamic-element", 'name' => 'Image_Caption_and_Credit', 'type' => 'text_box', 'index-type' => 'keyword', 'index' => '0') {
          xml.send(:"dynamic-content", 'language-id' => 'en_US') {
            xml.cdata ''
          }
        }
        xml.send(:"dynamic-element", 'name' => 'Article_Intro', 'type' => 'text_box', 'index-type' => 'keyword', 'index' => '0') {
          xml.send(:"dynamic-content", 'language-id' => 'en_US') {
            xml.cdata publication.intro
          }
        }
        xml.send(:"dynamic-element", 'name' => 'Author_and_Dept', 'type' => 'text_box', 'index-type' => 'keyword', 'index' => '0') {
          xml.send(:"dynamic-content", 'language-id' => 'en_US') {
            xml.cdata publication.author
          }
        }
        xml.send(:"dynamic-element", 'name' => 'Article_Content', 'type' => 'text_area', 'index-type' => 'keyword', 'index' => '0') {
          xml.send(:"dynamic-content", 'language-id' => 'en_US') {
            xml.cdata publication.content
          }
        }
        xml.send(:"dynamic-element", 'name' => 'Contributors', 'type' => 'text_box', 'index-type' => 'keyword', 'index' => '0') {
          xml.send(:"dynamic-content", 'language-id' => 'en_US') {
            xml.cdata publication.contributors
          }
        }
      }
    end
    # file = File.new("xml/publications-xml/publication-#{publication.id}.xml", 'w')
    # file.puts builder.to_xml
    invoke_liferay_api(builder.to_xml, publication, @username, @password, fid)
    progressbar.increment
  end
  puts "Success!"
end

