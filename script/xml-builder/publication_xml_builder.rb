BROKENPUBLICATIONS = [
  127,
  169,
  209,
  233,
  251,
  264,
  282,
  301,
  313,
  327,
  375,
  401,
  440,
  444,
  518,
  533,
  542,
  569,
  643,
  733,
  815,
  830,
  840,
  843,
  863,
  889,
  969,
  1015,
  1095,
  1460,
  1495,
  1523,
  1561,
  1686,
  1695
]

def build_publications_xml(publications, fid)
  progressbar = ProgressBar.create(:total => publications.length)
  publications.each do |publication|
    builder = Nokogiri::XML::Builder.new do |xml|
      xml.root('available-locales' => 'en_US', 'default-locale' => 'en_US') {
        xml.send(:"dynamic-element", 'name' => 'Article_Title', 'type' => 'text_box', 'index-type' => 'keyword', 'index' => '0') {
          xml.send(:"dynamic-content", 'language-id' => 'en_US') {
            xml.cdata remove_chars(remove_HTML_entities(publication.title))
          }
        }
        xml.send(:"dynamic-element", 'name' => 'Cover_Image', 'type' => 'document_library', 'index-type' => 'keyword', 'index' => '0') {
          xml.send(:"dynamic-content", 'language-id' => 'en_US') {
            xml.cdata remap_image(publication.cover_image)
          }
        }
        xml.send(:"dynamic-element", 'name' => 'Image_Caption_and_Credit', 'type' => 'text_box', 'index-type' => 'keyword', 'index' => '0') {
          xml.send(:"dynamic-content", 'language-id' => 'en_US') {
            xml.cdata ''
          }
        }
        xml.send(:"dynamic-element", 'name' => 'Article_Intro', 'type' => 'text_box', 'index-type' => 'keyword', 'index' => '0') {
          xml.send(:"dynamic-content", 'language-id' => 'en_US') {
            xml.cdata remove_chars(remove_HTML_entities(publication.intro))
          }
        }
        xml.send(:"dynamic-element", 'name' => 'Author_and_Dept', 'type' => 'text_box', 'index-type' => 'keyword', 'index' => '0') {
          xml.send(:"dynamic-content", 'language-id' => 'en_US') {
            xml.cdata publication.author
          }
        }
        xml.send(:"dynamic-element", 'name' => 'Article_Content', 'type' => 'text_area', 'index-type' => 'keyword', 'index' => '0') {
          xml.send(:"dynamic-content", 'language-id' => 'en_US') {
            xml.cdata remove_chars(remove_HTML_entities(publication.content))
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
    if !BROKENPUBLICATIONS.include?(publication.id.to_i)
      invoke_liferay_api(builder.to_xml, publication, fid)
    end
    progressbar.increment
  end
  puts "Success!"
end

