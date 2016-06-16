class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
  :recoverable, :rememberable, :trackable, :validatable
  validates :user_name, presence: true, length: { minimum: 4, maximum: 16 }

  has_many :projects

  validates_uniqueness_of :user_name

  has_and_belongs_to_many :skills

  has_and_belongs_to_many :teams

  has_attached_file :avatar, styles: { medium: '152x152#' }
  validates_attachment_content_type :avatar, content_type: /\Aimage\/.*\Z/
end
