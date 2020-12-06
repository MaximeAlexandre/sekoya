# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

require 'date'
require 'open-uri'
require 'faker'

Review.destroy_all
Favori.destroy_all
Task.destroy_all
Diploma.destroy_all
Booking.destroy_all
User.destroy_all

url = Faker::Avatar.image(slug: "my-own-slug", size: "50x50")
filename = File.basename(URI.parse(url).path)
file = URI.open(url)

diplomas = ["Alzheimer", "Parkinson", "Savoir-être", "Bientraitance", "Accompagnement des personnes en situation de handicap", "Accompagnement à la fin de vie"]

puts 'Creating 4 fake male seniors in Marseille...'
s_jean_paul = User.new(
  first_name: "Jean paul",
  last_name: "Belmondo",
  email: "jean-paul.belmondo@gmail.com",
  password: "azerty",
  address: "70 Rue de la République 13002 Marseille",
  mobile_number: "0607080901",
  role: "senior",
)
s_jean_paul.photo.attach(io: file, filename: filename)

s_guy = User.new(
  first_name: "Guy",
  last_name: "Lampron",
  email: "guy.lampron@gmail.com",
  password: "azerty",
  address: "Cours Julien 13006 Marseille",
  mobile_number: "0689754534",
  role: "senior",
  pathology: "Alzheimer",
)
s_guy.photo.attach(io: file, filename: filename)

s_michel = User.new(
  first_name: "Michel",
  last_name: "Lopez",
  email: "michel.lopez@gmail.com",
  password: "azerty",
  address: "126 Cours Lieutaud 13006 Marseille",
  mobile_number: "0689754563",
  role: "senior",
)
s_michel.photo.attach(io: file, filename: filename)

s_charles = User.new(
  first_name: "Charles",
  last_name: "Labonte",
  email: "charles.labonte@gmail.com",
  password: "azerty",
  address: "76 Rue Dragon 13006 Marseille",
  mobile_number: "0689754384",
  role: "senior",
  pathology: "Alzheimer",
)
s_charles.photo.attach(io: file, filename: filename)
puts "...Male seniors creation finished"


puts 'Creating 4 fake female seniors in Marseille...'
s_ginette = User.new(
  first_name: "Ginette",
  last_name: "Delacroix",
  email: "ginette.delacroix@gmail.com",
  password: "azerty",
  address: "150 Rue Paradis 13006 Marseille",
  mobile_number: "0745389721",
  role: "senior",
  pathology: "Alzheimer",
)
s_ginette.photo.attach(io: file, filename: filename)

s_veronique = User.new(
  first_name: "Veronique",
  last_name: "Dumoulin",
  email: "veronique.dumoulin@gmail.com",
  password: "azerty",
  address: "35 Avenue de Mazargues Marseille",
  mobile_number: "0645389723",
  role: "senior",
  pathology: "Alzheimer",
)
s_veronique.photo.attach(io: file, filename: filename)

s_mireille = User.new(
  first_name: "Mireille",
  last_name: "Leveille",
  email: "mireille.leveille@gmail.com",
  password: "azerty",
  address: "14 Avenue Benjamin Delessert 13010 Marseille",
  mobile_number: "0646479723",
  role: "senior",
  pathology: "Alzheimer",
)
s_mireille.photo.attach(io: file, filename: filename)

s_ghislaine = User.new(
  first_name: "Ghislaine",
  last_name: "Crete",
  email: "ghislaine.crete@gmail.com",
  password: "azerty",
  address: "12 Rue Louis Braille 13005 Marseille",
  mobile_number: "0646389723",
  role: "senior",
)
s_ghislaine.photo.attach(io: file, filename: filename)
puts "...Female seniors creation finished"


puts 'Creating 4 fake seniors in Lyon...'
s_eric = User.new(
  first_name: "Eric",
  last_name: "Chevalier",
  email: "eric.chevalier@gmail.com",
  password: "azerty",
  address: "72 Boulevard Yves Farge 69007 Lyon",
  mobile_number: "0646673423",
  role: "senior",
)
s_eric.photo.attach(io: file, filename: filename)

