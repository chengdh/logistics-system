class CustomerFeeInfoLineObserver < ActiveRecord::Observer
  def after_save(fee_info_line)
    puts 'after_save'
    update_imported_customer(fee_info_line)
  end
  private
  def update_imported_customer(fee_info_line)
    imported_customer = ImportedCustomer.find_or_create_by_org_id_and_name_and_phone(fee_info_line.customer_fee_info.org.id,fee_info_line.name,fee_info_line.phone)
    imported_customer.update_attributes(:cur_fee => fee_info_line.fee,:last_import_mth => 1.months.ago.strftime('%Y%m'))
  end
end
