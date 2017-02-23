# Change this to POST to a different site
GROUPID = "20329"

def invoke_liferay_api(xml, object, username, password, fid)
  if !object.is_a?(Gallery) || !object.is_a?(Author)
    date = object.date
  else
    date = Date.today
  end
  month = (date.strftime('%m').to_i - 1).to_s
  day = date.strftime('%d')
  year = date.strftime('%Y')
  hour = date.strftime('%k')
  minute = date.strftime('%M')

  title = object.title

  case object
  when ColumnArticle
  	sk = "COLUMN_STRUCTURE"
  	tk = "71711"
  when PublicationArticle
    sk = "ARTICLE_STRUCTURE"
    tk = "71703"
  when Gallery
    sk = "GALLERY_STRUCTURE"
    tk = "71707"
  else
    sk = "AUTHOR_STRUCTURE"
    tk = "PUB_AUTHOR"
  end

  pk = object.id.to_s

  uri = URI.parse("http://localhost:8080/api/jsonws/journalarticle/add-article")
  request = Net::HTTP::Post.new(uri)
  request.basic_auth(username, password)
  request.body = "groupId="+GROUPID+"&folderId="+fid+"&classNameId=0&classPK="+pk+"&articleId=&autoArticleId=true&titleMap={en_US:"+title+"}&descriptionMap={description:"+title+"}&content="+xml.force_encoding('ISO-8859-1').encode('UTF-8')+"&type=general&ddmStructureKey="+sk+"&ddmTemplateKey="+tk+"&layoutUuid=&displayDateMonth="+month+"&displayDateDay="+day+"&displayDateYear="+year+"&displayDateHour="+hour+"&displayDateMinute="+minute+"&expirationDateMonth=12&expirationDateDay=17&expirationDateYear=2017&expirationDateHour=12&expirationDateMinute=12&neverExpire=true&reviewDateMonth=12&reviewDateDay=12&reviewDateYear=2019&reviewDateHour=12&reviewDateMinute=12&neverReview=true&indexable=true&articleURL="

  req_options = {
    use_ssl: uri.scheme == "https",
  }

  response = Net::HTTP.start(uri.hostname, uri.port, req_options) do |http|
    http.request(request)
  end

  if response.body.include? "\"exception\""
    puts "Error with #{object.class}: " + pk
    ap response.body
  end
end

