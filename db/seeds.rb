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


user2 = User.new(name: "Noemi", lastname: "Landa", phone: "7774398683", password: "12345678", email: "nlg.0619@hotmail.com", nutritionist: true)
user2.save!
professional2= ProfessionalAccountRequest.new(user: user2, branch: "Nutrición Clínica", adress: "Calle Zacatecas 31a, 62763 Tres de Mayo, Morelos, Mexico", latitude: 18.866867696012008, longitude: -99.21058451080718, diploma: "10206006", first_cost: 400, follow_cost: 150, startAttendingTime: Time.parse("Sat, 01 Jan 2000 10:00:00.000000000 UTC +00:00"),   endAttendingTime: Time.parse("Sat, 01 Jan 2000 17:00:00.000000000 UTC +00:00"), username: "noemi123")
file = URI.open("https://res.cloudinary.com/dp693fkkc/image/upload/v1667067820/noemi_pq9irc.jpg")
professional2.photo.attach(io: file, filename: user2.name, content_type: "image/jpg")
professional2.save!

user5 = User.new(name: "Jessica", lastname: "Penagos", phone: "9611141121", password: "12345678", email: "penagos_jl@hotmail.com", nutritionist: true)
user5.save!
professional5= ProfessionalAccountRequest.new(user: user5, branch: "Nutrición Clínica, Obesidad, Educación en Diabetes", adress: "Calle La Morena 501, 03103 Mexico City, Mexico", latitude: 19.398692458142108, longitude: -99.16135885876011, diploma: "11977457", first_cost: 450, follow_cost: 350, startAttendingTime: Time.parse("Sat, 01 Jan 2000 10:00:00.000000000 UTC +00:00"), endAttendingTime: Time.parse("Sat, 01 Jan 2000 17:00:00.000000000 UTC +00:00"), username: "jessica123")
file = URI.open("https://res.cloudinary.com/dp693fkkc/image/upload/v1667067820/Jessica_bx0bno.jpg")
professional5.photo.attach(io: file, filename: user5.name, content_type: "image/png")
professional5.save!


user4 = User.new(name: "María Fernanda", lastname: "Serna Frías", phone: "8717303959", password: "12345678", email: "mariafernanda@gmail.com", nutritionist: true)
user4.save!
professional4= ProfessionalAccountRequest.new(user: user4, branch: "Obesidad", adress: "Avenida Nicolás Bravo 4590, 27050 Torreón, Coahuila, Mexico", latitude: 25.544605727433876, longitude: -103.39994726651942, diploma: "8062690", first_cost: 600, follow_cost: 400, startAttendingTime: Time.parse("Sat, 01 Jan 2000 10:00:00.000000000 UTC +00:00"),   endAttendingTime: Time.parse("Sat, 01 Jan 2000 17:00:00.000000000 UTC +00:00"), username: "mariaf123")
file = URI.open("https://s3.us-east-1.amazonaws.com/doctoralia.com.mx/doctor/d1df34/d1df34bfee624082fa39c58145ea4162_large.jpg")
professional4.photo.attach(io: file, filename: user4.name, content_type: "image/jpg")
professional4.save!

user3 = User.new(name: "Ana", lastname: "Acuña", phone: "5517005252", password: "12345678", email: "charpinel7@gmail.com", nutritionist: true)
user3.save!
professional3= ProfessionalAccountRequest.new(user: user3, branch: "Nutrición Clínica", adress: "11 Norte O Constitución De 1917 907, 72000 Puebla, Puebla, Mexico", latitude: 19.05364899915699, longitude: -98.20312258313447, diploma: "13065988", first_cost: 500, follow_cost: 400, startAttendingTime: Time.parse("Sat, 01 Jan 2000 10:00:00.000000000 UTC +00:00"),   endAttendingTime: Time.parse("Sat, 01 Jan 2000 17:00:00.000000000 UTC +00:00"), username: "ana123")
file = URI.open("https://res.cloudinary.com/dp693fkkc/image/upload/v1667067823/Ana_grsqpi.jpg")
professional3.photo.attach(io: file, filename: user3.name, content_type: "image/jpg")
professional3.save!


user6 = User.new(name: "Abigail", lastname: "Izguerra Fuentes", phone: "555945689", password: "12345678", email: "abigail@nutrialic.com", nutritionist: true)
user6.save!
professional6= ProfessionalAccountRequest.new(user: user6, branch: "Nutrición Clínica", adress: "Calle Poseidón 1, 03940 Mexico City, Mexico", latitude: 19.365881959893755, longitude: -99.17963456453603, diploma: "11776428", first_cost: 700, follow_cost: 600, startAttendingTime: Time.parse("Sat, 01 Jan 2000 10:00:00.000000000 UTC +00:00"),   endAttendingTime: Time.parse("Sat, 01 Jan 2000 17:00:00.000000000 UTC +00:00"), username: "abigail123")
file = URI.open("https://s3.us-east-1.amazonaws.com/doctoralia.com.mx/doctor/039ef1/039ef1aee602733505cb95abbd3eee31_large.jpg")
professional6.photo.attach(io: file, filename: user6.name, content_type: "image/jpg")
professional6.save!

