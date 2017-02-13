require 'nokogiri'

f = File.open('assets/www.chicagocatholic.com/cnwonline/2017/0129/7.aspx') { |f| Nokogiri::HTML(f) }

# puts f

puts article_date = f.css('#pubdate')[0].children

puts article_title = f.css('#ArticleTitle').children

puts article_author = f.css('#authorblock').children[3].children

f.xpath('//comment()').remove
f.css('div#articletext')[0].children.search('script').remove
img = f.css('div#articletext')[0].css('div[id=ImageRotator]')
f.css('div#articletext')[0].children.search('div[id=ImageRotator]').remove
article_text = f.css('div#articletext')[0].children
puts article_text

filename = img.search('img').empty? ? '' : img.search('img').attr('src').to_s.split("/").last
puts filename