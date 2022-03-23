class TrnWipStock < ApplicationRecord

	before_update do
	  self.pallet_rfid_date = Time.now
   	end	
end
