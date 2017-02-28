def remove_HTML_entities(string)
	entities = [
		['&#8221;', "\""],
		["&#8220;", "\""],
		["&#8217;", "'"],
		["&#8212;", "-"],
		[" &#8211;", "-"],
		["<em>", ""],
		["</em>", ""]
	]
	entities.each do |entity|
		string.gsub!(entity[0], entity[1])
	end
	string
end

def remove_chars(string)
	chars = [
		[":", " -"],
		["&", "and"],
		["%", " percent"],
		["/", "-"]
	]
	chars.each do |char|
		string.gsub!(char[0], char[1])
	end
	string
end