require_relative '../../data.rb'
articles = import_json('json/articles.json')
progressbar = ProgressBar.create(:total => articles.length)
articles.each do |article|
	update_article(@username, @password, article["articleId"], article["urlTitle"])
	progressbar.increment
end