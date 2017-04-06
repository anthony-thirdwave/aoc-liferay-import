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

def get_issue_columns
  files = []
  Dir.glob("#{Dir.pwd}/assets/2016_test_issues/www.chicagocatholic.com/column/**/*").each do |file|
    if file.split("/").last.include? "-"
      if file.split("/")[-2] != "column"
        files << file
      end
    end
  end
  files
end

def remove_entities(string)
  string.gsub("<p>", "").gsub("  ", " ").gsub("	", " ").gsub("“", "\"").gsub(",", "").gsub(":", "").gsub(";", "").gsub("%", " percent").gsub("&", " and ").gsub("”", "\"")
end

def remove_whitespaces(string)
  string.gsub("\r\n", " ").gsub("      ", " ").gsub("       ", " ").gsub("       ", " ").gsub("     ", " ")
end

def get_column_date(file)
  year = file.split("/")[-4].to_i
  month = file.split("/")[-3].to_i
  day = file.split("/")[-2].to_i
  date = DateTime.new(year, month, day)
end

def remove_p_tags(string)
  bad_tags = [
    ["<p id=\"carchive_link\" style=\"padding-top10px margin-top10px border-top1px solid #818181\">", "<p>"],
    ["<p style=\"margin-bottom0\">", "<p>"],
    ["<p class=\"prev-article-link article-link\">", "<p>"],
    ["<p class=\"next-article-link article-link\">", "<p>"],
    ["<p id=\"column_title\">", "<p>"],
    ["<p class=\"about no_indent\">", "<p>"],
    ["<p style=\"margin-top:4px;\">", "<p>"],
    ["<p id=\"carchive_link\">", "<p>"],
    ["<p id=\"pubdate\">", "<p>"],
    ["p class=\"no_indent\">", "<p>"],
    ["<p style=\"margin-left:15px;\">", "<p>"],
    ["<p style=\"text-align:center\">", "<p>"],
    ["<p class=\"author\">", "<p>"],
    ["<p class=\"title\">", "<p>"],
    ["<p style=\"text-align:right;\">", "<p>"],
    ["<p style=\"text-align:right; font-style:italic;\">", "<p>"],
    ["<p class=\"about\">", "<p>"],
    ["<p class=\"no_indent\" style=\"text-align:right\">", "<p>"],
    ["<p style=\"text-align:right\">", "<p>"],
    ["<p style=\"margin-bottom:8px;\">", "<p>"],
    ["<p class=\"nav_on\">", "<p>"],
    ["<p style=\"margin-bottom:8px; text-align:right\">", "<p>"],
    ["<p style=\"text-align:right; \">", "<p>"],
    ["<p class=\"no_indent about\">", "<p>"],
    ["<p style=\"text-align:center; \">", "<p>"],
    ["<p class=\"no_indent\" style=\"text-align:right; \">", "<p>"],
    ["<p style=\"text-align:center;\">", "<p>"],
    ["<p class=\"about\" style=\"text-align:right\">", "<p>"],
    ["<p style=\"text-align:right \">", "<p>"],
    ["<p class=\"address\">", "<p>"],
    ["<span class=\"drop-cap\">", "<span>"],
    [" class=\"more\"", ""],
    [" class=\"pullquote\"", ""],
    [" class=\"pull_quote\"", ""],
    [" style=\"float:right; margin:0 0 10px 10px;\"", ""],
    [" style=\"float:right; margin:0 0 10px 10px; height:200px\"", ""],
    [" style=\"float:right; margin:0 0 10px 10px;\"", ""],
    [" style=\"text-transform:uppercase;\"", ""],
    [" style=\"float:right; margin-left:8px;\"", ""],
    [" style=\"padding-top -10px; margin-top -10px; border-top -1px solid #818181;\"", ""],
    [" class=\"no_indent\" style=\"text-align -right\"", ""],
    [" class=\"no_indent\" style=\"text-align -right; \"", ""],
    [" class=\"about\" style=\"text-align -right\"", ""],
    ["<p style=\"margin-top -4px;\">", "<p>"],
    ["<p style=\"margin-left -15px;\">", "<p>"],
    ["<p style=\"text-align -center\">", "<p>"],
    ["<p style=\"text-align -right;\">", "<p>"],
    ["<p style=\"text-align -right; font-style -italic;\">", "<p>"],
    ["<p style=\"text-align -right\">", "<p>"],
    ["<p style=\"margin-bottom -8px;\">", "<p>"],
    ["<p style=\"margin-bottom -8px; text-align -right\">", "<p>"],
    ["<p style=\"text-align -right; \">", "<p>"],
    ["<p style=\"text-align -right \">", "<p>"],
    ["<p style=\"text-align -center; \">", "<p>"],
    ["<p style=\"text-align -center;\">", "<p>"],
    ["<p style=\"margin-bottom -0;\">", "<p>"],
    ["<p style=\"margin-bottom -0;\">", "<p>"],
    ["<p id=\"carchive_link\" style=\"padding-top -10px; margin-top -10px; border-top -1px solid #818181;\">", "<p>"],
    ["<!-- InstanceBeginEditable name=\"Articletext\" --> <!-- InstanceEndEditable -->", ""]
  ]
  bad_tags.each { |tag| string.gsub!(tag[0], tag[1]) }
  string
end
