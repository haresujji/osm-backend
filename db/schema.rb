# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `rails
# db:schema:load`. When creating a new database, `rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2020_05_28_084618) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "dblink"
  enable_extension "edb_dblink_libpq"
  enable_extension "edb_dblink_oci"
  enable_extension "edbspl"
  enable_extension "pldbgapi"
  enable_extension "plpgsql"

  create_table "check_lists", force: :cascade do |t|
    t.string "loc", limit: 20
    t.integer "check_list_code"
    t.string "check_list_desc", limit: 100
    t.string "status", limit: 1
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "grn_sap_menge_calculation_v2_temp", id: false, force: :cascade do |t|
    t.integer "trns_id"
    t.string "trns_doc_no", limit: 12
    t.string "po_item", limit: 10
    t.decimal "inv_qty", precision: 12, scale: 3, default: "0.0"
    t.decimal "inv_sum_of_qty", precision: 12, scale: 3, default: "0.0"
    t.decimal "material_net_wgt", precision: 12, scale: 3, default: "0.0"
    t.decimal "actual_material_net_wgt", precision: 12, scale: 3, default: "0.0"
    t.decimal "physical_security_received_qty", precision: 12, scale: 3, default: "0.0"
    t.decimal "material_actual_wgt", precision: 12, scale: 3, default: "0.0"
    t.decimal "min_invoice_qty", precision: 12, scale: 3, default: "0.0"
    t.decimal "max_invoice_qty", precision: 12, scale: 3, default: "0.0"
    t.decimal "variance", precision: 12, scale: 3, default: "0.0"
    t.string "charg", limit: 10
    t.string "vbelp_st", limit: 6
    t.decimal "sap_actual", precision: 12, scale: 3, default: "0.0"
    t.decimal "sap_wd", precision: 12, scale: 3, default: "0.0"
    t.decimal "sap_we", precision: 12, scale: 3, default: "0.0"
    t.decimal "sap_od", precision: 12, scale: 3, default: "0.0"
    t.datetime "created_at"
    t.decimal "sap_oe", precision: 12, scale: 3, default: "0.0"
  end

  create_table "mst_plant", id: false, force: :cascade do |t|
    t.bigserial "mst_plant_id", null: false
    t.string "plant", limit: 4, null: false
    t.string "plant_name", limit: 30, null: false
    t.string "status", limit: 1, default: "A"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "osm_issue_dtls", force: :cascade do |t|
    t.string "trns_doc_no", limit: 20
    t.datetime "trns_doc_date"
    t.string "sto_no", limit: 20
    t.string "plant", limit: 4
    t.string "str_loc", limit: 4
    t.string "source_str_loc", limit: 4
    t.string "source_plant", limit: 4
    t.string "to_plant", limit: 4
    t.string "mat_group_name", limit: 20
    t.string "po_item", limit: 5
    t.string "mat_code", limit: 40
    t.string "mat_desc", limit: 40
    t.string "mat_uom", limit: 2, default: "KG"
    t.string "mat_batch", limit: 20
    t.string "vbelp_st", limit: 10
    t.string "charg", limit: 10
    t.string "lot_no", limit: 40
    t.decimal "sap_batch_qty", precision: 12, scale: 3
    t.datetime "expirty_date"
    t.string "rfid_tag", limit: 40
    t.integer "pallet_no"
    t.decimal "trns_gross_wt", precision: 12, scale: 3
    t.decimal "trns_tare_wt", precision: 12, scale: 3
    t.decimal "trns_net_wt", precision: 12, scale: 3
    t.decimal "transfer_lot", precision: 12, scale: 3
    t.string "trns_status", limit: 1, default: "N"
    t.datetime "trns_transfer_dt"
    t.datetime "trns_ack_update_dt"
    t.string "trns_err_msg", limit: 100
    t.integer "sequence_number"
    t.datetime "sto_date"
    t.string "action_status", limit: 10, default: "open"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.decimal "sap_grn_transfer_lot", precision: 12, default: "0"
    t.string "sto_no_ref", limit: 20
    t.string "sap_batch_ref", limit: 10
    t.decimal "rec_net_wt"
    t.decimal "excess_qty"
    t.string "excess_flag", default: "N"
    t.string "excess_status", limit: 30, default: "open"
  end

  create_table "osm_issue_hdrs", force: :cascade do |t|
    t.string "trns_doc_no", limit: 20
    t.datetime "trns_doc_date"
    t.string "sto_no", limit: 20
    t.string "plant", limit: 4
    t.string "str_loc", limit: 4
    t.string "to_plant", limit: 4
    t.string "source_plant", limit: 4
    t.string "source_str_loc", limit: 4
    t.string "truck_no", limit: 20
    t.string "truck_type", limit: 20
    t.string "trip_type", limit: 20
    t.string "transport_vendor", limit: 50
    t.string "driver_name", limit: 50
    t.string "driver_phone", limit: 10
    t.string "driver_license", limit: 20
    t.decimal "total_truck_wt", precision: 12, scale: 3
    t.decimal "empty_truck_wt", precision: 12, scale: 3
    t.decimal "truck_net_wt", precision: 12, scale: 3
    t.decimal "total_tare_wt", precision: 12, scale: 3
    t.decimal "total_mat_wt", precision: 12, scale: 3
    t.string "truck_flag", limit: 1, default: "N"
    t.string "action_status", default: "open"
    t.string "sap_status", default: "N"
    t.integer "sequence_number"
    t.datetime "sap_transfer_dt"
    t.datetime "sap_ack_update_dt"
    t.datetime "sto_date"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "truck_status", limit: 10, default: "open"
    t.datetime "vehicle_receiving_dt"
    t.string "no_of_bins"
    t.string "truck_route", limit: 6
    t.string "vendor", limit: 10
    t.string "truck_type_desc", limit: 50
    t.string "old_truck_no"
    t.string "old_transport_vendor"
    t.string "old_driver_name"
    t.string "old_driver_phone"
    t.string "old_vendor"
    t.string "old_truck_type"
    t.string "old_truck_type_desc"
  end

  create_table "route_masters", force: :cascade do |t|
    t.string "route_code", limit: 10
    t.string "route_desc", limit: 50
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "transport_masters", force: :cascade do |t|
    t.string "vendor", limit: 10
    t.string "name1", limit: 50
    t.string "city", limit: 50
    t.string "district", limit: 50
    t.string "postal_code", limit: 20
    t.string "region", limit: 5
    t.string "street", limit: 50
    t.string "telephone1", limit: 50
    t.string "taxnumber3", limit: 50
    t.string "pan_no", limit: 50
    t.string "stax_no", limit: 50
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "trn_check_lists", force: :cascade do |t|
    t.string "trns_doc_no", limit: 20
    t.string "loc", limit: 20
    t.integer "check_list_code"
    t.string "check_list_desc", limit: 100
    t.string "status", limit: 1
    t.string "remark", limit: 100
    t.string "checked", limit: 1
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "trn_osm_issue_dtls_json", id: false, force: :cascade do |t|
    t.string "mobunqno", limit: 10
    t.integer "ebelp"
    t.string "reswk", limit: 4
    t.string "reslo", limit: 4
    t.string "matnr", limit: 40
    t.string "ewerk", limit: 4
    t.string "lgort", limit: 4
    t.decimal "bstmg", precision: 12
    t.string "bstme", limit: 4
    t.string "charg", limit: 10
    t.string "eeind", limit: 10
    t.string "zzroute", limit: 6
    t.string "zzvendor", limit: 10
    t.string "zzship", limit: 4
  end

  create_table "trn_po_dtl_temp", id: false, force: :cascade do |t|
    t.string "uslno", limit: 50, null: false
    t.string "ebeln", limit: 10, null: false
    t.string "ebelp", limit: 5, null: false
    t.string "matnr", limit: 40, null: false
    t.decimal "menge", precision: 12, scale: 3, default: "0.0"
    t.string "meins", limit: 3, null: false
    t.string "werks", limit: 4, null: false
    t.string "lifnr", limit: 10, null: false
    t.datetime "bedat", null: false
    t.string "status", limit: 2, default: "N"
    t.string "reason", limit: 60
    t.string "vbelp_st", limit: 6
    t.string "charg", limit: 10
  end

  create_table "trn_sfg_stocks", force: :cascade do |t|
    t.string "plant", limit: 4
    t.string "str_loc", limit: 4
    t.string "sfg_group", limit: 10
    t.string "sfg_code", limit: 16
    t.string "sfg_desc", limit: 50
    t.string "sfg_uom", limit: 3
    t.decimal "stock_qty", precision: 12, scale: 3
    t.decimal "stock_qty_kg", precision: 12, scale: 3
    t.string "lot_no", limit: 15
    t.string "rfid_tag", limit: 30
    t.datetime "expiry_dt"
    t.string "stock_status", limit: 10
    t.string "sap_batch", limit: 10
    t.string "sap_docref", limit: 10
    t.string "sap_status", limit: 1
    t.string "sap_err_msg", limit: 50
    t.datetime "sap_trn_dttime"
    t.datetime "sap_upd_dttime"
    t.datetime "pallet_rfid_date"
    t.string "insp_lot_no", limit: 10
    t.string "sfg_group_name", limit: 30
    t.string "issue_status", default: "N"
    t.string "string", default: "N"
    t.string "sup_roll_ref", limit: 20
    t.string "work_center", limit: 20
    t.string "batch_reference", limit: 40
    t.decimal "gross_wt", precision: 12, scale: 3
    t.decimal "balance_qty", precision: 12, scale: 3
    t.decimal "tare_wt", precision: 12, scale: 3
    t.decimal "issue_qty", precision: 12, scale: 3
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "old_batch_no"
  end

  create_table "trn_sfg_stocks_28052020", id: false, force: :cascade do |t|
    t.bigint "id"
    t.string "plant", limit: 4
    t.string "str_loc", limit: 4
    t.string "sfg_group", limit: 10
    t.string "sfg_code", limit: 16
    t.string "sfg_desc", limit: 50
    t.string "sfg_uom", limit: 3
    t.decimal "stock_qty", precision: 12, scale: 3
    t.decimal "stock_qty_kg", precision: 12, scale: 3
    t.string "lot_no", limit: 15
    t.string "rfid_tag", limit: 30
    t.datetime "expiry_dt"
    t.string "stock_status", limit: 10
    t.string "sap_batch", limit: 10
    t.string "sap_docref", limit: 10
    t.string "sap_status", limit: 1
    t.string "sap_err_msg", limit: 50
    t.datetime "sap_trn_dttime"
    t.datetime "sap_upd_dttime"
    t.datetime "pallet_rfid_date"
    t.string "insp_lot_no", limit: 10
    t.string "sfg_group_name", limit: 30
    t.string "issue_status"
    t.string "string"
    t.string "sup_roll_ref", limit: 20
    t.string "work_center", limit: 20
    t.string "batch_reference", limit: 40
    t.decimal "gross_wt", precision: 12, scale: 3
    t.decimal "balance_qty", precision: 12, scale: 3
    t.decimal "tare_wt", precision: 12, scale: 3
    t.decimal "issue_qty", precision: 12, scale: 3
    t.datetime "created_at", precision: 6
    t.datetime "updated_at", precision: 6
    t.string "old_batch_no"
  end

  create_table "trn_wip_stocks", force: :cascade do |t|
    t.string "rfid_tag", limit: 30
    t.string "plant", limit: 4
    t.string "str_loc", limit: 30
    t.string "mat_group", limit: 10
    t.string "mat_code", limit: 40
    t.string "mat_desc", limit: 40
    t.string "mat_uom", limit: 3
    t.string "mat_qty"
    t.decimal "received_qty", precision: 12, scale: 3
    t.decimal "cons_qty", precision: 12, scale: 3
    t.decimal "bal_qty"
    t.string "comp_lotno", limit: 10
    t.string "sap_batch", limit: 10
    t.datetime "expiry_dt"
    t.string "rfid_status", default: "open"
    t.string "action_status", default: "open"
    t.datetime "load_dttime"
    t.decimal "rm_gross_wt", precision: 12, scale: 3
    t.decimal "tare_wt", precision: 12, scale: 3
    t.decimal "rm_empty_shell_wt", precision: 12, scale: 3
    t.decimal "rm_net_wt", precision: 12, scale: 3
    t.string "vendor_batch", limit: 20
    t.string "unload_type", limit: 10
    t.bigint "user_id"
    t.string "req_no", limit: 10
    t.string "work_center", limit: 30
    t.string "batch_reference", limit: 30
    t.string "gross_wt"
    t.string "comp_batchno", limit: 10
    t.datetime "pallet_rfid_date"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["user_id"], name: "index_trn_wip_stocks_on_user_id"
  end

  create_table "truck_transfer_details", force: :cascade do |t|
    t.string "trns_doc_no", limit: 20
    t.datetime "trns_doc_date"
    t.datetime "truck_transfer_date"
    t.string "sto_no", limit: 20
    t.string "from_truck_no", limit: 20
    t.string "from_transport_vendor", limit: 50
    t.string "from_driver_name", limit: 50
    t.string "to_truck_no", limit: 20
    t.string "to_transport_vendor", limit: 50
    t.string "to_driver_name", limit: 50
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "trucktype_masters", force: :cascade do |t|
    t.string "truck_type", limit: 10
    t.string "truck_type_desc", limit: 50
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

end
