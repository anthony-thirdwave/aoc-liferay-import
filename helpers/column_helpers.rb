def get_column_files
	files = []
	Dir.glob("#{Dir.pwd}/assets/www.chicagocatholic.com/column/**/*").each do |file|
		if file.split("/").last.include? "-"
			if !file.split("/").last.include? "?"
				files << file if file.split("/")[-6].include? "column"
			end
		end
	end
	files
end

def remove_entities(string)
	string.gsub("<p>", "").gsub("</p>", "").gsub("  ", " ").gsub("	", " ").gsub("“", "\"").gsub(",", "").gsub(":", "").gsub(";", "").gsub("%", " percent").gsub("&", " and ").gsub("/", " ").gsub("<strong>", "").gsub("< strong>", "").gsub("<em>", "").gsub("< em>", " ").gsub("”", "\"")
end

def remove_whitespaces(string)
	string.gsub("\r\n", " ").gsub("      ", " ").gsub("       ", " ").gsub("       ", " ").gsub("     ", " ")
end