# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)
Appointment.destroy_all
Professional.destroy_all
ProfessionalAccountRequest.destroy_all
User.destroy_all


user1 = User.new(name:"Cristel", lastname: "Alvarez Vazquez", phone: "7773388548", password: "12345678", email: "cristelalvarezvazquez@gmail.com", nutritionist: true)
user1.save!
professional1= ProfessionalAccountRequest.new(user: user1, branch: "Nutrición Clínica", adress: " Cuautla, Morelos", diploma: "10206015", first_cost: 500, follow_cost: 350, startAttendingTime: Time.parse("Sat, 01 Jan 2000 10:00:00.000000000 UTC +00:00"),   endAttendingTime: Time.parse("Sat, 01 Jan 2000 17:00:00.000000000 UTC +00:00"), username: "cristel123")
file = URI.open("https://res.cloudinary.com/dp693fkkc/image/upload/v1667067873/Cristel_ho8hop.jpg")
professional1.photo.attach(io: file, filename: user1.name, content_type: "image/jpg")
professional1.save!


user2 = User.new(name: "Noemi", lastname: "Landa", phone: "7774398683", password: "12345678", email: "nlg.0619@hotmail.com", nutritionist: true)
user2.save!
professional2= ProfessionalAccountRequest.new(user: user2, branch: "Nutrición Clínica", adress: "Villahermosa", diploma: "10206006", first_cost: 400, follow_cost: 150, startAttendingTime: Time.parse("Sat, 01 Jan 2000 10:00:00.000000000 UTC +00:00"),   endAttendingTime: Time.parse("Sat, 01 Jan 2000 17:00:00.000000000 UTC +00:00"), username: "noemi123")
file = URI.open("https://res.cloudinary.com/dp693fkkc/image/upload/v1667067820/noemi_pq9irc.jpg")
professional2.photo.attach(io: file, filename: user2.name, content_type: "image/jpg")
professional2.save!

user5 = User.new(name: "Jessica", lastname: "Penagos", phone: "9611141121", password: "12345678", email: "penagos_jl@hotmail.com", nutritionist: true)
user5.save!
professional5= ProfessionalAccountRequest.new(user: user5, branch: "Nutrición Clínica, Obesidad, Educación en Diabetes", adress: "Chiapas", diploma: "11977457", first_cost: 450, follow_cost: 350, startAttendingTime: Time.parse("Sat, 01 Jan 2000 10:00:00.000000000 UTC +00:00"), endAttendingTime: Time.parse("Sat, 01 Jan 2000 17:00:00.000000000 UTC +00:00"), username: "jessica123")
file = URI.open("https://res.cloudinary.com/dp693fkkc/image/upload/v1667067820/Jessica_bx0bno.jpg")
professional5.photo.attach(io: file, filename: user5.name, content_type: "image/png")
professional5.save!

AdminUser.create!(email: 'admin@example.com', password: 'saratiel_99#', password_confirmation: 'saratiel_99#') if Rails.env.development?