s_sylvain = User.new(
  first_name: "Sylvain",
  last_name: "Fabre",
  email: "sylvain.fabre@gmail.com",
  password: "azerty",
  address: "7 Rue Georges Gouy 69007 Lyon",
  mobile_number: "0648453423",
  role: "senior",
)
s_sylvain.photo.attach(io: file, filename: filename)

s_edith = User.new(
  first_name: "Edith",
  last_name: "Pouchard",
  email: "edith.pouchard@gmail.com",
  password: "azerty",
  address: "84 Rue Vauban 69006 Lyon",
  mobile_number: "0684950423",
  role: "senior",
)
s_edith.photo.attach(io: file, filename: filename)

s_irene = User.new(
  first_name: "Irene",
  last_name: "Bougeot",
  email: "irene.bougeot@gmail.com",
  password: "azerty",
  address: "Place Carnot 69002 Lyon",
  mobile_number: "0673849423",
  role: "senior",
)
s_irene.photo.attach(io: file, filename: filename)
puts "...Lyon seniors creation finished"


puts "Creating 5 fake female helpers in Lyon..."
hj_pauline = User.new(
  first_name: "Pauline",
  last_name: "Florens",
  email: "pauline.florens@lewagon.org",
  password: "azerty",
  address: "Rue de la Charité 69002 Lyon",
  mobile_number: "0645893723",
  role: "helper",
  car: true,
  description: "Entretenir la maison de la personne accompagnée, en faisant le ménage, les petits travaux d'entretien et de réparation nécessaires, la lessive et le repassage.\
                Subvenir aux besoins alimentaires, depuis les courses jusqu'à la prise des repas.\
                Aider à l'autonomie physique, en assistant la marche, le réveil et le coucher.",
  price: "20",
)
hj_pauline.photo.attach(io: file, filename: filename)

ha_valerie = User.new(
  first_name: "Valerie",
  last_name: "Gregoix",
  email: "valerie.gregoix@gmail.com",
  password: "azerty",
  address: "20 Rue Burdeau 69001 Lyon",
  mobile_number: "0689348273",
  role: "helper",
  car: true,
  description: "En activité depuis plus de 10 ans, ce métier est une vraie passion.\
                J’aime le contact avec les autres et la satisfaction de rendre service.\
                J’ai suivi de nombreuses formations pour répondre à tout type de pathologie et je suis une véritable fée du logis.\
                La routine quotidienne peut parfois être pesante alors laisser moi être votre rayon de soleil de la journée.",
  price: "30",
)
ha_valerie.photo.attach(io: file, filename: filename)

hj_aurore = User.new(
  first_name: "Aurore",
  last_name: "Pinçon",
  email: "aurore.pincon@gmail.com",
  password: "azerty",
  address: "77 Rue Duquesne, 69006 Lyon",
  mobile_number: "0645903421",
  role: "helper",
  car: true,
  description: "Entretenir la maison de la personne accompagnée, en faisant le ménage, les petits travaux d'entretien et de réparation nécessaires, la lessive et le repassage.\
                Subvenir aux besoins alimentaires, depuis les courses jusqu'à la prise des repas.\
                Aider à l'autonomie physique, en assistant la marche, le réveil et le coucher.",
  price: "15",
)
  hj_aurore.photo.attach(io: file, filename: filename)


ha_raquel = User.new(
  first_name: "Raquel",
  last_name: "Murillo",
  email: "raquel.murillo@gmail.com",
  password: "azerty",
  address: "61 Cours Gambetta 69003 Lyon",
  mobile_number: "0734298710",
  role: "helper",
  car: true,
  description: "Entretenir la maison de la personne accompagnée, en faisant le ménage, les petits travaux d'entretien et de réparation nécessaires, la lessive et le repassage.\
                Subvenir aux besoins alimentaires, depuis les courses jusqu'à la prise des repas.\
                Aider à l'autonomie physique, en assistant la marche, le réveil et le coucher.",
  price: "18",
)
ha_raquel.photo.attach(io: file, filename: filename)

