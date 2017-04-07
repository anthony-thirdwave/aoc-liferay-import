def grab_images(rotator)
  images = []
  rotator.xpath('//div[@class="rotator_image"]/img').each { |img| images << img["src"] }
  images
end

def create_image_links(images, file)
  img_links = []
  images.each do |img|
    ia = img.gsub(" ", "%20").gsub("í", "%ED").split("/")
    if ia.first == "images"
      img_links << file.split("/")[0..-2].join("/") + ia.join("/").prepend("/")
    elsif ia[1] == "cnwonline"
      img_links << "www.chicagocatholic.com" + img
    elsif ia[3] == "images"
      img_links << "www.chicagocatholic.com/" + ia[3..-1].join("/")
    elsif ia[1] == "News"
      img_links << file.split("/")[0..-3].join("/") + ia[1..-1].join("/").prepend("/")
    elsif ia[1] == "0918"
      img_links << file.split("/")[0..-3].join("/") + ia[1..-1].join("/").prepend("/")
    else
      img_links << img
    end
  end
  img_links
end

def download_images(images, sh_commands)
  images.each do |img|
    folders = img.split("/")[1..-2]
    folders.each { |folder| sh_commands << "mkdir #{folder}"; sh_commands << "cd #{folder}" }
    sh_commands << "wget #{img}"; sh_commands << "cd /Users/anthony.surganov/Documents/LifeRay/aoc-liferay-import/assets/issue_images"
  end
end

def get_issue_credits(rotator)
  captions = []
  rotator.xpath('//div[@class="rotator_image"]/p').children.each { |cap| captions << cap.to_s.strip if cap.to_s[0] != "<" }
  captions
end

def create_galleries(all_images, title, file)
  params = [title, "", all_images[0][0]]
  slider = []
  all_images[0].each_with_index do |img, index|
    slider << [img, all_images[1][index]]
  end
  params << slider
end
