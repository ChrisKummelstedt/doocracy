
feature "Budget item" do
  after do
    remove_uploaded_file
  end
  scenario "adding a budget item" do
    create_project
    create_team
    visit('/budgets')
    fill_in("Budget item", with: "Hammer")
    fill_in("Quantity", with: 1)
    fill_in("Cost per item", with: 3)
    click_button "Add budget item"
    expect(page).to have_content("Hammer")
    expect(page).to have_content(1)
    expect(page).to have_content(3.0)
  end

  scenario "delete a budget item" do
    create_project
    create_team
    visit('/budgets')
    fill_in("Budget item", with: "Hammer")
    fill_in("Quantity", with: 1)
    fill_in("Cost per item", with: 3)
    click_button "Add budget item"
    click_link("delete budget item")
    expect(page).not_to have_content("Hammer")
    expect(page).not_to have_content(1)
    expect(page).not_to have_content(3.0)
  end
end