ha_danielle = User.new(
  first_name: "Danielle",
  last_name: "Roger",
  email: "danielle.roger@gmail.com",
  password: "azerty",
  address: "1 Rue du Bélier 69002 Lyon",
  mobile_number: "0645983401",
  role: "helper",
  car: true,
  description: "Entretenir la maison de la personne accompagnée, en faisant le ménage, les petits travaux d'entretien et de réparation nécessaires, la lessive et le repassage.\
                Subvenir aux besoins alimentaires, depuis les courses jusqu'à la prise des repas.\
                Aider à l'autonomie physique, en assistant la marche, le réveil et le coucher.",
  price: "25",
)
ha_danielle.photo.attach(io: file, filename: filename)

puts '...Female helpers creation Finished!'


puts "Creating 5 fake male helpers in Lyon..."
ha_victor = User.new(
  first_name: "Victor",
  last_name: "Faud",
  email: "victor.faud@gmail.com",
  password: "azerty",
  address: "142 Grande Rue de la Guillotière 69007 Lyon",
  mobile_number: "0678459328",
  role: "helper",
  car: true,
  description: "Entretenir la maison de la personne accompagnée, en faisant le ménage, les petits travaux d'entretien et de réparation nécessaires, la lessive et le repassage.\
                Subvenir aux besoins alimentaires, depuis les courses jusqu'à la prise des repas.\
                Aider à l'autonomie physique, en assistant la marche, le réveil et le coucher.",
  price: "40",
)
ha_victor.photo.attach(io: file, filename: filename)

ha_alain = User.new(
  first_name: "Alain",
  last_name: "Laporte",
  email: "alain.laporte@gmail.com",
  password: "azerty",
  address: "179 Avenue Lacassagne 69003 Lyon",
  mobile_number: "0745832918",
  role: "helper",
  car: true,
  description: "Entretenir la maison de la personne accompagnée, en faisant le ménage, les petits travaux d'entretien et de réparation nécessaires, la lessive et le repassage.\
                Subvenir aux besoins alimentaires, depuis les courses jusqu'à la prise des repas.\
                Aider à l'autonomie physique, en assistant la marche, le réveil et le coucher.",
  price: "35",
)
ha_alain.photo.attach(io: file, filename: filename)

hj_fabien = User.new(
  first_name: "Fabien",
  last_name: "Lauby",
  email: "fabien.lauby@gmail.com",
  password: "azerty",
  address: "38 Rue Jean Jaurès 69100 Villeurbanne",
  mobile_number: "0738943783",
  role: "helper",
  car: false,
  description: "Entretenir la maison de la personne accompagnée, en faisant le ménage, les petits travaux d'entretien et de réparation nécessaires, la lessive et le repassage.\
                Subvenir aux besoins alimentaires, depuis les courses jusqu'à la prise des repas.\
                Aider à l'autonomie physique, en assistant la marche, le réveil et le coucher.",
  price: "12",
)
hj_fabien.photo.attach(io: file, filename: filename)

hj_pierre = User.new(
  first_name: "Pierre",
  last_name: "Valoix",
  email: "pierre.valoix@gmail.com",
  password: "azerty",
  address: "60 Rue de l'Abondance 69003 Lyon",
  mobile_number: "06589372892",
  role: "helper",
  car: false,
  description: "Entretenir la maison de la personne accompagnée, en faisant le ménage, les petits travaux d'entretien et de réparation nécessaires, la lessive et le repassage.\
                Subvenir aux besoins alimentaires, depuis les courses jusqu'à la prise des repas.\
                Aider à l'autonomie physique, en assistant la marche, le réveil et le coucher.",
  price: "13",
)
hj_pierre.photo.attach(io: file, filename: filename)

hj_justin = User.new(
  first_name: "Justin",
  last_name: "Deprec",
  email: "justin.deprec@gmail.com",
  password: "azerty",
  address: "106 Avenue Maréchal de Saxe 69003 Lyon",
  mobile_number: "0634832987",
  role: "helper",
  car: false,
  description: "Entretenir la maison de la personne accompagnée, en faisant le ménage, les petits travaux d'entretien et de réparation nécessaires, la lessive et le repassage.\
                Subvenir aux besoins alimentaires, depuis les courses jusqu'à la prise des repas.\
                Aider à l'autonomie physique, en assistant la marche, le réveil et le coucher.",
  price: "15",
)
hj_justin.photo.attach(io: file, filename: filename)

