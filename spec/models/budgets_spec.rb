describe Budget, type: :model do
  let!(:budget) do
    Budget.create(budget_item: "pizza", quantity: "3",
                  cost_per_item: "3")
  end
  it "adds total of budget items" do
    expect(Budget.first.sum(Budget.all)).to eq(9)
  end
end
