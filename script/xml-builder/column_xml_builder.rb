def build_columns_xml(columns, fid)
  progressbar = ProgressBar.create(:total => columns.length)
  columns.each do |column|
    builder = Nokogiri::XML::Builder.new do |xml|
      xml.root('available-locales' => 'en_US', 'default-locale' => 'en_US') {
        xml.send(:"dynamic-element", 'name' => 'Column_Banner', 'type' => 'document_library', 'index-type' => 'keyword', 'index' => '0') {
          xml.send(:"dynamic-content", 'language-id' => 'en_US') {
            xml.cdata ''
          }
        }
        xml.send(:"dynamic-element", 'name' => 'Column_Cover_Image', 'type' => 'document_library', 'index-type' => 'keyword', 'index' => '0') {
          xml.send(:"dynamic-content", 'language-id' => 'en_US') {
            xml.cdata column.cover_image
          }
        }
        xml.send(:"dynamic-element", 'name' => 'Column_Title', 'type' => 'text_box', 'index-type' => 'keyword', 'index' => '0') {
          xml.send(:"dynamic-content", 'language-id' => 'en_US') {
            xml.cdata column.title
          }
        }
        xml.send(:"dynamic-element", 'name' => 'Column_Intro', 'type' => 'text_box', 'index-type' => 'keyword', 'index' => '0') {
          xml.send(:"dynamic-content", 'language-id' => 'en_US') {
            xml.cdata column.intro
          }
        }
        xml.send(:"dynamic-element", 'name' => 'Column_Author', 'type' => 'text_box', 'index-type' => 'keyword', 'index' => '0') {
          xml.send(:"dynamic-content", 'language-id' => 'en_US') {
            xml.cdata column.author
          }
        }
        xml.send(:"dynamic-element", 'name' => 'Column_Content', 'type' => 'text_box', 'index-type' => 'keyword', 'index' => '0') {
          xml.send(:"dynamic-content", 'language-id' => 'en_US') {
            xml.cdata column.content
          }
        }
      }
    end
    # file = File.new("xml/columns-xml/column-#{column.id}.xml", 'w')
    # file.puts builder.to_xml
    invoke_liferay_api(builder.to_xml, column, @username, @password, fid)
    progressbar.increment
  end
  puts "Success!"
end