puts '...Male helpers creation Finished!'


puts "Creating family test..."
test_family = User.new(
  first_name: "Sylvia",
  last_name: "Hide",
  email: "sekofamilytest@test.com",
  password: "sekofamily",
  address: "33 Rue Thomassin Lyon",
  mobile_number: "0756349876",
  role: "senior",
  pathology: "Parkinson",
)
test_family.photo.attach(io: file, filename: filename)
puts '...family test creation Finished!'


puts "Creating test Helper..."
test_helper = User.new(
  first_name: "Sylvain",
  last_name: "Jack",
  email: "sekohelpertest@test.com",
  password: "sekohelper",
  address: "55 Rue Paradis 13006 Marseille",
  mobile_number: "0623987867",
  role: "helper",
  car: true,
  description: "Aider mon prochain est bien plus qu'un métier, c'est une passion.\
                C'est pour cela que j'ai choisi ce métier.\
                J'aime jouer au échec et me ballader au bord de mer.",
  price: "12",
)
test_helper.photo.attach(io: file, filename: filename)
puts '...test Helper creation Finished!'


puts "Creating Diplomas..."
hj_pauline.save
Diploma.create(
  name: "Assistant(e) de vie (sans diplôme)",
  user: hj_pauline
)

ha_valerie.save
Diploma.create(
  name: "Parkinson",
  user: ha_valerie
)
Diploma.create(
  name: "Savoir être",
  user: ha_valerie
)

hj_aurore.save
Diploma.create(
  name: "Assistant(e) de vie (sans diplôme)",
  user: hj_aurore
)

ha_raquel.save
Diploma.create(
  name: "Bientraitance",
  user: ha_raquel
)
Diploma.create(
  name: "Accompagnement à la fin de vie",
  user: ha_raquel
)

ha_danielle.save
Diploma.create(
  name: "Parkinson",
  user: ha_danielle
)
Diploma.create(
  name: "Savoir être",
  user: ha_danielle
)

ha_victor.save
Diploma.create(
  name: "Parkinson",
  user: ha_victor
)
Diploma.create(
  name: "Accompagnement des personnes en situation de handicap",
  user: hj_aurore
)

ha_alain.save
Diploma.create(
  name: "Parkinson",
  user: ha_alain
)

hj_fabien.save
Diploma.create(
  name: "Assistant(e) de vie (sans diplôme)",
  user: hj_fabien
)

hj_pierre.save
Diploma.create(
  name: "Assistant(e) de vie (sans diplôme)",
  user: hj_pierre
)

hj_justin.save
Diploma.create(
  name: "Assistant(e) de vie (sans diplôme)",
  user: hj_justin
)

test_helper.save
Diploma.create(
  name: "Alzheimer",
  user: test_helper
)
Diploma.create(
  name: "Savoir être",
  user: test_helper
)
puts '...Diplomas creation Finished!'


puts 'Creating test_helper fake bookings...'
# Historic bookings
s_jean_paul.save
booking1 = Booking.new(
  date: (Date.today - 8).strftime("%d/%m/%Y"),
  start_time: "08",
  end_time: "09",
  helper: test_helper,
  senior: s_jean_paul,
  status: "refusé",
  booking_step: 2
)
booking1.save
task1 = Task.create(
  name: "Accompagnement à un RDV",
  booking: booking1
)


s_guy.save
booking2 = Booking.new(
  date: (Date.today - 8).strftime("%d/%m/%Y"),
  start_time: "11",
  end_time: "14",
  helper: test_helper,
  senior: s_guy,
  status: "annulé",
  booking_step: 2
)
booking2.save
task2 = Task.create(
  name: "Promenade",
  booking: booking2
)

task3 = Task.create(
  name: "Courses",
  booking: booking2
)

task4 = Task.create(
  name: "Activités intellectuelles",
  booking: booking2
)


