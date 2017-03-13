# Change this to POST to a different site
GROUPID = "20329"

def invoke_liferay_api(xml, object, fid)
  if object.is_a?(Gallery)
    date = Date.today
  elsif object.is_a?(Author)
    date = Date.today
  else
    date = object.date
  end
  month = (date.strftime('%m').to_i - 1).to_s
  day = date.strftime('%d')
  year = date.strftime('%Y')
  hour = date.strftime('%k')
  minute = date.strftime('%M')

  if object.is_a?(Gallery)
    title = object.title.force_encoding('ISO-8859-1').encode('UTF-8').gsub("'", "")
  elsif object.is_a?(Author)
    title = object.name
  else
    title = object.title.gsub("/", "-").gsub("&amp", "and")
  end

  case object
  when ColumnArticle
  	sk = "COLUMN_STRUCTURE"
  	tk = "110602"
  when PublicationArticle
    sk = "ARTICLE_STRUCTURE"
    tk = "109324"
  when Gallery
    sk = "GALLERY_STRUCTURE"
    tk = "GALLERY_TEMPLATE"
  else
    sk = "AUTHOR_STRUCTURE"
    tk = "PUB_AUTHOR"
  end

  pk = object.id.to_s


  uri = URI.parse("http://localhost:8080/api/jsonws/journalarticle/add-article")
  request = Net::HTTP::Post.new(uri)
  request.basic_auth(@username, @password)
  request.body = "groupId="+GROUPID+"&folderId="+fid+"&classNameId=0&classPK="+pk+"&articleId=&autoArticleId=true&titleMap={en_US:"+title+"}&descriptionMap={description:"+title+"}&content="+remove_hex(xml)+"&type=general&ddmStructureKey="+sk+"&ddmTemplateKey="+tk+"&layoutUuid=&displayDateMonth="+month+"&displayDateDay="+day+"&displayDateYear="+year+"&displayDateHour="+hour+"&displayDateMinute="+minute+"&expirationDateMonth=12&expirationDateDay=17&expirationDateYear=2017&expirationDateHour=12&expirationDateMinute=12&neverExpire=true&reviewDateMonth=12&reviewDateDay=12&reviewDateYear=2019&reviewDateHour=12&reviewDateMinute=12&neverReview=true&indexable=true&articleURL="

  req_options = {
    use_ssl: uri.scheme == "https",
  }

  response = Net::HTTP.start(uri.hostname, uri.port, req_options) do |http|
    http.request(request)
  end

  if response.body.include? "\"exception\""
    ap "Error POSTing #{object.class}: #{pk} - #{title}"
    ap xml
  end
end

def remove_hex(string)
  chars = [
    ["\xE2\x80\x99", "'"],
    ["\xE2\x80\x9C", "'"],
    ["\xE2\x80\x9D", "'"]
  ]

  chars.each { |char| string.gsub!(char[0], char[1]) }
  string
end