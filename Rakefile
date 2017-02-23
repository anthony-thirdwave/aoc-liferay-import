task :default do 
	ARGV.each { |a| task a.to_sym do ; end } 
	if ARGV[1].nil?
		puts "Sorry, command not understood. Please use $ rake api <columns> or $ rake api_all to make the api calls."
	end
end

namespace :api do
	task :all do
		ruby 'script/dependencies.rb'
		ruby 'script/api-call/all.rb'
	end

	task :columns do
		ruby 'script/dependencies.rb'
		ruby 'script/api-call/columns_api.rb'
	end

	task :galleries do
		ruby 'script/dependencies.rb'
		ruby 'script/api-call/galleries_api.rb'
	end

	task :publications do
		ruby 'script/dependencies.rb'
		ruby 'script/api-call/publications_api.rb'
	end

	task :authors do
		ruby 'script/dependencies.rb'
		ruby 'script/api-call/authors_api.rb'
	end
end
