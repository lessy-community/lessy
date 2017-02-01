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

RSpec.shared_examples "missing param failures" do |resource, field|
  it_behaves_like "failures", :unprocessable_entity, 'parameter_missing', {
    message: 'Param is missing or empty',
    code: 'missing_param',
    resource: resource,
    field: field,
  }
end
