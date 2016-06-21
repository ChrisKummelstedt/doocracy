class Item < ActiveRecord::Base
  acts_as_taggable
  belongs_to :inventory

  has_attached_file :image,
                    styles: { large: "500x500>", medium: "300x300>", thumb: "100x100>" },
                    :storage => :s3,
                    :s3_credentials => {
                      :access_key_id => ENV['AWS_ACCESS_KEY_ID'],
                      :secret_access_key => ENV['AWS_SECRET_ACCESS_KEY']
                    },
                    :path => '/:class/:attachment/:id_partition/:style/:filename',
                    :url => ":s3_domain_url"
    do_not_validate_attachment_file_type :image

end
