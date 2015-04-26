class Status < ActiveRecord::Base
	belongs_to :user

	def name
		self.user.profile_name
	end
end
