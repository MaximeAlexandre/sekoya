# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
require 'date'

Review.destroy_all
Favori.destroy_all
Task.destroy_all
Diploma.destroy_all
Booking.destroy_all
User.destroy_all

puts 'Creating 5 fake seniors...'
User.create(
  first_name: "Jean paul",
  last_name: "Belmondo",
  email: "jean-paul.belmondo@gmail.com",
  password: "azertyuiop",
  address: "70 Rue de la République, 13002 Marseille",
  mobile_number: "0607080901",
  role: "senior",
  photo: "https://i.pinimg.com/564x/78/20/f5/7820f5c991ced2c7d5f42a71662c2cf6.jpg"
)

User.create(
  first_name: "Guy",
  last_name: "Tare",
  email: "guy.tare@gmail.com",
  password: "azerty2",
  address: "Cours Julien, 13006 Marseille",
  mobile_number: "0689754534",
  role: "senior",
  photo: "https://figurants.com/oc-content/uploads/119/12020.jpg"
)

User.create(
  first_name: "Ginette",
  last_name: "Delacroix",
  email: "ginette.delacroix@gmail.com",
  password: "123456",
  address: "150 Rue Paradis, 13006 Marseille",
  mobile_number: "0745389721",
  role: "senior",
  photo: "https://i.pinimg.com/originals/dc/58/dd/dc58dd29018ea05feba4a3d27e34e9c3.jpg"
)

User.create(
  first_name: "Veronique",
  last_name: "De Perse",
  email: "veronique.de-perse@gmail.com",
  password: "987654",
  address: "35 Avenue de Mazargues, Marseille",
  mobile_number: "0645389723",
  role: "senior",
  photo: "https://static.actu.fr/uploads/2019/10/52422310b2088478af1b58ee2811f4bad289c15f7368a7294282f7496a84510bfd19495c-854x568.jpg"
)

User.create(
  first_name: "Germaine",
  last_name: "Delaplace",
  email: "germaine.delaplace@gmail.com",
  password: "azerty",
  address: "33 rue thomassin lyon",
  mobile_number: "0756349876",
  role: "senior",
  photo: "https://images.unsplash.com/photo-1447005497901-b3e9ee359928?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=967&q=80"
)

puts "...Seniors creation finished"

puts "Creating 5 fake female helpers in Lyon..."
helper1 = User.new(
  first_name: "Pauline",
  last_name: "Florens",
  email: "pauline.florens@lewagon.org",
  password: "azerty",
  address: "rue de la charité, 69002 Lyon",
  mobile_number: "0645893723",
  role: "helper",
  description: "Entretenir la maison de la personne accompagnée, en faisant le ménage, les petits travaux d'entretien et de réparation nécessaires, la lessive et le repassage.\
                Subvenir aux besoins alimentaires, depuis les courses jusqu'à la prise des repas.\
                Aider à l'autonomie physique, en assistant la marche, le réveil et le coucher.",
  price: "20",
  photo: "https://ca.slack-edge.com/T02NE0241-UHZPDCTL7-9f02287d72ad-512"
)

helper2 = User.new(
  first_name: "Valerie",
  last_name: "Gregoix",
  email: "valerie.gregoix@gmail.com",
  password: "azerty",
  address: "20 Rue burdeau, 69001 Lyon",
  mobile_number: "0689348273",
  role: "helper",
  description: "Entretenir la maison de la personne accompagnée, en faisant le ménage, les petits travaux d'entretien et de réparation nécessaires, la lessive et le repassage.\
                Subvenir aux besoins alimentaires, depuis les courses jusqu'à la prise des repas.\
                Aider à l'autonomie physique, en assistant la marche, le réveil et le coucher.",
  price: "30",
  photo: "https://images.generated.photos/m-X6WsWGaIcWmZS6WzeVS6mT8mtL4Qc2OqbRbMSRRHM/rs:fit:256:256/Z3M6Ly9nZW5lcmF0/ZWQtcGhvdG9zL3Yz/XzAyOTI2MTQuanBn.jpg"
)

helper3 = User.new(
  first_name: "Aurore",
  last_name: "Pinçon",
  email: "aurore.pincon@gmail.com",
  password: "azerty",
  address: "77 Rue Duquesne, 69006 Lyon",
  mobile_number: "0645903421",
  role: "helper",
  description: "Entretenir la maison de la personne accompagnée, en faisant le ménage, les petits travaux d'entretien et de réparation nécessaires, la lessive et le repassage.\
                Subvenir aux besoins alimentaires, depuis les courses jusqu'à la prise des repas.\
                Aider à l'autonomie physique, en assistant la marche, le réveil et le coucher.",
  price: "15",
  photo: "https://images.generated.photos/Kx0rWsHEaHYJfnyKQ2F2NYMDW0Dw01XM78bwut1LUw8/rs:fit:256:256/Z3M6Ly9nZW5lcmF0/ZWQtcGhvdG9zL3Yz/XzA5NzI1MTQuanBn.jpg"
)

