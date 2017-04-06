task :default do
	ARGV.each { |a| task a.to_sym do ; end }
	if ARGV[1].nil?
		puts "Sorry, command not understood. Please use: \n$ rake -T\nto see a list of all available rake tasks."
	end
end

namespace :api do
	desc 'POSTs columns, galleries, publications, and authors to LifeRay'
	task :all do
		ruby 'script/dependencies.rb'
		ruby 'script/api-call/all.rb'
	end

	desc 'POSTs columns to LifeRay'
	task :columns do
		ruby 'script/dependencies.rb'
		ruby 'script/api-call/columns_api.rb'
	end

	desc 'POSTs galleries to LifeRay'
	task :galleries do
		ruby 'script/dependencies.rb'
		ruby 'script/api-call/galleries_api.rb'
	end

	desc 'POSTs publications to LifeRay'
	task :publications do
		ruby 'script/dependencies.rb'
		ruby 'script/api-call/publications_api.rb'
	end

	desc 'POSTs authors to LifeRay'
	task :authors do
		ruby 'script/dependencies.rb'
		ruby 'script/api-call/authors_api.rb'
	end
end

desc 'Creates a CSV of all article titles.'
task :csv do
	ruby 'script/dependencies.rb'
	ruby 'script/build_csv.rb'
end

desc 'Generates and POSTs LifeRay associations'
task :sql do
	ruby 'script/sql_builder.rb'
	puts "\nAdding JournalArticle relations to database..."
	sh 'sh sql/import_relations.sh'
	puts "Success!"
end

desc 'Test functions'
task :test do
	ruby 'script/dependencies.rb'
	puts "\nTesting Functions..."
	ruby 'test.rb'
end

