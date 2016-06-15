FactoryGirl.define do
  factory :Project do
    title "cooking event"
    description "variety of cooking"
    image Rack::Test::UploadedFile.new(Rails.root + 'spec/files/images/project-puzzle.jpg', 'image/jpg')
    id 1
  end
end
