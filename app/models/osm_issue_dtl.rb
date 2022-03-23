class OsmIssueDtl < ApplicationRecord
	before_create do
   	current_count = OsmIssueDtl.select('max(pallet_no)')
   						  .where("trns_doc_no=?",self.trns_doc_no)
    puts current_count.to_json
      if !current_count.first.max.blank?
      	puts "if"
      	puts current_count.first.max
        sequence_number = current_count.first.max + 1
      else
      	puts "else"
      	sequence_number = 1
      end
 	  self.pallet_no = "#{sequence_number}"				  	
  end
end
