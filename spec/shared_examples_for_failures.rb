RSpec.shared_examples "failures" do |http_status, schema, error_body|
  it 'fails' do
    expect(response).to have_http_status(http_status)
  end

  it 'matches an error schema' do
    expect(response).to match_response_schema("errors/#{ schema }")
  end

  it 'returns an error' do
    body = JSON.parse(response.body, symbolize_names: true)
    expect(body).to eq(error_body)
  end
end
