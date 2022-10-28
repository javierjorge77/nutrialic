# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

user1 = User.create(name:"Cristel", lastname: "Alvarez", phone: "7773388548", password: "12345678", email: "cristelalvarezvazquez@gmail.com")
Professional.create(user: user1, speciallity: "Nutrición Clínica", adress: "Cuautla", diploma: "10206015", first_cost: 500, follow_cost: 350)

user2 = User.create(name:"Noemi ", lastname: "Landa", phone: "7774398683", password: "12345678", email: "nlg.0619@hotmail.com")
Professional.create(user: user2, speciallity: "Nutrición Clínica", adress: "Avenida Cuauhtemoc #170-A local 9 Plaza Romanza", diploma: "10206006", first_cost: 400, follow_cost: 150)

user3 = User.create(name:"Nivia", lastname: "Esquivel", phone: "7772073576", password: "6555940", email: "diaxesquivel@gmail.com")
Professional.create(user: user3, speciallity: "Nutrición Clínica, Educadora en Diabetes ", adress: "Avenida Sn Diego 1203. CP 62330,- Hospital San Diego Cuernavaca , Morelos. Consultorio 406", diploma: "6555940", first_cost: 600, follow_cost: 400)

user4 = User.create(name:"Ana", lastname: "Acuña", phone: "5517005252", password: "12345678", email: "charpinel7@gmail.com")
Professional.create(user: user4, speciallity: "Nutrición Clínica", adress: "Puebla", diploma: "13065988", first_cost: 500, follow_cost: 400)

user5 = User.create(name:"Jessica", lastname: "Penagos", phone: "9611141121", password: "12345678", email: "Penagos_jl@hotmail.com")
Professional.create(user: user5, speciallity: "Nutrición Clínica, Obesidad, Educación en Diabetes", adress: "Puebla", diploma: "11977457", first_cost: 450, follow_cost: 350)
