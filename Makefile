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

test:  ## Run tests
	docker-compose -f docker-compose-test.yml run --rm lessy bundle exec rspec

help:
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'

.PHONY: run build db-setup stop clean test help
