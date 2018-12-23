RSpec.shared_examples "endpoint handling RecordNotFound" do |request_method, record_class|

  before do
    send(request_method, path)
  end

  it "responds with HTTP 404 status" do
    expect(response.status).to eq(404)
  end

  it "does not respond with any data" do
    expect(data).not_to be_present
  end

  it "responds with message about not existing record" do
    expect(message).to eql("Couldn't find #{record_class} with 'id'=-1")
  end
end
