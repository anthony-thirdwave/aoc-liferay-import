def remove_HTML_entities(string)
	entities = [
		['&#8221;', "\""],
		["&#8220;", "\""],
		["&#8217;", "'"],
		["&#8212;", "-"],
		[" &#8211;", "-"],
		["<em>", ""],
		["</em>", ""],
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

def remove_content_chars(string)
	chars = [
		[":", " -"],
		["&", "and"],
		["%", " percent"]
	]
	chars.each do |char|
		string.gsub!(char[0], char[1])
	end
	string
end

def remove_title_entities(string)
	chars = [
		["â\u0080\u0098", "'"],
		["â\u0080\u0099", "'"],
		["â\u0080\u009C", ""],
		["â\u0080\u009D", ""]
	]
	chars.each do |char|
		string.gsub!(char[0], char[1])
	end
	string
end

def empty_cover_image(string)
	string == "//" ? "" : string
end

def get_pdf(res)
	if !res.external_url.empty?
    if res.external_url[-4..-1] != ".pdf"
    	File.open("no_pdfs.txt", 'a') { |file| file.puts res.nid}
    else
      open('pdfs/' + res.external_url.split("/").last, 'wb') { |file| file << open(res.external_url).read }
    end
  else
    if !bad_pdfs.include? res.filepath
      open('pdfs/' + res.filepath.split("/").last, 'wb') { |file| file << open("http://www.avisonyoung.com/"+res.filepath.gsub(" ", "%20")).read }
    end
  end
end