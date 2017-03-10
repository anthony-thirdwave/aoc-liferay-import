BROKENCOLUMNS = [
  97,
  116,
  160,
  179,
  181,
  192,
  200,
  211,
  320,
  339,
  412,
  415,
  431,
  434,
  498,
  511,
  517,
  530,
  549,
  581,
  600,
  625,
  636,
  644,
  655,
  710,
  729,
  767,
  786,
  815
]

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
            xml.cdata empty_cover_image(remap_image(column.cover_image))
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
        xml.send(:"dynamic-element", 'name' => 'Column_Content', 'type' => 'text_area', 'index-type' => 'keyword', 'index' => '0') {
          xml.send(:"dynamic-content", 'language-id' => 'en_US') {
            xml.cdata remove_p_tags(remove_content_chars(column.content).gsub("<<", "<").gsub(">>", ">"))
          }
        }
      }
    end
    file = File.new("xml/columns-xml/column-#{column.id}.xml", 'w')
    file.puts builder.to_xml
    # if !BROKENCOLUMNS.include?(column.id.to_i)
    #   invoke_liferay_api(builder.to_xml, column, fid)
    # end
    progressbar.increment
  end
  puts "Success!"
end