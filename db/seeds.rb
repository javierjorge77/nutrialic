# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)


user1 = User.create(name:"Cristel", lastname: "Alvarez", phone: "7773388548", password: "12345678", email: "cristelalvarezvazquez@gmail.com")

Professional.create(user: user1, speciallity: "Nutrición Clínica", adress: "La pradera Cuernavaca", diploma: "10206015", first_cost: 500, follow_cost: 350)

# create_table "professionals", force: :cascade do |t|
#   t.string "speciallity"
#   t.string "adress"
#   t.string "diploma"
#   t.integer "first_cost"
#   t.integer "follow_cost"
#   t.bigint "user_id", null: false
#   t.datetime "created_at", null: false
#   t.datetime "updated_at", null: false
#   t.index ["user_id"], name: "index_professionals_on_user_id"
# end

# create_table "users", force: :cascade do |t|
#   t.string "email", default: "", null: false
#   t.string "encrypted_password", default: "", null: false
#   t.string "reset_password_token"
#   t.datetime "reset_password_sent_at"
#   t.datetime "remember_created_at"
#   t.datetime "created_at", null: false
#   t.datetime "updated_at", null: false
#   t.boolean "nutritionist"
#   t.string "name"
#   t.string "lastname"
#   t.string "phone"
#   t.index ["email"], name: "index_users_on_email", unique: true
#   t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
# end