helper4 = User.new(
  first_name: "Raquel",
  last_name: "Murillo",
  email: "raquel.murillo@gmail.com",
  password: "azerty",
  address: "61 Cours Gambetta 69003 Lyon",
  mobile_number: "0734298710",
  role: "helper",
  description: "Entretenir la maison de la personne accompagnée, en faisant le ménage, les petits travaux d'entretien et de réparation nécessaires, la lessive et le repassage.\
                Subvenir aux besoins alimentaires, depuis les courses jusqu'à la prise des repas.\
                Aider à l'autonomie physique, en assistant la marche, le réveil et le coucher.",
  price: "18",
  photo: "https://images.generated.photos/0IaqV1Hx_aHnX0XfiaBQ6X6QACzahBz9IGXwndnhMEI/rs:fit:256:256/Z3M6Ly9nZW5lcmF0/ZWQtcGhvdG9zL3Yz/XzA5NzQ5NjEuanBn.jpg"
)

helper5 = User.new(
  first_name: "Danielle",
  last_name: "Roger",
  email: "danielle.roger@gmail.com",
  password: "azerty",
  address: "1 Rue du Bélier 69002 Lyon",
  mobile_number: "0645983401",
  role: "helper",
  description: "Entretenir la maison de la personne accompagnée, en faisant le ménage, les petits travaux d'entretien et de réparation nécessaires, la lessive et le repassage.\
                Subvenir aux besoins alimentaires, depuis les courses jusqu'à la prise des repas.\
                Aider à l'autonomie physique, en assistant la marche, le réveil et le coucher.",
  price: "25",
  photo: "https://images.generated.photos/MaDcv47jIe8_YaOCjSw8KMp8TGgntDiJZ3mUYvEUjy8/rs:fit:256:256/Z3M6Ly9nZW5lcmF0/ZWQtcGhvdG9zL3Yz/XzAxMjk3MDIuanBn.jpg"
)

puts '...Helpers creation Finished!'


puts "Creating 5 fake male helpers in Lyon..."
helper6 = User.new(
  first_name: "Victor",
  last_name: "Faud",
  email: "victor.faud@gmail.com",
  password: "azerty",
  address: "142 Grande Rue de la Guillotière 69007 Lyon",
  mobile_number: "0678459328",
  role: "helper",
  description: "Entretenir la maison de la personne accompagnée, en faisant le ménage, les petits travaux d'entretien et de réparation nécessaires, la lessive et le repassage.\
                Subvenir aux besoins alimentaires, depuis les courses jusqu'à la prise des repas.\
                Aider à l'autonomie physique, en assistant la marche, le réveil et le coucher.",
  price: "40",
  photo: "https://images.generated.photos/CSATONvRC9keZlwb9PUw4oLqgJLqk81qfuKyRit1SOI/rs:fit:256:256/Z3M6Ly9nZW5lcmF0/ZWQtcGhvdG9zL3Yz/XzAzMzI1ODBfMDkx/NDY0MV8wNTQ1MDcx/LmpwZw.jpg"
)

helper7 = User.new(
  first_name: "Alain",
  last_name: "Laporte",
  email: "alain.laporte@gmail.com",
  password: "azerty",
  address: "179 Avenue Lacassagne 69003 Lyon",
  mobile_number: "0745832918",
  role: "helper",
  description: "Entretenir la maison de la personne accompagnée, en faisant le ménage, les petits travaux d'entretien et de réparation nécessaires, la lessive et le repassage.\
                Subvenir aux besoins alimentaires, depuis les courses jusqu'à la prise des repas.\
                Aider à l'autonomie physique, en assistant la marche, le réveil et le coucher.",
  price: "35",
  photo: "https://images.generated.photos/e95zMhqDrBWx-r-h6i8fUnIQZ0ZmaIrQggB3U4jUWYU/rs:fit:256:256/Z3M6Ly9nZW5lcmF0/ZWQtcGhvdG9zL3Yz/XzAyNTAyMTNfMDMx/NDAwOF8wMDY3OTM1/LmpwZw.jpg"
)

helper8 = User.new(
  first_name: "Fabien",
  last_name: "Lauby",
  email: "fabien.lauby@gmail.com",
  password: "azerty",
  address: "38 Rue Jean Jaurès 69100 Villeurbanne",
  mobile_number: "0738943783",
  role: "helper",
  description: "Entretenir la maison de la personne accompagnée, en faisant le ménage, les petits travaux d'entretien et de réparation nécessaires, la lessive et le repassage.\
                Subvenir aux besoins alimentaires, depuis les courses jusqu'à la prise des repas.\
                Aider à l'autonomie physique, en assistant la marche, le réveil et le coucher.",
  price: "12",
  photo: "https://images.generated.photos/AocIc2LuUhr1UHLbnB_Ia89vW7xNtpKHlA-cXHK6Sz4/rs:fit:256:256/Z3M6Ly9nZW5lcmF0/ZWQtcGhvdG9zL3Yz/XzA4MjE4NDRfMDcx/MzI4Nl8wMjE0Njk2/LmpwZw.jpg"
)

