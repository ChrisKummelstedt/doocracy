class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
  :recoverable, :rememberable, :trackable, :validatable
  validates :user_name, presence: true, length: { minimum: 4, maximum: 30 }
  devise :omniauthable, :omniauth_providers => [:facebook]
  has_many :projects
  has_many :inventories
  has_one :binder
  has_many :receipts
  has_many :todos
  validates_uniqueness_of :email, :user_name
  has_and_belongs_to_many :skills
  has_and_belongs_to_many :teams
  has_attached_file :avatar, styles: { medium: '152x152#' }
  validates_attachment_content_type :avatar, content_type: /\Aimage\/.*\Z/

  def self.from_omniauth(auth)
    where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
      user.email = auth.info.email
      user.password = Devise.friendly_token[0,20]
      user.user_name = auth.info.name   # assuming the user model has a name
      # user.image = auth.info.image # assuming the user model has an image
    end
  end

  after_create :create_binder

  private

  def create_designer
      Binder.create(user_id: self.id)
  end
end