s_ginette.save
booking3 = Booking.new(
  date: (Date.today - 6).strftime("%d/%m/%Y"),
  start_time: "11",
  end_time: "13",
  helper: test_helper,
  senior: s_ginette,
  status: "accepté",
  booking_step: 2
)
booking3.save
task5 = Task.create(
  name: "Ménage",
  booking: booking3
)

task6 = Task.create(
  name: "Prise de Médicament",
  booking: booking3
)


booking9 = Booking.new(
  date: (Date.today - 5).strftime("%d/%m/%Y"),
  start_time: "12",
  end_time: "16",
  status: "accepté",
  helper: test_helper,
  senior: s_guy,
  booking_step: 2
)
booking9.save
task18 = Task.create(
  name: "Ménage",
  booking: booking9
)

task19 = Task.create(
  name: "Promenade",
  booking: booking9
)

task20 = Task.create(
  name: "Activités sportives",
  booking: booking9
)


# Pending bookings
s_veronique.save

booking6 = Booking.new(
  date: (Date.today + 7).strftime("%d/%m/%Y"),
  start_time: "12",
  end_time: "14",
  status: "pending",
  helper: test_helper,
  senior: s_guy,
  booking_step: 2
)
booking6.save
task12 = Task.create(
  name: "Prise de Médicaments",
  booking: booking6
)
task13 = Task.create(
  name: "Courses",
  booking: booking6
)


# Futur bookings
booking7 = Booking.new(
  date: (Date.today + 3).strftime("%d/%m/%Y"),
  start_time: "20",
  end_time: "21",
  status: "accepté",
  helper: test_helper,
  senior: s_ginette,
  booking_step: 2
)
booking7.save
task14 = Task.create(
  name: "Se lever / Se coucher",
  booking: booking7
)

task15 = Task.create(
  name: "Prise de Médicaments",
  booking: booking7
)


booking5 = Booking.new(
  date: (Date.today + 6).strftime("%d/%m/%Y"),
  start_time: "9",
  end_time: "11",
  status: "accepté",
  helper: test_helper,
  senior: s_jean_paul,
  booking_step: 2
)
booking5.save
task10 = Task.create(
  name: "Loisirs",
  booking: booking5
)
task11 = Task.create(
  name: "Accompagnement à un RDV",
  booking: booking5
)


booking11 = Booking.new(
  date: (Date.today + 14).strftime("%d/%m/%Y"),
  start_time: "17",
  end_time: "19",
  status: "accepté",
  helper: test_helper,
  senior: s_veronique,
  booking_step: 2
)
booking11.save
task22 = Task.create(
  name: "Prise de Médicaments",
  booking: booking11
)

task23 = Task.create(
  name: "Gestion d'une pathologie",
  booking: booking11
)

s_michel.save
booking20 = Booking.new(
  date: (Date.today + 13).strftime("%d/%m/%Y"),
  start_time: "10",
  end_time: "11",
  status: "accepté",
  helper: test_helper,
  senior: s_michel,
  booking_step: 2
)
booking20.save
task43 = Task.new(
  name: "Promenade",
  booking: booking20
)
task43.save


s_charles.save
booking21 = Booking.new(
  date: (Date.today + 14).strftime("%d/%m/%Y"),
  start_time: "14",
  end_time: "15",
  status: "accepté",
  helper: test_helper,
  senior: s_charles,
  booking_step: 2
)
booking21.save
task44 = Task.new(
  name: "Activités intellectuelles",
  booking: booking21
)
task44.save


s_mireille.save
booking22 = Booking.new(
  date: (Date.today + 7).strftime("%d/%m/%Y"),
  start_time: "16",
  end_time: "18",
  status: "accepté",
  helper: test_helper,
  senior: s_mireille,
  booking_step: 2
)
booking22.save
task45 = Task.new(
  name: "Promenade",
  booking: booking22
)
task45.save
task46 = Task.new(
  name: "Loisirs",
  booking: booking22
)
task46.save


s_ghislaine.save
booking23 = Booking.new(
  date: (Date.today + 12).strftime("%d/%m/%Y"),
  start_time: "7",
  end_time: "9",
  status: "accepté",
  helper: test_helper,
  senior: s_ghislaine,
  booking_step: 2
)
booking23.save
task47 = Task.new(
  name: "Se lever / se coucher",
  booking: booking23
)
task47.save
task48 = Task.new(
  name: "Se laver / s'habiller",
  booking: booking23
)
task48.save
puts '...test_helper Bookings creation finished'


