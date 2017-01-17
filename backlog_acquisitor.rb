#!/usr/bin/env ruby

require 'backlog_kit'
require 'csv'

client = BacklogKit::Client.new

project_key = ENV['BACKLOG_PROJECT_KEY']
result = client.get("/projects/#{project_key}")
project_id = result.body.id

result = client.get("/projects/#{project_key}/categories")
p result.body
CSV.open("data/categories.csv", "wb") do |csv|
  csv << ['プロジェクト', 'カテゴリー']
  result.body.each do |resource|
    category_name = resource.name
    csv << [category_name]
  end
end

result = client.get('issues', project_id: [project_id])
p result.body
#CSV.open("data/issues.csv", "wb") do |csv|
#  csv << ['カテゴリー']
#  result.body.each do |resource|
#    category_name = resource.name
#    csv << [category_name]
#  end
#end

