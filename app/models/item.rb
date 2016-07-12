class Item < ActiveRecord::Base
  BORROW_STATUS = %W[borrow pending borrowed]

  belongs_to :inventory
  serialize :owner, Array
  serialize :borrowed_by, Array

  acts_as_taggable_on :tags


  has_attached_file :image, styles: { large: "500x500>",
                                      medium: "300x300>",
                                      thumb: "100x100>" }
  do_not_validate_attachment_file_type :image


  def borrow(user)
    self.borrow_secret_key = secret_key
    self.borrow_status = "pending"
    self.borrowed_by << user
  end

  def borrow_accept
    self.borrow_status = 'borrowed'
    self.borrow_secret_key = nil
  end

  def borrow_deny
    self.borrow_status = nil
    self.borrow_secret_key = nil
    self.borrowed_by = []
  end

  def secret_key
    Devise.friendly_token
  end
end
