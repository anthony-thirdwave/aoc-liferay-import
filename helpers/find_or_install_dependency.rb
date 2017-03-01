def find_or_install_dependency
  gems = {
    'nokogiri' => '~> 1.6.0',
    'ruby-progressbar' => '~> 1.8.1',
    'json' => '~> 2.0'
  }
  gems.each do |key, value|
    gem_name, *gem_ver_reqs = key, value
    gdep = Gem::Dependency.new(gem_name, *gem_ver_reqs)
    found_gspec = gdep.matching_specs.max_by(&:version)

    if found_gspec
      puts "Requirement '#{gdep}' already satisfied by #{found_gspec.name}-#{found_gspec.version}"
    else
      puts "Requirement '#{gdep}' not satisfied; installing..."
      reqs_string = gdep.requirements_list.join(', ')
      system('gem', 'install', gem_name, '-v', reqs_string)
    end
  end
end
