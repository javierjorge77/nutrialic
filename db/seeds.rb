# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)
User.destroy_all
Professional.destroy_all

user1 = User.new(name:"Cristel", lastname: "Alvarez", phone: "7773388548", password: "12345678", email: "cristelalvarezvazquez@gmail.com", nutritionist: true)
user1.save!
professional1= Professional.new(user: user1, branch: "Nutrición Clínica", adress: "Cuernavaca", diploma: "10206015", first_cost: 500, follow_cost: 350)
file = URI.open("https://res.cloudinary.com/dp693fkkc/image/upload/v1667067873/Cristel_ho8hop.jpg")
professional1.photo.attach(io: file, filename: user1.name, content_type: "image/png")
professional1.save!


user2 = User.new(name: "Noemi", lastname: "Landa", phone: "7774398683", password: "12345678", email: "nlg.0619@hotmail.com", nutritionist: true)
user2.save!
professional2= Professional.new(user: user2, branch: "Nutrición Clínica", adress: " Villa Hermosa", diploma: "10206006", first_cost: 400, follow_cost: 150)
file = URI.open("https://res.cloudinary.com/dp693fkkc/image/upload/v1667067820/noemi_pq9irc.jpg")
professional2.photo.attach(io: file, filename: user2.name, content_type: "image/png")
professional2.save!


user3 = User.new(name: "Nivia", lastname: "Esquivel", phone: "7772073576", password: "12345678", email: "diaxesquivel@gmail.com", nutritionist: true)
user3.save!
professional3= Professional.new(user: user3, branch: "Nutrición Clínica, Médico Cirujano, Educadora en Diabetes ", adress: " Cuernavaca", diploma: "6555940", first_cost: 600, follow_cost: 400)
file = URI.open("https://res.cloudinary.com/dp693fkkc/image/upload/v1667067822/Nivia_kf81oc.jpg")
professional3.photo.attach(io: file, filename: user3.name, content_type: "image/png")
professional3.save!

user4 = User.new(name: "Ana", lastname: "Acuña", phone: "5517005252", password: "12345678", email: "charpinel7@gmail.com", nutritionist: true)
user4.save!
professional4= Professional.new(user: user4, branch: "Nutrición Clínica", adress: "Puebla", diploma: "13065988", first_cost: 500, follow_cost: 400)
file = URI.open("https://res.cloudinary.com/dp693fkkc/image/upload/v1667067823/Ana_grsqpi.jpg")
professional4.photo.attach(io: file, filename: user4.name, content_type: "image/png")
professional4.save!

user5 = User.new(name: "Jessica", lastname: "Penagos", phone: "9611141121", password: "12345678", email: "penagos_jl@hotmail.com", nutritionist: true)
user5.save!
professional5= Professional.new(user: user5, branch: "Nutrición Clínica, Obesidad, Educación en Diabetes", adress: "Chiapas", diploma: "11977457", first_cost: 450, follow_cost: 350)
file = URI.open("https://res.cloudinary.com/dp693fkkc/image/upload/v1667067820/Jessica_bx0bno.jpg")
professional5.photo.attach(io: file, filename: user5.name, content_type: "image/png")
professional5.save!

# sqrfqar