puts 'Creating fake test_helper reviews...'
Review.create(
  content: "Sylvain est très agréable. J'en avais entendu parler par une amie et il répond totalement à mes attentes.",
  note: 5,
  booking: booking9
)

Review.create(
  content: "Sylvain est un garçon charmant, attentionné et serviable. je le recommande vivement!!",
  note: 4,
  booking: booking2
)

Review.create(
  content: "Je ne suis pas totalement satisfait de SEKOYA et de son helper Sylvain.",
  note: 2,
  booking: booking1
)

Review.create(
  content: "Heureusement que mon petit fils m'a aidé pour naviguer sur l'application. Pas évident pour des personnes agées",
  note: 3,
  booking: booking3
)
puts '...test_helper fake reviews creation finished'


puts 'Creating Germaine fake bookings...'
test_family.save
# Historic bookings
booking12 = Booking.new(
  date: (Date.today - 6).strftime("%d/%m/%Y"),
  start_time: "08",
  end_time: "10",
  status: "refusé",
  helper: hj_pauline,
  senior: test_family,
  booking_step: 2
)
booking12.save
task24 = Task.create(
  name: "Se lever / Se coucher",
  booking: booking12
)

task25 = Task.create(
  name: "Se laver / S'habiller",
  booking: booking12
)


booking13 = Booking.new(
  date: (Date.today - 4).strftime("%d/%m/%Y"),
  start_time: "10",
  end_time: "12",
  status: "accepté",
  helper: ha_raquel,
  senior: test_family,
  booking_step: 2
)
booking13.save
task26 = Task.create(
  name: "Ménage",
  booking: booking13
)

task27 = Task.create(
  name: "Courses",
  booking: booking13,
)

booking14 = Booking.new(
  date: (Date.today - 4).strftime("%d/%m/%Y"),
  start_time: "18",
  end_time: "20",
  status: "accepté",
  helper: ha_raquel,
  senior: test_family,
  booking_step: 2
)
booking14.save
task28 = Task.create(
  name: "Promenade",
  booking: booking14
)

task29 = Task.create(
  name: "Se lever / Se coucher",
  booking: booking14
)


booking15 = Booking.new(
  date: (Date.today - 1).strftime("%d/%m/%Y"),
  start_time: "11",
  end_time: "14",
  status: "annulé",
  helper: ha_victor,
  senior: test_family,
  booking_step: 2
)
booking15.save
task30 = Task.create(
  name: "Ménage",
  booking: booking15
)

task31 = Task.create(
  name: "Prise de médicaments",
  booking: booking15
)

task32 = Task.create(
  name: "Courses",
  booking: booking15
)


# Pending bookings


# Futur bookings
booking18 = Booking.new(
  date: (Date.today + 7).strftime("%d/%m/%Y"),
  start_time: "18",
  end_time: "20",
  status: "accepté",
  helper: ha_raquel,
  senior: test_family,
  booking_step: 2
)
booking18.save
task37 = Task.create(
  name: "Prise Médicaments",
  booking: booking18
)

task38 = Task.create(
  name: "Se lever / Se coucher",
  booking: booking18
)


booking19 = Booking.new(
  date: (Date.today + 5).strftime("%d/%m/%Y"),
  start_time: "15",
  end_time: "17",
  status: "accepté",
  helper: hj_pierre,
  senior: test_family,
  booking_step: 2
)
booking19.save
task39 = Task.create(
  name: "Accompagnement à RDV médical",
  booking: booking19
)

task41 = Task.create(
  name: "Activités intellectuelles",
  booking: booking19
)
puts '... Germaine fake bookinks creation finished'


puts 'Creating Germaine Fake reviews...'
Review.create(
  content: "Raquel est LA personne qu'il me fallait. Si je pouvais je ne choisirai qu'elle!",
  note: "5",
  booking: booking13
)

Review.create(
  content: "Autre prestation, même statisfaction",
  note: "5",
  booking: booking14
)
puts '...Germaine fake reviews creation finished'



