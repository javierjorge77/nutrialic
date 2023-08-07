# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)
Appointment.destroy_all
GalleryImage.destroy_all
Professional.destroy_all
ProfessionalAccountRequest.destroy_all
User.destroy_all




user = AdminUser.new(email: 'admin@gemhack.io', password: ENV['ADMIN_PASSWORD'], password_confirmation: ENV['ADMIN_PASSWORD'])
user.save