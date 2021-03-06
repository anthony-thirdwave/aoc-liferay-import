def build_galleries_xml(galleries, fid)
  progressbar = ProgressBar.create(:total => galleries.length)
  galleries.each do |gallery|
    builder = Nokogiri::XML::Builder.new do |xml|
      xml.root('available-locales' => 'en_US', 'default-locale' => 'en_US') {
        xml.send(:"dynamic-element", 'name' => 'Gallery_Title', 'type' => 'text', 'index-type' => 'keyword', 'index' => '0') {
          xml.send(:"dynamic-content", 'language-id' => 'en_US') {
            xml.cdata gallery.title.force_encoding('ISO-8859-1').encode('UTF-8')
          }
        }
        xml.send(:"dynamic-element", 'name' => 'Gallery_Intro', 'type' => 'text_box', 'index-type' => 'keyword', 'index' => '0') {
          xml.send(:"dynamic-content", 'language-id' => 'en_US') {
            xml.cdata gallery.intro.force_encoding('ISO-8859-1').encode('UTF-8').gsub("&amp;", "and")
          }
        }
        xml.send(:"dynamic-element", 'name' => 'Gallery_Cover_Image', 'type' => 'document_library', 'index-type' => 'keyword', 'index' => '0') {
          xml.send(:"dynamic-content", 'language-id' => 'en_US') {
            xml.cdata gallery.gallery[0][0]
          }
        }
        gallery.gallery.each_with_index do |content, index|
          xml.send(:"dynamic-element", 'name' => 'Gallery_Slide', 'type' => 'selection_break', 'index-type' => 'keyword', 'index' => index) {
            xml.send(:"dynamic-element", 'name' => 'Gallery_Image', 'index' => index, 'type' => 'document_library', 'index-type' => 'keyword') {
              xml.send(:"dynamic-content", 'language-id' => 'en_US') {
                xml.cdata content[0]
              }
            }
            xml.send(:"dynamic-element", 'name' => 'Caption_and_Credit', 'index' => index, 'type' => 'text_box', 'index-type' => 'keyword') {
              xml.send(:"dynamic-content", 'language-id' => 'en_US') {
                xml.cdata content[1].force_encoding('ISO-8859-1').encode('UTF-8').gsub("&amp;", "and")
              }
            }
          }
        end
      }
    end
    case galleries
    when @col_galleries
      # file = File.new("xml/galleries-xml/columns/gallery-#{gallery.id}.xml", 'w')
      # file.puts builder.to_xml
      invoke_liferay_api(builder.to_xml, gallery, fid)
    when @pub_galleries
      # file = File.new("xml/galleries-xml/publications/gallery-#{gallery.id}.xml", 'w')
      # file.puts builder.to_xml
      invoke_liferay_api(builder.to_xml, gallery, fid)
    else
      # file = File.new("xml/galleries-xml/galleries/gallery-#{gallery.id}.xml", 'w')
      # file.puts builder.to_xml
      invoke_liferay_api(builder.to_xml, gallery, fid)
    end
    progressbar.increment
  end
  puts "Success!"
end