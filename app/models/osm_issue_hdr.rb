class OsmIssueHdr < ApplicationRecord
    before_create do
    current_time = DateTime.now
    current_time_month = Time.now.strftime("%y%m%d")
   	current_count = OsmIssueHdr
   						  .where("trns_doc_no like ?", "#{current_time_month}%")
   						  .count
    number = OsmIssueHdr.where("trns_doc_no like?","#{current_time_month}%").maximum('sequence_number')
      if number 
        sequence_number = "%.5i" %(number +1)
        number = "#{number +1}"
      else
        sequence_number = "%.5i" %(current_count +1)
        number = "#{current_count +1}"
      end
      # location = self.str_loc
      # str_loc = location.chars.last(2).join
 	self.trns_doc_no = "#{current_time_month}#{sequence_number}"
    self.sequence_number =  "#{number}"			  	
  end
end
