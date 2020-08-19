# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
require 'date'

Review.destroy_all
Booking.destroy_all
Favori.destroy_all
User.destroy_all

puts 'Creating 4 fake users'
User.create(
  first_name: "Maxime",
  last_name: "Alexandre",
  email: "alexandre.maxime666@gmail.com",
  password: "starwars",
  address: "70 Rue de la République, 13002 Marseille",
  mobile_number: "0607080901",
  role: "helper",
  diploma: "Certification Parkinson",
  description: "fan de star wars",
  price: "12"
)

User.create(
  first_name: "Anthony",
  last_name: "Manto",
  email: "anthony.manto8@gmail.com",
  password: "azerty",
  address: "Cours Mirabeau, Aix en provence",
  mobile_number: "0607080902",
  role: "helper",
  diploma: "Certification Parkinson",
  description: "fan de Berserk",
  price: "12"
)

User.create(
  first_name: "Sebastien",
  last_name: "Coppolani",
  email: "seb.coppo@gmail.com",
  password: "azerty2",
  address: "3 boulevard michelet, 13008 Marseille",
  mobile_number: "0607080903",
  role: "senior",
  description: "fan de l'OM"
)

User.create(
  first_name: "Bastion",
  last_name: "Malgouyres",
  email: "bast.malg@gmail.com",
  password: "azerty3",
  address: "Avenue des belges, Aix en provence",
  mobile_number: "0607080903",
  role: "senior",
  description: "fan de l'OM"
)

puts 'Finished!'
