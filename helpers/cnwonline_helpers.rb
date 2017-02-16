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
	string.gsub("\r\n                             ", "").gsub("\r\n                    ", "").gsub("  ", " ")
end

def remove_chars(string)
	string.gsub("Ed<span class=\"title\">i</span>tor Photos by Karen Callaway  ", "").gsub("  Photos by Karen Callaway  ", "").gsub("<br>  \t\t", "").gsub("\t\t  ", "").gsub("<strong>", "").gsub("</strong>", "").gsub("<br> \t", "").gsub("\t", "").gsub("\t\t", "")
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
	weird_files = [
		"/Users/anthony.surganov/Documents/LifeRay/aoc-liferay-import/assets/www.chicagocatholic.com/cnwonline/2008/0330/1.aspx",
		"/Users/anthony.surganov/Documents/LifeRay/aoc-liferay-import/assets/www.chicagocatholic.com/cnwonline/2008/0511/4.aspx",
		"/Users/anthony.surganov/Documents/LifeRay/aoc-liferay-import/assets/www.chicagocatholic.com/cnwonline/2008/0608/4.aspx",
		"/Users/anthony.surganov/Documents/LifeRay/aoc-liferay-import/assets/www.chicagocatholic.com/cnwonline/2009/0510/4.aspx",
		"/Users/anthony.surganov/Documents/LifeRay/aoc-liferay-import/assets/www.chicagocatholic.com/cnwonline/2010/0523/1.aspx",
		"/Users/anthony.surganov/Documents/LifeRay/aoc-liferay-import/assets/www.chicagocatholic.com/cnwonline/2010/0704/1.aspx",
		"/Users/anthony.surganov/Documents/LifeRay/aoc-liferay-import/assets/www.chicagocatholic.com/cnwonline/2011/1120/1.aspx",
		"/Users/anthony.surganov/Documents/LifeRay/aoc-liferay-import/assets/www.chicagocatholic.com/cnwonline/2014/0615/3.aspx",
		"/Users/anthony.surganov/Documents/LifeRay/aoc-liferay-import/assets/www.chicagocatholic.com/cnwonline/2014/0727/3.aspx",
		"/Users/anthony.surganov/Documents/LifeRay/aoc-liferay-import/assets/www.chicagocatholic.com/cnwonline/2014/0810/3.aspx",
		"/Users/anthony.surganov/Documents/LifeRay/aoc-liferay-import/assets/www.chicagocatholic.com/cnwonline/2016/0724/8.aspx",
		"/Users/anthony.surganov/Documents/LifeRay/aoc-liferay-import/assets/www.chicagocatholic.com/cnwonline/2016/0724/9.aspx"
	]

	content = f.xpath('//div[@id="articletext"]/p')
	content = content.empty? ? f.xpath('//div[@id="newsstorytext"]/p') : content
	content = content.empty? ? f.xpath('//div[@id="main_content"]/p') : content
	content = content.empty? ? f.xpath('//div[@class="article"]') : content
	content = content.empty? ? f.xpath('//div[@id="articletext"]') : content

	# if weird_files.include? file
	# 	puts '##################################################################################################################################################################'
	# 	puts "--------------#{file}"
	# 	ap content
	# end
end