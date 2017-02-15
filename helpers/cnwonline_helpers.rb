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
	files
end

def remove_whitespaces(string)
	string.gsub("\r\n                             ", "").gsub("\r\n                    ", "").gsub("  ", " ")
end

def remove_chars(string)
	string.gsub("Ed<span class=\"title\">i</span>tor Photos by Karen Callaway  ", "").gsub("  Photos by Karen Callaway  ", "").gsub("<br>  \t\t", "").gsub("\t\t  ", "").gsub("<strong>", "").gsub("</strong>", "").gsub("<br> \t", "").gsub("\t", "").gsub("\t\t", "")
end