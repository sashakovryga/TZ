class User < ActiveRecord::Base

  has_many :posts, dependent: :destroy
  validates_associated :posts
  self.per_page = 3
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable,
         :validatable

  before_create :role_create

  extend Enumerize
  enumerize :role, in: [:user, :admin, :guest], default: :guest, predicates: true

  protected

  def role_create
    self.role = :user
  end

end
