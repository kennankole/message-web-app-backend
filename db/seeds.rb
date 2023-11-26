require 'roo'
# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)
excel = Roo::Excelx.new('./db/branch_data.xlsx')
header = excel.row(1).map(&:strip)

(2..excel.last_row).each do |i|
  row_data = Hash[header.zip(excel.row(i).map { |val| val.to_s.strip })]

  user_identity = "CU#{row_data['User ID']}"
  user = User.find_or_create_by(user_identity: user_identity) do |u|
    u.email = "#{user_identity}@branch.com"
    u.password = Devise.friendly_token[0, 20]
  end

  Question.create!(
    user: user,
    body: row_data['Message Body']
  )
end
