RSpec.shared_examples 'API errors' do |http_status, error_body|
  it 'fails' do
    expect(response).to have_http_status(http_status)
  end

  it 'matches errors.json schema' do
    expect(response).to match_response_schema('errors')
  end

  it 'returns errors' do
    body = JSON.parse(response.body, symbolize_names: true)
    expect(body).to eq(error_body)
  end
end
