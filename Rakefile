task :default do 
	ARGV.each { |a| task a.to_sym do ; end } 
	if ARGV[1].nil?
		puts "Sorry, command not understood. Please use $ rake api <columns> or $ rake api_all to make the api calls."
	end
end

task :api_all do
	ruby 'script/dependencies.rb'
	ruby 'script/api-call/all.rb'
end

task :xml do
	task :columns do
		ruby 'script/dependencies.rb'
		ruby 'script/object-builder/columns.rb'
	end
end
