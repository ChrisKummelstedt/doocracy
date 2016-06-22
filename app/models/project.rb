class Project < ActiveRecord::Base

  validates :user_id, :title, :description, :total_budget, presence: true
  belongs_to :user
  has_many :teams, dependent: :destroy

  has_attached_file :image, styles: { large: "500x500>", medium: "300x300>", thumb: "100x100>" }
  validates_attachment_content_type :image, :content_type => /\Aimage\/.*\Z/

end
