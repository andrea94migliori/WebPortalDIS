# encoding: UTF-8
# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20161031194948) do

  create_table "employees", force: true do |t|
    t.datetime "created_at",                              null: false
    t.datetime "updated_at",                              null: false
    t.string   "new"
    t.string   "nome"
    t.string   "cognome"
    t.string   "sesso"
    t.date     "dataNascita"
    t.string   "nazioneNascita"
    t.string   "luogoNascita"
    t.string   "nazioneResidenza"
    t.string   "cittaResidenza"
    t.string   "indirizzo"
    t.string   "tipoAccount",      default: "Dipendente"
    t.string   "email"
    t.string   "password_digest"
    t.string   "regione"
    t.string   "regioneResidenza"
    t.boolean  "email_confirmed"
    t.string   "confirm_token"
    t.string   "lingua",           default: "it"
    t.string   "reset_digest"
    t.datetime "reset_sent_at"
  end

  add_index "employees", ["email"], name: "index_employees_on_email", unique: true

  create_table "indirizzimacs", force: true do |t|
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.string   "hostname"
    t.string   "macAddress"
    t.string   "dispositivo"
    t.string   "connessione"
    t.integer  "employee_id"
    t.integer  "vlan_id"
  end

  add_index "indirizzimacs", ["employee_id", "created_at"], name: "index_indirizzimacs_on_employee_id_and_created_at"
  add_index "indirizzimacs", ["employee_id"], name: "index_indirizzimacs_on_employee_id"
  add_index "indirizzimacs", ["vlan_id"], name: "index_indirizzimacs_on_vlan_id"

  create_table "visitors", force: true do |t|
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
    t.string   "nome"
    t.string   "sesso"
    t.date     "dataNascita"
    t.string   "nazioneNascita"
    t.string   "luogoNascita"
    t.string   "nazioneResidenza"
    t.string   "cittaResidenza"
    t.string   "indirizzo"
    t.string   "matricola"
    t.string   "email"
    t.string   "regione"
    t.string   "regioneResidenza"
    t.string   "password_digest"
    t.integer  "employee_id"
    t.string   "cognome"
  end

  add_index "visitors", ["email"], name: "index_visitors_on_email", unique: true
  add_index "visitors", ["matricola"], name: "index_visitors_on_matricola", unique: true

  create_table "visits", force: true do |t|
    t.datetime "created_at",                         null: false
    t.datetime "updated_at",                         null: false
    t.date     "dal"
    t.date     "al"
    t.integer  "idVisit"
    t.integer  "employee_id"
    t.integer  "visitor_id"
    t.string   "status",      default: "Confermata"
  end

  add_index "visits", ["dal", "al", "visitor_id"], name: "index_visits_on_dal_and_al_and_visitor_id", unique: true

  create_table "vlans", force: true do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string   "nome"
    t.integer  "vlanID"
  end

end
