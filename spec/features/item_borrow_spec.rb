require 'spec_helper'

feature "item borrow feature" do
  before do
    user = create :user
  end

  after do
    remove_uploaded_file
  end

  scenario "item borrow should approved with secret key" do
    log_in
    create_inventory_tagged_item

    visit("/inventories/#{Inventory.last.id}/tags/#{Tag.last.name.capitalize}")
    click_button "borrow #{Item.last.title}"

    expect(page).to have_content "Request to owner has been sent"

    visit(inventory_item_borrow_processing_url(Inventory.last.id, Item.last.id) + '?borrow_secret_key=' + Item.last.borrow_secret_key + '&answer_status=accept' )
    expect(page).to have_content "The item has been approved"

    visit("/inventories/#{Inventory.last.id}/tags/#{Tag.last.name.capitalize}")
    page.body.include?("borrowed by #{User.last.user_name.capitalize}, #{Item.last.title}")
  end
end
