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

ActiveRecord::Schema.define(:version => 20110305060316) do

  create_table "banks", :force => true do |t|
    t.string   "name",                                       :null => false
    t.string   "code",       :limit => 20,                   :null => false
    t.boolean  "is_active",                :default => true
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "carrying_bills", :force => true do |t|
    t.date     "bill_date",                                                                                        :null => false
    t.string   "bill_no",                          :limit => 30,                                                   :null => false
    t.string   "goods_no",                         :limit => 30,                                                   :null => false
    t.integer  "from_customer_id"
    t.string   "from_customer_name",               :limit => 60,                                                   :null => false
    t.string   "from_customer_phone",              :limit => 60
    t.string   "from_customer_mobile",             :limit => 60
    t.integer  "to_customer_id"
    t.string   "to_customer_name",                 :limit => 60,                                                   :null => false
    t.string   "to_customer_phone"
    t.string   "to_customer_mobile",               :limit => 60
    t.integer  "from_org_id"
    t.integer  "transit_org_id"
    t.integer  "to_org_id"
    t.string   "to_area",                          :limit => 20
    t.decimal  "insured_amount",                                 :precision => 10, :scale => 2, :default => 0.0
    t.decimal  "insured_rate",                                   :precision => 10, :scale => 2, :default => 0.0
    t.decimal  "insured_fee",                                    :precision => 10, :scale => 2, :default => 0.0
    t.decimal  "carrying_fee",                                   :precision => 10, :scale => 2, :default => 0.0
    t.decimal  "goods_fee",                                      :precision => 10, :scale => 2, :default => 0.0
    t.decimal  "from_short_carrying_fee",                        :precision => 10, :scale => 2, :default => 0.0
    t.decimal  "to_short_carrying_fee",                          :precision => 10, :scale => 2, :default => 0.0
    t.string   "pay_type",                         :limit => 20,                                                   :null => false
    t.integer  "goods_num",                                                                     :default => 1
    t.decimal  "goods_weight",                                   :precision => 10, :scale => 2, :default => 0.0
    t.decimal  "goods_volume",                                   :precision => 10, :scale => 2, :default => 0.0
    t.string   "goods_info"
    t.text     "note"
    t.string   "type",                             :limit => 20
    t.string   "state",                            :limit => 20
    t.boolean  "completed",                                                                     :default => false
    t.boolean  "boolean",                                                                       :default => false
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
    t.decimal  "k_hand_fee",                                     :precision => 15, :scale => 2, :default => 0.0
    t.integer  "transit_info_id"
    t.decimal  "transit_carrying_fee",                           :precision => 15, :scale => 2, :default => 0.0
    t.decimal  "transit_hand_fee",                               :precision => 15, :scale => 2, :default => 0.0
    t.integer  "transit_deliver_info_id"
    t.string   "short_fee_state",                  :limit => 20
    t.integer  "short_fee_info_id"
    t.decimal  "original_carrying_fee",                          :precision => 15, :scale => 2, :default => 0.0
    t.decimal  "original_goods_fee",                             :precision => 15, :scale => 2, :default => 0.0
    t.decimal  "original_insured_amount",                        :precision => 15, :scale => 2, :default => 0.0
    t.decimal  "original_insured_fee",                           :precision => 15, :scale => 2, :default => 0.0
    t.decimal  "original_from_short_carrying_fee",               :precision => 15, :scale => 2, :default => 0.0
    t.decimal  "original_to_short_carrying_fee",                 :precision => 15, :scale => 2, :default => 0.0
  end

  add_index "carrying_bills", ["bill_date"], :name => "index_carrying_bills_on_bill_date"
  add_index "carrying_bills", ["bill_no"], :name => "index_carrying_bills_on_bill_no"
  add_index "carrying_bills", ["completed"], :name => "index_carrying_bills_on_completed"
  add_index "carrying_bills", ["deliver_info_id"], :name => "index_carrying_bills_on_deliver_info_id"
  add_index "carrying_bills", ["from_customer_id"], :name => "index_carrying_bills_on_from_customer_id"
  add_index "carrying_bills", ["from_customer_name"], :name => "index_carrying_bills_on_from_customer_name"
  add_index "carrying_bills", ["from_org_id"], :name => "index_carrying_bills_on_from_org_id"
  add_index "carrying_bills", ["goods_no"], :name => "index_carrying_bills_on_goods_no"
  add_index "carrying_bills", ["load_list_id"], :name => "index_carrying_bills_on_load_list_id"
  add_index "carrying_bills", ["original_bill_id"], :name => "index_carrying_bills_on_original_bill_id"
  add_index "carrying_bills", ["pay_info_id"], :name => "index_carrying_bills_on_pay_info_id"
  add_index "carrying_bills", ["pay_type"], :name => "index_carrying_bills_on_pay_type"
  add_index "carrying_bills", ["payment_list_id"], :name => "index_carrying_bills_on_payment_list_id"
  add_index "carrying_bills", ["post_info_id"], :name => "index_carrying_bills_on_post_info_id"
  add_index "carrying_bills", ["refound_id"], :name => "index_carrying_bills_on_refound_id"
  add_index "carrying_bills", ["settlement_id"], :name => "index_carrying_bills_on_settlement_id"
  add_index "carrying_bills", ["short_fee_info_id"], :name => "index_carrying_bills_on_short_fee_info_id"
  add_index "carrying_bills", ["state"], :name => "index_carrying_bills_on_state"
  add_index "carrying_bills", ["to_customer_id"], :name => "index_carrying_bills_on_to_customer_id"
  add_index "carrying_bills", ["to_customer_name"], :name => "index_carrying_bills_on_to_customer_name"
  add_index "carrying_bills", ["to_org_id"], :name => "index_carrying_bills_on_to_org_id"
  add_index "carrying_bills", ["transit_deliver_info_id"], :name => "index_carrying_bills_on_transit_deliver_info_id"
  add_index "carrying_bills", ["transit_info_id"], :name => "index_carrying_bills_on_transit_info_id"
  add_index "carrying_bills", ["transit_org_id"], :name => "index_carrying_bills_on_transit_org_id"
  add_index "carrying_bills", ["type"], :name => "index_carrying_bills_on_type"
  add_index "carrying_bills", ["user_id"], :name => "index_carrying_bills_on_user_id"

  create_table "claims", :force => true do |t|
    t.integer  "goods_exception_id",                                :null => false
    t.integer  "user_id"
    t.date     "bill_date"
    t.decimal  "act_compensate_fee", :precision => 15, :scale => 2
    t.text     "note"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "claims", ["bill_date"], :name => "index_claims_on_bill_date"
  add_index "claims", ["goods_exception_id"], :name => "index_claims_on_goods_exception_id"
  add_index "claims", ["user_id"], :name => "index_claims_on_user_id"

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

  create_table "customer_fee_info_lines", :force => true do |t|
    t.integer  "customer_fee_info_id"
    t.string   "name",                 :limit => 20,                                                 :null => false
    t.string   "phone",                :limit => 30
    t.decimal  "fee",                                :precision => 15, :scale => 2, :default => 0.0
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "customer_fee_info_lines", ["customer_fee_info_id"], :name => "index_customer_fee_info_lines_on_customer_fee_info_id"

  create_table "customer_fee_infos", :force => true do |t|
    t.integer  "org_id",                  :null => false
    t.string   "mth",        :limit => 6, :null => false
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "customer_fee_infos", ["mth"], :name => "index_customer_fee_infos_on_mth"
  add_index "customer_fee_infos", ["org_id"], :name => "index_customer_fee_infos_on_org_id"
  add_index "customer_fee_infos", ["user_id"], :name => "index_customer_fee_infos_on_user_id"

  create_table "customer_level_configs", :force => true do |t|
    t.integer  "org_id",                                                                   :null => false
    t.string   "name",       :limit => 20,                                                 :null => false
    t.decimal  "from_fee",                 :precision => 15, :scale => 2, :default => 0.0
    t.decimal  "to_fee",                   :precision => 15, :scale => 2, :default => 0.0
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "customer_level_configs", ["org_id"], :name => "index_customer_level_configs_on_org_id"

  create_table "customers", :force => true do |t|
    t.integer  "org_id"
    t.string   "name",              :limit => 60,                                                  :null => false
    t.string   "phone",             :limit => 20
    t.string   "mobile",            :limit => 20
    t.string   "address",           :limit => 60
    t.string   "company",           :limit => 60
    t.string   "code",              :limit => 20
    t.string   "id_number",         :limit => 30
    t.integer  "bank_id"
    t.string   "bank_card",         :limit => 30
    t.boolean  "is_active",                                                      :default => true
    t.text     "note"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "type",              :limit => 20
    t.integer  "config_transit_id"
    t.decimal  "cur_fee",                         :precision => 15, :scale => 2
    t.string   "level",             :limit => 20
    t.string   "last_import_mth",   :limit => 6
    t.string   "state",             :limit => 20
  end

  add_index "customers", ["bank_card"], :name => "index_customers_on_bank_card"
  add_index "customers", ["bank_id"], :name => "index_customers_on_bank_id"
  add_index "customers", ["code"], :name => "index_customers_on_code"
  add_index "customers", ["id_number"], :name => "index_customers_on_id_number"
  add_index "customers", ["is_active"], :name => "index_customers_on_is_active"
  add_index "customers", ["last_import_mth"], :name => "index_customers_on_last_import_mth"
  add_index "customers", ["level"], :name => "index_customers_on_level"
  add_index "customers", ["mobile"], :name => "index_customers_on_mobile"
  add_index "customers", ["name"], :name => "index_customers_on_name"
  add_index "customers", ["org_id"], :name => "index_customers_on_org_id"
  add_index "customers", ["phone"], :name => "index_customers_on_phone"
  add_index "customers", ["state"], :name => "index_customers_on_state"
  add_index "customers", ["type"], :name => "index_customers_on_type"

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

  add_index "deliver_infos", ["deliver_date"], :name => "index_deliver_infos_on_deliver_date"
  add_index "deliver_infos", ["org_id"], :name => "index_deliver_infos_on_org_id"
  add_index "deliver_infos", ["state"], :name => "index_deliver_infos_on_state"
  add_index "deliver_infos", ["user_id"], :name => "index_deliver_infos_on_user_id"

  create_table "distribution_lists", :force => true do |t|
    t.date     "bill_date"
    t.integer  "user_id"
    t.integer  "org_id",                   :null => false
    t.text     "note"
    t.string   "state",      :limit => 20
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "distribution_lists", ["bill_date"], :name => "index_distribution_lists_on_bill_date"
  add_index "distribution_lists", ["org_id"], :name => "index_distribution_lists_on_org_id"
  add_index "distribution_lists", ["state"], :name => "index_distribution_lists_on_state"
  add_index "distribution_lists", ["user_id"], :name => "index_distribution_lists_on_user_id"

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

  add_index "gexception_authorize_infos", ["bill_date"], :name => "index_gexception_authorize_infos_on_bill_date"
  add_index "gexception_authorize_infos", ["goods_exception_id"], :name => "index_gexception_authorize_infos_on_goods_exception_id"
  add_index "gexception_authorize_infos", ["op_type"], :name => "index_gexception_authorize_infos_on_op_type"
  add_index "gexception_authorize_infos", ["user_id"], :name => "index_gexception_authorize_infos_on_user_id"

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

  add_index "goods_exception_identifies", ["bill_date"], :name => "index_goods_exception_identifies_on_bill_date"
  add_index "goods_exception_identifies", ["user_id"], :name => "index_goods_exception_identifies_on_user_id"

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

  add_index "goods_exceptions", ["bill_date"], :name => "index_goods_exceptions_on_bill_date"
  add_index "goods_exceptions", ["carrying_bill_id"], :name => "index_goods_exceptions_on_carrying_bill_id"
  add_index "goods_exceptions", ["exception_type"], :name => "index_goods_exceptions_on_exception_type"
  add_index "goods_exceptions", ["org_id"], :name => "index_goods_exceptions_on_org_id"
  add_index "goods_exceptions", ["state"], :name => "index_goods_exceptions_on_state"
  add_index "goods_exceptions", ["user_id"], :name => "index_goods_exceptions_on_user_id"

  create_table "il_configs", :force => true do |t|
    t.string   "key",        :limit => 60, :null => false
    t.string   "title",      :limit => 60
    t.string   "value",      :limit => 60, :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "il_configs", ["key"], :name => "index_il_configs_on_key"

  create_table "journals", :force => true do |t|
    t.integer  "org_id",                                                                                  :null => false
    t.date     "bill_date",                                                                               :null => false
    t.integer  "user_id"
    t.decimal  "settled_no_rebate_fee",                   :precision => 15, :scale => 2, :default => 0.0
    t.decimal  "deliveried_no_settled_fee",               :precision => 15, :scale => 2, :default => 0.0
    t.string   "input_name_1",              :limit => 20
    t.decimal  "input_fee_1",                             :precision => 15, :scale => 2, :default => 0.0
    t.string   "input_name_2",              :limit => 20
    t.decimal  "input_fee_2",                             :precision => 15, :scale => 2, :default => 0.0
    t.string   "input_name_3",              :limit => 20
    t.decimal  "input_fee_3",                             :precision => 15, :scale => 2, :default => 0.0
    t.decimal  "cash",                                    :precision => 15, :scale => 2, :default => 0.0
    t.decimal  "deposits",                                :precision => 15, :scale => 2, :default => 0.0
    t.decimal  "goods_fee",                               :precision => 15, :scale => 2, :default => 0.0
    t.decimal  "short_fee",                               :precision => 15, :scale => 2, :default => 0.0
    t.decimal  "other_fee",                               :precision => 15, :scale => 2, :default => 0.0
    t.integer  "black_bills",                                                            :default => 0
    t.integer  "red_bills",                                                              :default => 0
    t.integer  "yellow_bills",                                                           :default => 0
    t.integer  "green_bills",                                                            :default => 0
    t.integer  "blue_bills",                                                             :default => 0
    t.integer  "white_bills",                                                            :default => 0
    t.decimal  "current_debt",                            :precision => 15, :scale => 2, :default => 0.0
    t.decimal  "current_debt_2_3",                        :precision => 15, :scale => 2, :default => 0.0
    t.decimal  "current_debt_4_5",                        :precision => 15, :scale => 2, :default => 0.0
    t.decimal  "current_debt_ge_6",                       :precision => 15, :scale => 2, :default => 0.0
    t.text     "note"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "journals", ["bill_date"], :name => "index_journals_on_bill_date"
  add_index "journals", ["org_id"], :name => "index_journals_on_org_id"
  add_index "journals", ["user_id"], :name => "index_journals_on_user_id"

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
    t.integer  "user_id"
  end

  add_index "load_lists", ["bill_date"], :name => "index_load_lists_on_bill_date"
  add_index "load_lists", ["bill_no"], :name => "index_load_lists_on_bill_no"
  add_index "load_lists", ["from_org_id"], :name => "index_load_lists_on_from_org_id"
  add_index "load_lists", ["state"], :name => "index_load_lists_on_state"
  add_index "load_lists", ["to_org_id"], :name => "index_load_lists_on_to_org_id"
  add_index "load_lists", ["user_id"], :name => "index_load_lists_on_user_id"

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

  add_index "orgs", ["code"], :name => "index_orgs_on_code"
  add_index "orgs", ["name"], :name => "index_orgs_on_name"
  add_index "orgs", ["parent_id"], :name => "index_orgs_on_parent_id"
  add_index "orgs", ["simp_name"], :name => "index_orgs_on_simp_name"
  add_index "orgs", ["type"], :name => "index_orgs_on_type"

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

  add_index "pay_infos", ["bill_date"], :name => "index_pay_infos_on_bill_date"
  add_index "pay_infos", ["org_id"], :name => "index_pay_infos_on_org_id"
  add_index "pay_infos", ["state"], :name => "index_pay_infos_on_state"
  add_index "pay_infos", ["type"], :name => "index_pay_infos_on_type"
  add_index "pay_infos", ["user_id"], :name => "index_pay_infos_on_user_id"

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

  add_index "payment_lists", ["bank_id"], :name => "index_payment_lists_on_bank_id"
  add_index "payment_lists", ["bill_date"], :name => "index_payment_lists_on_bill_date"
  add_index "payment_lists", ["org_id"], :name => "index_payment_lists_on_org_id"
  add_index "payment_lists", ["state"], :name => "index_payment_lists_on_state"
  add_index "payment_lists", ["type"], :name => "index_payment_lists_on_type"
  add_index "payment_lists", ["user_id"], :name => "index_payment_lists_on_user_id"

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

  add_index "post_infos", ["bill_date"], :name => "index_post_infos_on_bill_date"
  add_index "post_infos", ["org_id"], :name => "index_post_infos_on_org_id"
  add_index "post_infos", ["state"], :name => "index_post_infos_on_state"
  add_index "post_infos", ["user_id"], :name => "index_post_infos_on_user_id"

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

  add_index "refounds", ["bill_date"], :name => "index_refounds_on_bill_date"
  add_index "refounds", ["from_org_id"], :name => "index_refounds_on_from_org_id"
  add_index "refounds", ["state"], :name => "index_refounds_on_state"
  add_index "refounds", ["to_org_id"], :name => "index_refounds_on_to_org_id"
  add_index "refounds", ["user_id"], :name => "index_refounds_on_user_id"

  create_table "remittances", :force => true do |t|
    t.integer  "from_org_id",                                                               :null => false
    t.integer  "to_org_id",                                                                 :null => false
    t.date     "bill_date",                                                                 :null => false
    t.integer  "user_id"
    t.integer  "refound_id",                                                                :null => false
    t.text     "note"
    t.decimal  "should_fee",                :precision => 15, :scale => 2, :default => 0.0
    t.decimal  "act_fee",                   :precision => 15, :scale => 2, :default => 0.0
    t.string   "state",       :limit => 20
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "remittances", ["bill_date"], :name => "index_remittances_on_bill_date"
  add_index "remittances", ["from_org_id"], :name => "index_remittances_on_from_org_id"
  add_index "remittances", ["refound_id"], :name => "index_remittances_on_refound_id"
  add_index "remittances", ["state"], :name => "index_remittances_on_state"
  add_index "remittances", ["to_org_id"], :name => "index_remittances_on_to_org_id"
  add_index "remittances", ["user_id"], :name => "index_remittances_on_user_id"

  create_table "role_system_function_operates", :force => true do |t|
    t.integer  "role_id",                                       :null => false
    t.integer  "system_function_operate_id",                    :null => false
    t.boolean  "is_select",                  :default => false, :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "role_system_function_operates", ["is_select"], :name => "index_role_system_function_operates_on_is_select"
  add_index "role_system_function_operates", ["role_id"], :name => "index_role_system_function_operates_on_role_id"
  add_index "role_system_function_operates", ["system_function_operate_id"], :name => "rsfo_sf_operate_idx"

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

  add_index "roles", ["is_active"], :name => "index_roles_on_is_active"
  add_index "roles", ["name"], :name => "index_roles_on_name"

  create_table "send_list_backs", :force => true do |t|
    t.integer  "org_id",     :null => false
    t.integer  "sender_id",  :null => false
    t.integer  "user_id"
    t.date     "bill_date"
    t.text     "note"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "send_list_backs", ["bill_date"], :name => "index_send_list_backs_on_bill_date"
  add_index "send_list_backs", ["org_id"], :name => "index_send_list_backs_on_org_id"
  add_index "send_list_backs", ["sender_id"], :name => "index_send_list_backs_on_sender_id"
  add_index "send_list_backs", ["user_id"], :name => "index_send_list_backs_on_user_id"

  create_table "send_list_lines", :force => true do |t|
    t.integer  "send_list_id",                    :null => false
    t.integer  "carrying_bill_id",                :null => false
    t.string   "state",             :limit => 20
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "send_list_post_id"
    t.integer  "send_list_back_id"
  end

  add_index "send_list_lines", ["carrying_bill_id"], :name => "index_send_list_lines_on_carrying_bill_id"
  add_index "send_list_lines", ["send_list_back_id"], :name => "index_send_list_lines_on_send_list_back_id"
  add_index "send_list_lines", ["send_list_id"], :name => "index_send_list_lines_on_send_list_id"
  add_index "send_list_lines", ["send_list_post_id"], :name => "index_send_list_lines_on_send_list_post_id"
  add_index "send_list_lines", ["state"], :name => "index_send_list_lines_on_state"

  create_table "send_list_posts", :force => true do |t|
    t.date     "bill_date"
    t.text     "note"
    t.integer  "user_id"
    t.integer  "sender_id",  :null => false
    t.integer  "org_id",     :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "send_list_posts", ["bill_date"], :name => "index_send_list_posts_on_bill_date"
  add_index "send_list_posts", ["org_id"], :name => "index_send_list_posts_on_org_id"
  add_index "send_list_posts", ["sender_id"], :name => "index_send_list_posts_on_sender_id"
  add_index "send_list_posts", ["user_id"], :name => "index_send_list_posts_on_user_id"

  create_table "send_lists", :force => true do |t|
    t.date     "bill_date",  :null => false
    t.integer  "sender_id",  :null => false
    t.text     "note"
    t.integer  "org_id",     :null => false
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "send_lists", ["bill_date"], :name => "index_send_lists_on_bill_date"
  add_index "send_lists", ["org_id"], :name => "index_send_lists_on_org_id"
  add_index "send_lists", ["sender_id"], :name => "index_send_lists_on_sender_id"
  add_index "send_lists", ["user_id"], :name => "index_send_lists_on_user_id"

  create_table "senders", :force => true do |t|
    t.string   "name",       :limit => 20,                   :null => false
    t.integer  "org_id",                                     :null => false
    t.string   "mobile",     :limit => 20
    t.string   "address",    :limit => 60
    t.boolean  "is_active",                :default => true, :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "senders", ["is_active"], :name => "index_senders_on_is_active"
  add_index "senders", ["name"], :name => "index_senders_on_name"
  add_index "senders", ["org_id"], :name => "index_senders_on_org_id"

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

  add_index "settlements", ["bill_date"], :name => "index_settlements_on_bill_date"
  add_index "settlements", ["org_id"], :name => "index_settlements_on_org_id"
  add_index "settlements", ["state"], :name => "index_settlements_on_state"
  add_index "settlements", ["user_id"], :name => "index_settlements_on_user_id"

  create_table "short_fee_infos", :force => true do |t|
    t.date     "bill_date",                :null => false
    t.integer  "org_id",                   :null => false
    t.integer  "user_id"
    t.string   "state",      :limit => 20
    t.text     "note"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "short_fee_infos", ["bill_date"], :name => "index_short_fee_infos_on_bill_date"
  add_index "short_fee_infos", ["org_id"], :name => "index_short_fee_infos_on_org_id"
  add_index "short_fee_infos", ["state"], :name => "index_short_fee_infos_on_state"
  add_index "short_fee_infos", ["user_id"], :name => "index_short_fee_infos_on_user_id"

  create_table "system_function_groups", :force => true do |t|
    t.string   "name",       :limit => 30,                   :null => false
    t.integer  "order",                    :default => 1
    t.boolean  "is_active",                :default => true, :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "system_function_groups", ["is_active"], :name => "index_system_function_groups_on_is_active"

  create_table "system_function_operates", :force => true do |t|
    t.integer  "system_function_id",                                 :null => false
    t.string   "name",               :limit => 30,                   :null => false
    t.text     "function_obj"
    t.integer  "order",                            :default => 1
    t.boolean  "is_active",                        :default => true, :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "system_function_operates", ["is_active"], :name => "index_system_function_operates_on_is_active"
  add_index "system_function_operates", ["system_function_id"], :name => "index_system_function_operates_on_system_function_id"

  create_table "system_functions", :force => true do |t|
    t.integer  "system_function_group_id",                                 :null => false
    t.string   "subject_title",            :limit => 30,                   :null => false
    t.integer  "order",                                  :default => 1
    t.boolean  "is_active",                              :default => true, :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "default_action"
  end

  add_index "system_functions", ["is_active"], :name => "index_system_functions_on_is_active"
  add_index "system_functions", ["system_function_group_id"], :name => "index_system_functions_on_system_function_group_id"

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

  add_index "transit_companies", ["is_active"], :name => "index_transit_companies_on_is_active"

  create_table "transit_deliver_infos", :force => true do |t|
    t.integer  "org_id",                                                        :null => false
    t.date     "bill_date",                                                     :null => false
    t.text     "note"
    t.decimal  "transit_hand_fee",               :precision => 15, :scale => 2
    t.string   "state",            :limit => 20
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "user_id"
  end

  add_index "transit_deliver_infos", ["bill_date"], :name => "index_transit_deliver_infos_on_bill_date"
  add_index "transit_deliver_infos", ["org_id"], :name => "index_transit_deliver_infos_on_org_id"
  add_index "transit_deliver_infos", ["state"], :name => "index_transit_deliver_infos_on_state"
  add_index "transit_deliver_infos", ["user_id"], :name => "index_transit_deliver_infos_on_user_id"

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

  add_index "transit_infos", ["bill_date"], :name => "index_transit_infos_on_bill_date"
  add_index "transit_infos", ["org_id"], :name => "index_transit_infos_on_org_id"
  add_index "transit_infos", ["state"], :name => "index_transit_infos_on_state"
  add_index "transit_infos", ["transit_company_id"], :name => "index_transit_infos_on_transit_company_id"
  add_index "transit_infos", ["user_id"], :name => "index_transit_infos_on_user_id"

  create_table "user_orgs", :force => true do |t|
    t.integer  "user_id",                       :null => false
    t.integer  "org_id",                        :null => false
    t.boolean  "is_select",  :default => false
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

  add_index "user_roles", ["is_select"], :name => "index_user_roles_on_is_select"
  add_index "user_roles", ["role_id"], :name => "index_user_roles_on_role_id"
  add_index "user_roles", ["user_id"], :name => "index_user_roles_on_user_id"

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
    t.boolean  "use_usb",                            :default => false
    t.string   "usb_pin",             :limit => 32
  end

  add_index "users", ["is_active"], :name => "index_users_on_is_active"
  add_index "users", ["is_admin"], :name => "index_users_on_is_admin"
  add_index "users", ["username"], :name => "index_users_on_username", :unique => true

end
