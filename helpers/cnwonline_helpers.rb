def get_cnwonline_files
	files = []
	Dir.glob("#{Dir.pwd}/assets/www.chicagocatholic.com/cnwonline/**/*").each do |file|
		if file.split("/")[-3] != "cnwonline" && file.split("/")[-2] != "cnwonline"
			if !file.include? "?" 
				if !file.include? "images"
					if !file.include? "obit"
						if !file.include? "news"
							if !file.include? "mc"
								if !file.include? "interview"
									if !file.include? "clips"
										if !file.include? "html"
											if !file.include? "htm"
												if !file.include? "pdf"
													if !file.include? "2007/0819/4"
														files << file
													end
												end
											end
										end
									end
								end
							end
						end
					end
				end
			end
		end
	end
	files
end


def remove_whitespaces(string)
	string.gsub(/^ *|(?<= ) | *$/, "")
end

def remove_title_chars(string)
	string.gsub("\r", "").gsub("\t", "").gsub("\n", "").gsub("  ", " ").gsub("’", "'").gsub("‘", "'").gsub("<strong>", "").gsub("</strong>", "").gsub("<span>", "- ").gsub("</span>", "").gsub("<span style=\"display:block; font-size:80%; font-style:italic;\">", "- ").gsub("<span style=\"display:block; font-style:italic; font-size:75%;\">", "- ").gsub("<span class=\"drop-cap\">", "- ").gsub("<span class=\"no_indent\">", ". ")
end

def remove_content_chars(string)
	string.gsub("\r", "").gsub("\t", "").gsub("\n", "")
end

def file_id(file)
	file.split("/").last
end

def get_title(file, f)
	if file_id(file) == "familyroom.aspx" || file_id(file) == "conversations.aspx"
		title = f.xpath('//div[@id="article_head"]/h3').children.to_s
	elsif file_id(file) == "pride.aspx"
		title = "Parish Pride"
	elsif file_id(file) == "cardinal.aspx" || file_id(file) == "cardinal2.aspx" || file_id(file) == "cardinal_pl.aspx"
		title = f.xpath('//div[@id="main_content"]/h3').children.to_s
		title = title.empty? ? f.xpath('//div[@id="article_head"]/h2').children.to_s : title
	else
		title = f.xpath('//div[@id="article_head"]/h2').children.to_s
		title = title.empty? ? f.xpath('//div[@id="article_head"]/h3').children.to_s : title
	end
end

def get_author(file, f)
	if file_id(file) == "barron.aspx" || file_id(file) == "faithculture.aspx"
		author = "Bishop Robert Barron"
	elsif file_id(file) == "familyroom.aspx"
		author = "Michelle Martin"
	elsif file_id(file) == "cardinal.aspx" || file_id(file) == "cardinal2.aspx" || file_id(file) == "cardinal_pl.aspx"
		author = "Cardinal George"
	elsif file_id(file) == "pride.aspx"
		author = "Dolores Madlener"
	else
		author = f.xpath('//div[@id="authorblock"]/p[@class="author"]').children.to_s.gsub("By ", "")
		author = author.empty? || author == "Author" ? "Chicago Catholic" : author
	end
end

def get_date(file)
	year = file.split("/")[-3].to_i
	if file.split("/")[-2] != "News"
		month = file.split("/")[-2][0..1].to_i
		day = file.split("/")[-2][2..3].to_i
	else 
		month = file.split("/")[-1][0..1].to_i
		day = file.split("/")[-1][2..3].to_i
	end
	date = DateTime.new(year, month, day)
end

def get_content(file, f)
	content_array = []

	content = f.xpath('//div[@id="articletext"]/p')
	content = content.empty? ? f.xpath('//div[@id="newsstorytext"]/p') : content
	content = content.empty? ? f.xpath('//div[@id="main_content"]/p') : content
	content = content.empty? ? f.xpath('//div[@class="article"]') : content
	content = content.empty? ? f.xpath('//div[@id="articletext"]') : content

	content.each do |node|
		if node.name != "p"
			node.children.each do |mini_node|
				if mini_node.name != "div"
					if mini_node.name != "script"
						content_array << remove_whitespaces(remove_content_chars(mini_node.to_s))
					end
				end
			end
		else
			content_array << remove_whitespaces(remove_content_chars(node.to_s))
		end
	end

	content_array.map { |s| "#{s}" }.join
end

def get_intro(content)
	intro = content[0..100].gsub("<p class=\"no_indent\">", "").gsub("<p>", "").gsub("<span class=\"drop-cap\">", "").gsub("</span>", "").gsub("<strong>", "").gsub("</strong>", "").gsub("<em>", "").gsub("</em>", "").gsub("<p class=\"about no_indent\">", "").gsub("<p class=\"address\">", "").gsub("</p>", "")

	if intro.include? "<"
		intro = ''
	end

	intro
end

def get_contributors(file)
	case file
	when "/Users/anthony.surganov/Documents/LifeRay/aoc-liferay-import/assets/www.chicagocatholic.com/cnwonline/2008/0427/6.aspx"
		contributors = 'Dennis Stoll of the Vocations Office contributed to this story'
	when "/Users/anthony.surganov/Documents/LifeRay/aoc-liferay-import/assets/www.chicagocatholic.com/cnwonline/2008/0622/1.aspx"
		contributors = 'CNS contributed to this story'
	when "/Users/anthony.surganov/Documents/LifeRay/aoc-liferay-import/assets/www.chicagocatholic.com/cnwonline/2008/1012/1.aspx"
		contributors = 'Catholic News Service contributed to this story'
	when "/Users/anthony.surganov/Documents/LifeRay/aoc-liferay-import/assets/www.chicagocatholic.com/cnwonline/2008/1026/2.aspx"
		contributors = 'Catholic News Service contributed to this story.'
	when "/Users/anthony.surganov/Documents/LifeRay/aoc-liferay-import/assets/www.chicagocatholic.com/cnwonline/2008/1109/5.aspx"
		contributors = 'CNS contributed to this story.'
	when "/Users/anthony.surganov/Documents/LifeRay/aoc-liferay-import/assets/www.chicagocatholic.com/cnwonline/2008/1221/5.aspx"
		contributors = 'Michelle Martin contributed to this story.'
	when "/Users/anthony.surganov/Documents/LifeRay/aoc-liferay-import/assets/www.chicagocatholic.com/cnwonline/2010/0328/1.aspx"
		contributors = 'CNS contributed to this story.'
	when "/Users/anthony.surganov/Documents/LifeRay/aoc-liferay-import/assets/www.chicagocatholic.com/cnwonline/2014/1005/6.aspx"
		contributors = 'Michelle Martin contributed to this story'
	when "/Users/anthony.surganov/Documents/LifeRay/aoc-liferay-import/assets/www.chicagocatholic.com/cnwonline/2015/News/0612a.aspx"
		contributors = "Catholic  News Service and the Office for Divine Worship contributed to this story."
	when "/Users/anthony.surganov/Documents/LifeRay/aoc-liferay-import/assets/www.chicagocatholic.com/cnwonline/2016/News/0805.aspx"
		contributors = "The Catholic  Conference of Illinois contributed to this story."
	else
		contributors = ''
	end
end
