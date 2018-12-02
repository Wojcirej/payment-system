RSpec.shared_examples "paginator service" do

  it "returns as many elements as value of 'per_page' param" do
    expect(subject.call(collection, page, per_page).size).to eq(per_page)
  end

  it "returns elements only from selected page" do
    paginated_elements_ids = subject.call(collection, page, per_page).map { |obj| obj.id }
    expected_elements_ids = [collection.second.id]
    expect(expected_elements_ids).to match_array(paginated_elements_ids)
  end
end

RSpec.shared_examples "paginable endpoint" do

  it "includes 'meta' in response" do
    expect(meta).to be_present
  end

  it "responds with pagination info in 'meta' key" do
    expected_meta_keys = %w(currentPage nextPage prevPage totalPages totalCount)
    expect(meta.keys).to match_array(expected_meta_keys)
  end
end
