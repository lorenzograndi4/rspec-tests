source 'https://rubygems.org'

ruby '2.4.1'

git_source(:github) do |repo_name|
  repo_name = "#{repo_name}/#{repo_name}" unless repo_name.include?("/")
  "https://github.com/#{repo_name}.git"
end

gem 'open-uri'
gem 'nokogiri'

group :development, :test do
  gem 'rspec'
  gem 'webmock/rspec'
end
