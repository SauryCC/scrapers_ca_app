require 'csv'
require 'open-uri'

File.open('posts.js', 'w') do |f|
  f.write "var posts = {}\n"

  %w(pe ns nb qc on mb sk ab bc).each do |type_id|
    f.write %(posts['ocd-division/country:ca/province:#{type_id}'] = []\n)
    CSV.parse(open("https://raw.github.com/opencivicdata/ocd-division-ids/master/identifiers/country-ca/province-#{type_id}-electoral_districts.csv")) do |row|
      f.write %(posts['ocd-division/country:ca/province:#{type_id}'].push("#{row[1]}")\n)
    end
  end

  [ 'ca_census_subdivisions',
  ].each do |filename|
    CSV.parse(open("https://raw.github.com/opencivicdata/ocd-division-ids/master/identifiers/country-ca/#{filename}.csv")) do |row|
      f.write %(posts['#{row[0]}'] = ["#{row[1]}"]\n)
    end
  end

  [ 'ca_municipal_subdivisions',
  ].each do |filename|
    CSV.parse(open("https://raw.github.com/opencivicdata/ocd-division-ids/master/identifiers/country-ca/#{filename}.csv")) do |row|
      identifier, _, pair = row[0].rpartition('/')
      f.write %(posts['#{identifier}'].push("#{row[1]}")\n)
      if pair[/:\d+\z/]
        alternative_name = pair.capitalize.sub(':', ' ')
        f.write %(posts['#{identifier}'].push("#{alternative_name}")\n) unless row[1] == alternative_name
      end
    end
  end
end
