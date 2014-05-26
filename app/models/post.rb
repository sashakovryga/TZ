class Post < ActiveRecord::Base
  belongs_to :user
  has_many :images, dependent: :destroy
  accepts_nested_attributes_for :images, :allow_destroy => true
  validates :title, presence: true, length: { in: 3..25 }
  validates :description,presence:true, length: { maximum: 300 }
  self.per_page = 3
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
