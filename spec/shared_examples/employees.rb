RSpec.shared_examples "Employee created" do

  it "creates one new Employee" do
    expect { subject }.to change { Employee.count }.by(1)
  end

  it "assigns 'first name' as in params" do
    expect(subject.first_name).to eq(params[:first_name])
  end

  it "assigns 'last name' as in params" do
    expect(subject.last_name).to eq(params[:last_name])
  end

  it "assigns 'address' as in params" do
    expect(subject.address).to eq(params[:address])
  end

  it "assigns 'provision' as in params" do
    expect(subject.provision).to eq(params[:provision])
  end
end

RSpec.shared_examples "Employee not created" do

  it "does not create new Employee" do
    expect { subject }.not_to change { Employee.count }
  end
end
