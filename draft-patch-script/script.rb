require 'json'

# Variables
################################################################################
URL = "http://localhost:8080/api/jsonws/journalarticle/update-status"
GROUPID = "20329"
STATUS = "2" # https://docs.liferay.com/portal/6.2/javadocs/constant-values.html#com.liferay.portal.kernel.workflow.WorkflowConstants.STATUS_DRAFT

@username = "test@thirdwavellc.com"
@password = "test"
################################################################################


def update_article(articleID, articleURL)
  uri = URI.parse(URL)
  request = Net::HTTP::Post.new(uri)
  request.basic_auth(@username, @password)
  request.body = "groupId="+GROUPID+"&articleId="+articleID+"&version=1.0&status="+STATUS+"&articleURL="+articleURL

  req_options = {
    use_ssl: uri.scheme == "https",
  }

  response = Net::HTTP.start(uri.hostname, uri.port, req_options) do |http|
    http.request(request)
  end

  if response.body.include? "\"exception\""
    puts "Error PATCHing articleURL: " + articleURL
    ap response.body
  end
end

def import_json(dir)
  JSON.parse(File.read(dir))
end
  
puts "\nPatching Articles..."
articles = import_json('articles.json')
articles.each do |article|
  update_article(article["articleId"], article["urlTitle"])
end