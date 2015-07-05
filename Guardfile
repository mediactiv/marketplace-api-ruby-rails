guard 'rspec',cmd: 'rspec --color --format doc' do	
  # watch /app/ files
  watch(%r{^app/(.+).rb$}) do |m|
    "spec/#{m[1]}_spec.rb"
  end
end