helper9 = User.new(
  first_name: "Pierre",
  last_name: "Valoix",
  email: "pierre.valoix@gmail.com",
  password: "azerty",
  address: "60 Rue de l'Abondance 69003 Lyon",
  mobile_number: "06589372892",
  role: "helper",
  description: "Entretenir la maison de la personne accompagnée, en faisant le ménage, les petits travaux d'entretien et de réparation nécessaires, la lessive et le repassage.\
                Subvenir aux besoins alimentaires, depuis les courses jusqu'à la prise des repas.\
                Aider à l'autonomie physique, en assistant la marche, le réveil et le coucher.",
  price: "13",
  photo: "https://images.generated.photos/J8LElKhm6YfUaeJR_xgEk8Jt3WPVh7Dxv4CUGZPq6KQ/rs:fit:256:256/Z3M6Ly9nZW5lcmF0/ZWQtcGhvdG9zL3Yz/XzAyNjg2NjdfMDQ0/MjY4OF8wNzg4MzQ0/LmpwZw.jpg"
)

helper10 = User.new(
  first_name: "Justin",
  last_name: "Deprec",
  email: "justin.deprec@gmail.com",
  password: "azerty",
  address: "106 Avenue Maréchal de Saxe 69003 Lyon",
  mobile_number: "0634832987",
  role: "helper",
  description: "Entretenir la maison de la personne accompagnée, en faisant le ménage, les petits travaux d'entretien et de réparation nécessaires, la lessive et le repassage.\
                Subvenir aux besoins alimentaires, depuis les courses jusqu'à la prise des repas.\
                Aider à l'autonomie physique, en assistant la marche, le réveil et le coucher.",
  price: "15",
  photo: "https://images.generated.photos/HPHniRqwQMNv0vYt2LfsuLejbMxBXh-_Fr3mTRa4Z-Y/rs:fit:256:256/Z3M6Ly9nZW5lcmF0/ZWQtcGhvdG9zL3Yz/XzA2NDU0NjJfMDE5/MTI1N18wMjk3MDY1/LmpwZw.jpg"
)

puts '...Helpers creation Finished!'

puts "Creating Antho Helper..."
helper11 = User.new(
  first_name: "Anthony",
  last_name: "Manto",
  email: "anthony.manto8@gmail.com",
  password: "azerty",
  address: "Rue edmond rostand, 69002 Lyon",
  mobile_number: "0623987867",
  role: "helper",
  description: "Aider mon prochain est bien qu'un métier, c'est une passion.\
                C'est pour cela que j'ai choisi ce métier.\
                J'aime jouer au échec et me ballader au bord de mer.",
  price: "12",
  photo: "https://raw.githubusercontent.com/lewagon/fullstack-images/master/uikit/logo.png"
)

puts '...Helpers creation Finished!'


puts "Creating Diplomas..."
helper1.save
Diploma.create(
  name: "Assistante de vie (sans diplôme)",
  user: helper1
)

helper2.save
Diploma.create(
  name: "Parkinson",
  user: helper2
)
Diploma.create(
  name: "Savoir être",
  user: helper2
)

helper3.save
Diploma.create(
  name: "Assistante de vie (sans diplôme)",
  user: helper3
)

helper4.save
Diploma.create(
  name: "Assistante de vie (sans diplôme)",
  user: helper4
)

helper5.save
Diploma.create(
  name: "Parkinson",
  user: helper5
)
Diploma.create(
  name: "Savoir être",
  user: helper5
)

helper6.save
Diploma.create(
  name: "Parkinson",
  user: helper6
)
Diploma.create(
  name: "Accompagnement des personnes en situation de handicap",
  user: helper3
)

helper7.save
Diploma.create(
  name: "Parkinson",
  user: helper7
)

helper8.save
Diploma.create(
  name: "Assistante de vie (sans diplôme)",
  user: helper8
)

helper9.save
Diploma.create(
  name: "Assistante de vie (sans diplôme)",
  user: helper9
)

helper10.save
Diploma.create(
  name: "Assistante de vie (sans diplôme)",
  user: helper10
)

helper11.save
Diploma.create(
  name: "Alzheimer",
  user: helper11
)
Diploma.create(
  name: "Savoir être",
  user: helper11
)
puts '...Diplomas creation Finished!'
