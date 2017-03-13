require_relative 'data.rb'

(1..(@pub_galleries.length * 2)).each do |i|
	if i.even? then next end
	ap i.to_s + " | " + (i+1).to_s
end

ap (@pub_galleries.length)