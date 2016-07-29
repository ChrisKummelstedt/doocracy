class Item < ActiveRecord::Base
  belongs_to :inventory
  serialize :owner

  acts_as_taggable_on :tags


  has_attached_file :image,
                    styles: { medium: "400x400>" },
                    :storage => :s3,
                    :s3_credentials => {
                      :access_key_id => ENV['AWS_ACCESS_KEY_ID'],
                      :secret_access_key => ENV['AWS_SECRET_ACCESS_KEY']
                    },
                    :path => '/:class/:attachment/:id_partition/:style/:filename',
                    :url => ":s3_domain_url"
    do_not_validate_attachment_file_type :image

end
