# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)
Appointment.destroy_all
Professional.destroy_all
User.destroy_all


user1 = User.new(name:"Cristel", lastname: "Alvarez Vazquez", phone: "7773388548", password: "12345678", email: "cristelalvarezvazquez@gmail.com", nutritionist: true)
user1.save!
professional1= Professional.new(user: user1, branch: "Nutrición Clínica", adress: " Cuautla, Morelos", diploma: "10206015", first_cost: 500, follow_cost: 350)
file = URI.open("https://res.cloudinary.com/dp693fkkc/image/upload/v1667067873/Cristel_ho8hop.jpg")
professional1.photo.attach(io: file, filename: user1.name, content_type: "image/jpg")
professional1.save!


user2 = User.new(name: "Noemi", lastname: "Landa", phone: "7774398683", password: "12345678", email: "nlg.0619@hotmail.com", nutritionist: true)
user2.save!
professional2= Professional.new(user: user2, branch: "Nutrición Clínica", adress: "Villahermosa", diploma: "10206006", first_cost: 400, follow_cost: 150)
file = URI.open("https://res.cloudinary.com/dp693fkkc/image/upload/v1667067820/noemi_pq9irc.jpg")
professional2.photo.attach(io: file, filename: user2.name, content_type: "image/jpg")
professional2.save!

user5 = User.new(name: "Jessica", lastname: "Penagos", phone: "9611141121", password: "12345678", email: "penagos_jl@hotmail.com", nutritionist: true)
user5.save!
professional5= Professional.new(user: user5, branch: "Nutrición Clínica, Obesidad, Educación en Diabetes", adress: "Chiapas", diploma: "11977457", first_cost: 450, follow_cost: 350)
file = URI.open("https://res.cloudinary.com/dp693fkkc/image/upload/v1667067820/Jessica_bx0bno.jpg")
professional5.photo.attach(io: file, filename: user5.name, content_type: "image/png")
professional5.save!


user4 = User.new(name: "María Fernanda", lastname: "Serna Frías", phone: "8717303959", password: "12345678", email: "mariafernanda@gmail.com", nutritionist: true)
user4.save!
professional4= Professional.new(user: user4, branch: "Obesidad", adress: "Torreón", diploma: "8062690", first_cost: 600, follow_cost: 400)
file = URI.open("https://s3.us-east-1.amazonaws.com/doctoralia.com.mx/doctor/d1df34/d1df34bfee624082fa39c58145ea4162_large.jpg")
professional4.photo.attach(io: file, filename: user4.name, content_type: "image/jpg")
professional4.save!

user3 = User.new(name: "Ana", lastname: "Acuña", phone: "5517005252", password: "12345678", email: "charpinel7@gmail.com", nutritionist: true)
user3.save!
professional3= Professional.new(user: user3, branch: "Nutrición Clínica", adress: "Puebla,Puebla", diploma: "13065988", first_cost: 500, follow_cost: 400)
file = URI.open("https://res.cloudinary.com/dp693fkkc/image/upload/v1667067823/Ana_grsqpi.jpg")
professional3.photo.attach(io: file, filename: user3.name, content_type: "image/jpg")
professional3.save!


user6 = User.new(name: "Abigail", lastname: "Izguerra Fuentes", phone: "555945689", password: "12345678", email: "abigail@nutrialic.com", nutritionist: true)
user6.save!
professional6= Professional.new(user: user6, branch: "Nutrición Clínica", adress: "Ciudad de México", diploma: "11776428", first_cost: 700, follow_cost: 600)
file = URI.open("https://s3.us-east-1.amazonaws.com/doctoralia.com.mx/doctor/039ef1/039ef1aee602733505cb95abbd3eee31_large.jpg")
professional6.photo.attach(io: file, filename: user6.name, content_type: "image/jpg")
professional6.save!

user7 = User.new(name: "Ariadna", lastname: "López Pérez", phone: "5552684956", password: "12345678", email: "ariadna@nutrialic.com", nutritionist: true)
user7.save!
professional7= Professional.new(user: user7, branch: "Diabetólogo", adress: "Toluca", diploma: "11474526", first_cost: 650, follow_cost: 500)
file = URI.open("https://s3.us-east-1.amazonaws.com/doctoralia.com.mx/doctor/19a101/19a1012d10566d653a19a8eef4033198_large.jpg")
professional7.photo.attach(io: file, filename: user7.name, content_type: "image/jpg")
professional7.save!

user8 = User.new(name: "Pilar Carolina", lastname: "Castro Mata", phone: "7221235645", password: "12345678", email: "pilar@nutrialic.com", nutritionist: true)
user8.save!
professional8= Professional.new(user: user8, branch: "Nutrición Clínica", adress: "Toluca", diploma: "7302686", first_cost: 450, follow_cost: 400)
file = URI.open("https://s3.us-east-1.amazonaws.com/doctoralia.com.mx/doctor/ca420f/ca420fff8694b552281e0ba4a3a8c730_large.jpg")
professional8.photo.attach(io: file, filename: user8.name, content_type: "image/jpg")
professional8.save!

user9 = User.new(name: "Mayemi", lastname: "Gutierrez Reyes", phone: "3321011496", password: "12345678", email: "Mayemi@nutrialic.com", nutritionist: true)
user9.save!
professional9= Professional.new(user: user9, branch: "Nutrición Clínica", adress: "Monterrey", diploma: "7109529", first_cost: 800, follow_cost: 600)
file = URI.open("https://s3.us-east-1.amazonaws.com/doctoralia.com.mx/doctor/2cfbd6/2cfbd6bbbe9007c63224bd84349daced_large.jpg")
professional9.photo.attach(io: file, filename: user9.name, content_type: "image/jpg")
professional9.save!

user10 = User.new(name: "Nivia", lastname: "Esquivel", phone: "7772073576", password: "12345678", email: "diaxesquivel@gmail.com", nutritionist: true)
user10.save!
professional10= Professional.new(user: user10, branch: "Nutrición Clínica, Médico Cirujano, Educadora en Diabetes ", adress: "Cuernavaca", diploma: "6555940", first_cost: 600, follow_cost: 400)
file = URI.open("https://res.cloudinary.com/dp693fkkc/image/upload/v1667067822/Nivia_kf81oc.jpg")
professional10.photo.attach(io: file, filename: user10.name, content_type: "image/png")
professional10.save!
