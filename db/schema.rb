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

ActiveRecord::Schema.define(:version => 20110123091412) do

  create_table "banks", :force => true do |t|
    t.string   "name",                                       :null => false
    t.string   "code",       :limit => 20,                   :null => false
    t.boolean  "is_active",                :default => true
    t.datetime "created_at"
    t.datetime "updated_at"
  end

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
    t.decimal  "insured_rate",                          :precision => 15, :scale => 4, :default => 0.0
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
    t.integer  "settlement_id"
    t.integer  "refound_id"
    t.integer  "payment_list_id"
    t.integer  "pay_info_id"
    t.integer  "post_info_id"
    t.decimal  "k_hand_fee",                            :precision => 15, :scale => 2, :default => 0.0
    t.integer  "transit_info_id"
    t.decimal  "transit_carrying_fee",                  :precision => 15, :scale => 2, :default => 0.0
    t.decimal  "transit_hand_fee",                      :precision => 15, :scale => 2, :default => 0.0
    t.integer  "transit_deliver_info_id"
    t.string   "short_fee_state",         :limit => 20
    t.integer  "short_fee_info_id"
  end

  create_table "claims", :force => true do |t|
    t.integer  "goods_exception_id",                                :null => false
    t.integer  "user_id"
    t.date     "bill_date"
    t.decimal  "act_compensate_fee", :precision => 15, :scale => 2
    t.text     "note"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "config_cashes", :force => true do |t|
    t.decimal  "fee_from",   :precision => 15, :scale => 2, :default => 0.0
    t.decimal  "fee_to",     :precision => 15, :scale => 2, :default => 0.0
    t.decimal  "hand_fee",   :precision => 15, :scale => 2, :default => 0.0
    t.boolean  "is_active",                                 :default => true, :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "config_transits", :force => true do |t|
    t.string   "name",       :limit => 30,                                                   :null => false
    t.decimal  "rate",                     :precision => 10, :scale => 4, :default => 0.001
    t.boolean  "is_active",                                               :default => true,  :null => false
    t.string   "note"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "customers", :force => true do |t|
    t.integer  "org_id"
    t.string   "name",              :limit => 60,                   :null => false
    t.string   "phone",             :limit => 20
    t.string   "mobile",            :limit => 20
    t.string   "address",           :limit => 60
    t.string   "company",           :limit => 60
    t.string   "code",              :limit => 20
    t.string   "id_number",         :limit => 30
    t.integer  "bank_id"
    t.string   "bank_card",         :limit => 30
    t.boolean  "is_active",                       :default => true
    t.text     "note"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "type",              :limit => 20
    t.integer  "config_transit_id"
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
    t.integer  "org_id",                      :null => false
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

  create_table "gexception_authorize_infos", :force => true do |t|
    t.date     "bill_date",                                                                        :null => false
    t.text     "note"
    t.string   "op_type",            :limit => 20,                                                 :null => false
    t.decimal  "compensation_fee",                 :precision => 10, :scale => 2, :default => 0.0
    t.integer  "user_id"
    t.integer  "goods_exception_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "goods_exception_identifies", :force => true do |t|
    t.date     "bill_date",                                                          :null => false
    t.text     "note"
    t.integer  "goods_exception_id",                                                 :null => false
    t.integer  "user_id"
    t.decimal  "from_org_fee",       :precision => 15, :scale => 2, :default => 0.0
    t.decimal  "to_org_fee",         :precision => 15, :scale => 2, :default => 0.0
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "goods_exceptions", :force => true do |t|
    t.integer  "org_id",                                        :null => false
    t.integer  "carrying_bill_id"
    t.string   "exception_type",   :limit => 20
    t.date     "bill_date",                                     :null => false
    t.integer  "user_id"
    t.string   "state",            :limit => 20
    t.integer  "except_num",                     :default => 1
    t.text     "note"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "il_configs", :force => true do |t|
    t.string   "key",        :limit => 60, :null => false
    t.string   "title",      :limit => 60
    t.string   "value",      :limit => 60, :null => false
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

  create_table "pay_infos", :force => true do |t|
    t.integer  "org_id"
    t.integer  "user_id"
    t.string   "customer_name", :limit => 30, :null => false
    t.string   "id_number",     :limit => 30
    t.string   "state",         :limit => 20
    t.text     "note"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.date     "bill_date",                   :null => false
    t.string   "type",          :limit => 20
  end

  create_table "payment_lists", :force => true do |t|
    t.integer  "bank_id"
    t.integer  "org_id"
    t.integer  "user_id"
    t.string   "state",      :limit => 20
    t.string   "type",       :limit => 20
    t.text     "note"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.date     "bill_date",                :null => false
  end

  create_table "post_infos", :force => true do |t|
    t.integer  "org_id"
    t.integer  "user_id"
    t.text     "note"
    t.date     "bill_date",                                                                :null => false
    t.decimal  "amount_fee",               :precision => 15, :scale => 2, :default => 0.0
    t.string   "state",      :limit => 20
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "refounds", :force => true do |t|
    t.date     "bill_date",                                                                      :null => false
    t.integer  "from_org_id",                                                                    :null => false
    t.integer  "to_org_id",                                                                      :null => false
    t.string   "state",            :limit => 20
    t.integer  "user_id"
    t.text     "note"
    t.decimal  "sum_goods_fee",                  :precision => 15, :scale => 2, :default => 0.0
    t.decimal  "sum_carrying_fee",               :precision => 15, :scale => 2, :default => 0.0
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "role_orgs", :force => true do |t|
    t.integer  "role_id",                       :null => false
    t.integer  "org_id",                        :null => false
    t.boolean  "is_select",  :default => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "role_system_function_operates", :force => true do |t|
    t.integer  "role_id",                                       :null => false
    t.integer  "system_function_operate_id",                    :null => false
    t.boolean  "is_select",                  :default => false, :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "role_system_functions", :force => true do |t|
    t.integer  "role_id"
    t.integer  "system_function_id"
    t.boolean  "is_select",          :default => false, :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "roles", :force => true do |t|
    t.string   "name",       :limit => 30,                   :null => false
    t.boolean  "is_active",                :default => true, :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "send_list_lines", :force => true do |t|
    t.integer  "send_list_id",                    :null => false
    t.integer  "carrying_bill_id",                :null => false
    t.string   "state",             :limit => 20
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "send_list_post_id"
  end

  create_table "send_list_posts", :force => true do |t|
    t.date     "bill_date"
    t.text     "note"
    t.integer  "user_id"
    t.integer  "sender_id",  :null => false
    t.integer  "org_id",     :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "send_lists", :force => true do |t|
    t.date     "bill_date",  :null => false
    t.integer  "sender_id",  :null => false
    t.text     "note"
    t.integer  "org_id",     :null => false
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "senders", :force => true do |t|
    t.string   "name",       :limit => 20,                   :null => false
    t.integer  "org_id",                                     :null => false
    t.string   "mobile",     :limit => 20
    t.string   "address",    :limit => 60
    t.boolean  "is_active",                :default => true, :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "settlements", :force => true do |t|
    t.string   "title",            :limit => 60
    t.integer  "org_id",                                                                         :null => false
    t.decimal  "sum_goods_fee",                  :precision => 15, :scale => 2, :default => 0.0
    t.decimal  "sum_carrying_fee",               :precision => 15, :scale => 2, :default => 0.0
    t.integer  "user_id"
    t.text     "note"
    t.string   "state",            :limit => 20
    t.datetime "created_at"
    t.datetime "updated_at"
    t.date     "bill_date",                                                                      :null => false
  end

  create_table "short_fee_infos", :force => true do |t|
    t.date     "bill_date",                :null => false
    t.integer  "org_id",                   :null => false
    t.integer  "user_id"
    t.string   "state",      :limit => 20
    t.text     "note"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "system_function_groups", :force => true do |t|
    t.string   "name",       :limit => 30,                   :null => false
    t.integer  "order",                    :default => 1
    t.boolean  "is_active",                :default => true, :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "system_function_operates", :force => true do |t|
    t.integer  "system_function_id",                                 :null => false
    t.string   "name",               :limit => 30,                   :null => false
    t.text     "function_obj"
    t.integer  "order",                            :default => 1
    t.boolean  "is_active",                        :default => true, :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "system_functions", :force => true do |t|
    t.integer  "system_function_group_id",                                 :null => false
    t.string   "subject_title",            :limit => 30,                   :null => false
    t.integer  "order",                                  :default => 1
    t.boolean  "is_active",                              :default => true, :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "default_action"
  end

  create_table "transit_companies", :force => true do |t|
    t.string   "name",       :limit => 60,                   :null => false
    t.string   "address",    :limit => 60
    t.string   "phone",      :limit => 30
    t.boolean  "is_active",                :default => true
    t.text     "note"
    t.string   "leader",     :limit => 20
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "transit_deliver_infos", :force => true do |t|
    t.integer  "org_id",                                                        :null => false
    t.integer  "uer_id"
    t.date     "bill_date",                                                     :null => false
    t.text     "note"
    t.decimal  "transit_hand_fee",               :precision => 15, :scale => 2
    t.string   "state",            :limit => 20
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "transit_infos", :force => true do |t|
    t.integer  "org_id",                                                                             :null => false
    t.integer  "user_id"
    t.integer  "transit_company_id",                                                                 :null => false
    t.string   "to_station_phone",     :limit => 30
    t.date     "bill_date",                                                                          :null => false
    t.string   "state",                :limit => 20
    t.decimal  "transit_carrying_fee",               :precision => 15, :scale => 2, :default => 0.0
    t.text     "note"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "user_roles", :force => true do |t|
    t.integer  "user_id"
    t.integer  "role_id"
    t.boolean  "is_select",  :default => false, :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", :force => true do |t|
    t.string   "email",                              :default => ""
    t.string   "encrypted_password",  :limit => 128, :default => "",    :null => false
    t.string   "password_salt",                      :default => "",    :null => false
    t.string   "remember_token"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",                      :default => 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.boolean  "is_active",                          :default => true
    t.boolean  "is_admin",                           :default => false
    t.string   "username",            :limit => 20,                     :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "default_org_id"
    t.integer  "default_role_id"
  end

  add_index "users", ["username"], :name => "index_users_on_username", :unique => true

end
