DC = docker-compose
DCE = $(DC) exec app

up:
	$(DC) up -d --force-recreate app

setup:
	docker run --rm -it -v $(PWD):/app -w /app busybox rm -rf deps
	docker run --rm -it -v $(PWD):/app -w /app elixir:1.6 sh -c 'mix local.hex --force && mix deps.get'
	cd assets && $(MAKE) setup
	$(DC) build

reset-db:
	$(DCE) mix ecto.rollback --all

migrate-db: reset-db
	$(DCE) mix ecto.migrate

seed-db: migrate-db
	$(DCE) mix run priv/repo/seeds.exs

bash:
	$(DCE) bash

task-start:
	$(DCE) mix start

mix-test:
	$(DC) up -d db_test app
	$(DCE) mix test

down:
	$(DC) down