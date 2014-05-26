class Post < ActiveRecord::Base
	belongs_to :user
	state_machine :life_cycle, initial: :draft do
 
		event :go_to_new do
			transition :draft => :new_post
		end
		 
		event :good_post do
			transition :new_post => :approved
		end
		 
		event :go_to_draft do
			transition [:new_post,:archive] => :draft
		end
		 
		event :published do
			transition :approved => :publish
		end
		 
		event :go_to_archive do
			transition :publish => :archive
		end

	state :new_post
	state :approved
	state :archive
	state :publish

	end
end
