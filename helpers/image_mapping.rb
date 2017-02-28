def remap_image(image_path)
	folders = import_json('json/image_folders.json')
	images = import_json('json/images.json')
	tree = [0]
	tree_ascii = image_path.split("/")
	tree_ascii.each do |ascii|
		folders.each do |folder|
			if ascii == folder["name"]
				if tree.last == folder["parentFolderId"]
					tree << folder["folderId"]
				end
			end
		end
	end
	tree -= [0]		
	tree = tree.map { |e| e.to_s }.join("/").prepend("/").concat("/")
	images.each do |image|
		if image["title"] == tree_ascii.last
			if image["treePath"] == tree
				tree = "/documents/" + "20329/" + image["treePath"].split("/")[-1] + "/" + image["title"].gsub(" ", "+") + "/" + image["uuid_"]
			end
		end
	end
	tree
end



