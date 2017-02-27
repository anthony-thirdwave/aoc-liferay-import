def import_json(dir)
  json_file = File.read(dir)
  json_file.gsub!('\'', "\"").gsub!("NULL", "\"NULL\"")
  assets = JSON.parse(json_file)
end