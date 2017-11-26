# Writing tests (backend)

We use [RSpec](http://rspec.info/) for our backend tests. It is a great BDD
tool and make the tests easy and enjoyable to write.

## What to test?

We mainly test at a `request` level so we can make sure a request to the API is
successful, it returns data matching with expected schema and data are changed
accordingly to what is expected. Here is a very basic example:

```ruby
RSpec.describe Api::UsersController, type: :request do
  describe 'POST #create' do
    let(:payload) { {
      user: {
        email: 'john@doe.com',
      },
    } }

    subject { post api_users_path, params: payload, as: :json }

    context 'with valid attributes' do
      before { subject }

      it 'succeeds' do
        expect(response).to have_http_status(:created)
      end

      it 'matches the users/create schema' do
        expect(response).to match_response_schema('users/create')
      end

      it 'saves the new user' do
        expect(User.find_by(email: 'john@doe.com')).to be_present
      end
    end
  end
end
```

We also test models for the more complex methods, most of the time [in TDD](https://en.wikipedia.org/wiki/Test-driven_development).

API errors are tested with shared examples present in `spec/shared_examples_for_failures.rb`.
It is used as following:

```ruby
context 'with invalid name' do
  it_behaves_like 'API errors', :unprocessable_entity, {
    errors: [{
      status: '422 Unprocessable Entity',
      code: 'invalid',
      title: 'Resource validation failed',
      detail: 'Resource cannot be saved because of validation constraints.',
      source: { pointer: '/project/name' },
    }],
  }
end
```

Tests are written under `spec/models` and `spec/requests`. You can find some
tests under `spec/mailers` as well for mails but it's very basic.

## Generate data for tests

We use [Factory Girl](https://github.com/thoughtbot/factory_girl) to generate
complex data. For example, if you want to create a finished project, you can
write:

```ruby
project = create(:project, :finished)
```

If you want a list of five tasks:

```ruby
tasks = create_list(:task, 5)
```

Factories are written under `spec/factories/`.
