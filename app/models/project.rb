class Project < ActiveRecord::Base

  validates :user_id, :title, :description, :total_budget, :address, presence: true

  belongs_to :user
  has_many :teams, dependent: :destroy
  has_many :stacks
  has_many :inventories, through: :stacks
  serialize :controller


  geocoded_by :address   # can also be an IP address
  after_validation :geocode          # auto-fetch coordinates
  has_attached_file :image, styles: { large: "500x500>", medium: "300x300>", thumb: "100x100>", circle: "152x152#"}, :default_url => "default-avatar.jpg"
  validates_attachment_content_type :image, :content_type => /\Aimage\/.*\Z/


  def self.search(search)
    where("title ILIKE ? OR description ILIKE ? OR address ILIKE ?", "%#{search}%", "%#{search}%", "%#{search}%")
  end

end
