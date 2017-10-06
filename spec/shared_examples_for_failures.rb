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

RSpec.shared_examples "invalid transition failures" do |resource, transition|
  it_behaves_like "failures", :unprocessable_entity, 'invalid_transition', {
    message: "#{ resource } transition is invalid",
    code: 'invalid_transition',
    resource: resource,
    transition: transition,
  }
end

RSpec.shared_examples "forbidden transition failures" do |resource, code, transition|
  it_behaves_like "failures", :unprocessable_entity, 'forbidden_transition', {
    message: "#{ resource } transition is forbidden",
    code: code,
    resource: resource,
    transition: transition,
  }
end

RSpec.shared_examples "validation failed failures" do |resource, errors|
  it_behaves_like "failures", :unprocessable_entity, 'record_invalid', {
    message: "#{ resource } validation failed",
    code: 'validation_failed',
    resource: resource,
    errors: errors,
  }
end

RSpec.shared_examples "not found failures" do |resource|
  it_behaves_like "failures", :not_found, 'record_not_found', {
    message: "#{ resource } not found",
    code: 'not_found',
    resource: resource,
  }
end