s_eric.save
booking24 = Booking.new(
  date: "01/07/2020",
  start_time: "7",
  end_time: "9",
  status: "accepté",
  helper: hj_pauline,
  senior: s_eric,
  booking_step: 2
)
booking24.save
task49 = Task.new(
  name: "Se lever / se coucher",
  booking: booking24
)
task49.save
Review.create(
  content: "Pauline est extra, très gentille et à l'écoute. Je la recommande.",
  note: "5",
  booking: booking24
)

booking25 = Booking.new(
  date: "02/07/2020",
  start_time: "7",
  end_time: "9",
  status: "accepté",
  helper: hj_justin,
  senior: s_eric,
  booking_step: 2
)
booking25.save
task50 = Task.new(
  name: "Se lever / se coucher",
  booking: booking25
)
task50.save
Review.create(
  content: "Justin n'a pas l'air très à l'aise avec les personnes agées, mais il écoute attentivement pour s'ameliorer.",
  note: "3",
  booking: booking25
)


s_sylvain.save
booking26 = Booking.new(
  date: "03/07/2020",
  start_time: "7",
  end_time: "9",
  status: "accepté",
  helper: ha_victor,
  senior: s_sylvain,
  booking_step: 2
)
booking26.save
task51 = Task.new(
  name: "Se lever / se coucher",
  booking: booking26
)
task51.save
Review.create(
  content: "Victor est aimable mais devrait être plus attentif.",
  note: "3",
  booking: booking26
)


s_edith.save


s_irene.save
booking28 = Booking.new(
  date: "04/07/2020",
  start_time: "7",
  end_time: "9",
  status: "accepté",
  helper: hj_aurore,
  senior: s_irene,
  booking_step: 2
)
booking28.save
task53 = Task.new(
  name: "Se lever / se coucher",
  booking: booking28
)
task53.save
Review.create(
  content: "Aurore est un amour mais toujours sur son téléphone. Elle me fait penser à ma petite fille.",
  note: "3",
  booking: booking28
)


booking29 = Booking.new(
  date: "05/07/2020",
  start_time: "7",
  end_time: "9",
  status: "accepté",
  helper: hj_pierre,
  senior: s_irene,
  booking_step: 2
)
booking29.save
task54 = Task.new(
  name: "Se lever / se coucher",
  booking: booking29
)
task54.save
Review.create(
  content: "Pierre est super. Il est gentil, serviable et à l'écoute.",
  note: "5",
  booking: booking29
)


booking30 = Booking.new(
  date: "06/07/2020",
  start_time: "7",
  end_time: "9",
  status: "accepté",
  helper: hj_pierre,
  senior: s_sylvain,
  booking_step: 2
)
booking30.save
task55 = Task.new(
  name: "Se lever / se coucher",
  booking: booking30
)
task55.save
Review.create(
  content: "Malgré un petit retard, Pierre est vraiment agréable et a sû compenser son retard par sa gentillesse et .",
  note: "4",
  booking: booking30
)

booking31 = Booking.new(
  date: "21/08/2020",
  start_time: "10",
  end_time: "12",
  status: "accepté",
  helper: ha_valerie,
  senior: s_edith,
  booking_step: 2
)
booking31.save
task56 = Task.create(
  name: "Ménage",
  booking: booking31
)

task57 = Task.create(
  name: "Courses",
  booking: booking31,
)
Review.create(
  content: "Valerie est geniale, elle est polyvalente et adore discuter tout en faisant les tâches demandés.",
  note: "5",
  booking: booking31
)


booking32 = Booking.new(
  date: "21/08/2020",
  start_time: "18",
  end_time: "20",
  status: "accepté",
  helper: ha_valerie,
  senior: s_irene,
  booking_step: 2
)
booking32.save
task58 = Task.create(
  name: "Promenade",
  booking: booking32
)
task59 = Task.create(
  name: "Se lever / Se coucher",
  booking: booking32
)
Review.create(
  content: "La compagnie de Valerie est des plus agréable. Elle est très attentive et s'interesse à tout ce que l'on dit",
  note: "5",
  booking: booking32
)