user7 = User.new(name: "Ariadna", lastname: "López Pérez", phone: "5552684956", password: "12345678", email: "ariadna@nutrialic.com", nutritionist: true)
user7.save!
professional7= ProfessionalAccountRequest.new(user: user7, branch: "Diabetólogo", adress: "Calle Sebastián Lerdo De Tejada Poniente 560, 50040 Toluca, Mexico, Mexico", latitude: 19.29173801085105, longitude: -99.66495987701484, diploma: "11474526", first_cost: 650, follow_cost: 500, startAttendingTime: Time.parse("Sat, 01 Jan 2000 10:00:00.000000000 UTC +00:00"), endAttendingTime: Time.parse("Sat, 01 Jan 2000 17:00:00.000000000 UTC +00:00"), username: "ariadna123")
file = URI.open("https://s3.us-east-1.amazonaws.com/doctoralia.com.mx/doctor/19a101/19a1012d10566d653a19a8eef4033198_large.jpg")
professional7.photo.attach(io: file, filename: user7.name, content_type: "image/jpg")
professional7.save!

user8 = User.new(name: "Pilar Carolina", lastname: "Castro Mata", phone: "7221235645", password: "12345678", email: "pilar@nutrialic.com", nutritionist: true)
user8.save!
professional8= ProfessionalAccountRequest.new(user: user8, branch: "Nutrición Clínica", adress: "Calle Francisco I. Madero 1913, 62270 Cuernavaca, Morelos, Mexico", latitude: 18.937263245375632, longitude: -99.23813871078966, diploma: "7302686", first_cost: 450, follow_cost: 400, startAttendingTime: Time.parse("Sat, 01 Jan 2000 10:00:00.000000000 UTC +00:00"),   endAttendingTime: Time.parse("Sat, 01 Jan 2000 17:00:00.000000000 UTC +00:00"), username: "pilar123")
file = URI.open("https://s3.us-east-1.amazonaws.com/doctoralia.com.mx/doctor/ca420f/ca420fff8694b552281e0ba4a3a8c730_large.jpg")
professional8.photo.attach(io: file, filename: user8.name, content_type: "image/jpg")
professional8.save!

user9 = User.new(name: "Mayemi", lastname: "Gutierrez Reyes", phone: "3321011496", password: "12345678", email: "Mayemi@nutrialic.com", nutritionist: true)
user9.save!
professional9= ProfessionalAccountRequest.new(user: user9, branch: "Nutrición Clínica", adress: "Calle General Jerónimo Treviño 1423, 64000 Monterrey, Nuevo León, Mexico", latitude: 25.682878833797147, longitude: -100.32630478987048, diploma: "7109529", first_cost: 800, follow_cost: 600, startAttendingTime: Time.parse("Sat, 01 Jan 2000 10:00:00.000000000 UTC +00:00"),   endAttendingTime: Time.parse("Sat, 01 Jan 2000 17:00:00.000000000 UTC +00:00"), username: "mayemi123")
file = URI.open("https://s3.us-east-1.amazonaws.com/doctoralia.com.mx/doctor/2cfbd6/2cfbd6bbbe9007c63224bd84349daced_large.jpg")
professional9.photo.attach(io: file, filename: user9.name, content_type: "image/jpg")
professional9.save!

user10 = User.new(name: "Nivia", lastname: "Esquivel", phone: "7772073576", password: "12345678", email: "diaxesquivel@gmail.com", nutritionist: true)
user10.save!
professional10= ProfessionalAccountRequest.new(user: user10, branch: "Nutrición Clínica, Médico Cirujano, Educadora en Diabetes ", adress: "Privada De Los Ríos 5, 62140 Cuernavaca, Morelos, Mexico", latitude: 18.950756581523038, longitude: -99.24483150735736, diploma: "6555940", first_cost: 600, follow_cost: 400, startAttendingTime: Time.parse("Sat, 01 Jan 2000 10:00:00.000000000 UTC +00:00"),   endAttendingTime: Time.parse("Sat, 01 Jan 2000 17:00:00.000000000 UTC +00:00"), username: "nivia123")
file = URI.open("https://res.cloudinary.com/dp693fkkc/image/upload/v1667067822/Nivia_kf81oc.jpg")
professional10.photo.attach(io: file, filename: user10.name, content_type: "image/png")
professional10.save!

user = AdminUser.new(email: 'admin@gemhack.io', password: ENV['ADMIN_PASSWORD'], password_confirmation: ENV['ADMIN_PASSWORD'])
user.save