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
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20101209081449) do

  create_table "carrying_bills", :force => true do |t|
    t.date     "bill_date",                                                                             :null => false
    t.string   "bill_no",                 :limit => 30,                                                 :null => false
    t.string   "goods_no",                :limit => 30,                                                 :null => false
    t.integer  "from_customer_id"
    t.string   "from_customer_name",      :limit => 60,                                                 :null => false
    t.string   "from_customer_phone",     :limit => 60
    t.string   "from_customer_mobile",    :limit => 60
    t.integer  "to_customer_id"
    t.string   "to_customer_name",        :limit => 60,                                                 :null => false
    t.string   "to_customer_phone"
    t.string   "to_customer_mobile",      :limit => 60
    t.integer  "from_org_id"
    t.integer  "transit_org_id"
    t.integer  "to_org_id"
    t.string   "to_area",                 :limit => 20
    t.decimal  "insured_amount",                        :precision => 10, :scale => 2, :default => 0.0
    t.decimal  "insured_rate",                          :precision => 10, :scale => 2, :default => 0.0
    t.decimal  "insured_fee",                           :precision => 10, :scale => 2, :default => 0.0
    t.decimal  "carrying_fee",                          :precision => 10, :scale => 2, :default => 0.0
    t.decimal  "goods_fee",                             :precision => 10, :scale => 2, :default => 0.0
    t.decimal  "from_short_carrying_fee",               :precision => 10, :scale => 2, :default => 0.0
    t.decimal  "to_short_carrying_fee",                 :precision => 10, :scale => 2, :default => 0.0
    t.string   "pay_type",                :limit => 20,                                                 :null => false
    t.integer  "goods_num",                                                            :default => 1
    t.decimal  "goods_weight",                          :precision => 10, :scale => 2, :default => 0.0
    t.decimal  "goods_volume",                          :precision => 10, :scale => 2, :default => 0.0
    t.string   "goods_info"
    t.text     "note"
    t.string   "type",                    :limit => 20
    t.string   "state",                   :limit => 20
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "original_bill_id"
    t.integer  "load_list_id"
    t.integer  "distribution_list_id"
    t.integer  "deliver_info_id"
  end

  create_table "deliver_infos", :force => true do |t|
    t.date     "deliver_date",                :null => false
    t.integer  "user_id"
    t.string   "customer_name", :limit => 60, :null => false
    t.string   "customer_no",   :limit => 30
    t.string   "state",         :limit => 30
    t.text     "note"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "distribution_lists", :force => true do |t|
    t.date     "bill_date"
    t.integer  "user_id"
    t.integer  "org_id",                   :null => false
    t.text     "note"
    t.string   "state",      :limit => 20
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "load_lists", :force => true do |t|
    t.date     "bill_date"
    t.string   "bill_no",     :limit => 20
    t.integer  "from_org_id",               :null => false
    t.integer  "to_org_id",                 :null => false
    t.string   "state",       :limit => 20
    t.text     "note"
    t.string   "driver",      :limit => 20
    t.string   "vehicle_no",  :limit => 20
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "orgs", :force => true do |t|
    t.string   "name",            :limit => 60,                   :null => false
    t.string   "simp_name",       :limit => 20
    t.integer  "parent_id"
    t.string   "phone",           :limit => 60
    t.boolean  "is_active",                     :default => true, :null => false
    t.string   "manager",         :limit => 20
    t.string   "location",        :limit => 60
    t.string   "code",            :limit => 20
    t.string   "lock_input_time", :limit => 20
    t.string   "type",            :limit => 20
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "py",              :limit => 20
  end

end
