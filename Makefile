.DEFAULT_GOAL := help

run:  ## Run development environment
	docker-compose -f docker-compose-dev.yml up

build:  ## Build Docker image
	docker-compose -f docker-compose-dev.yml build

db-setup:  ## Initialize development database
	docker-compose -f docker-compose-dev.yml run --rm lessy bundle exec rails db:setup

stop:  ## Stop development environment
	docker-compose -f docker-compose-dev.yml stop

clean:  ## Clean development environment
	docker-compose -f docker-compose-dev.yml down

test-back:  ## Run tests (backend)
	docker-compose -f docker-compose-dev.yml run -e RAILS_ENV=test --rm lessy bundle exec rspec

test-front:  ## Run tests (frontend)
	docker-compose -f docker-compose-dev.yml run -e RAILS_ENV=test --rm -w /app/client lessy npm run test

test: test-back test-front

help:
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'

.PHONY: run build db-setup stop clean test test-back test-front help
