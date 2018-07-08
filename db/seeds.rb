# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
Employee.create!(first_name: "Jan", last_name: "Kowalski",
  contract_type: "contract of employment", monthly_rate: 3391.00)
Employee.create!(first_name: "Adam", last_name: "Nowak",
  contract_type: "contract agreement", hourly_rate: 13.70)
Employee.create(first_name: "John", last_name: "Doe",
  contract_type: "contract of employment", monthly_rate: 2100.00, provision: 25.00)
