.PHONY: db-up db-down db-migrate run test test-race fmt

db-up:
	docker compose up -d

db-down:
	docker compose down

db-migrate:
	cat migrations/*.sql | docker exec -i wallet-postgres psql -U wallet -d wallet

db-reset:
	docker compose down -v
	docker compose up -d
	sleep 2
	cat migrations/*.sql | docker exec -i wallet-postgres psql -U wallet -d wallet

run:
	DATABASE_URL="postgres://wallet:wallet@localhost:5432/wallet?sslmode=disable" go run ./cmd/server

test:
	go test ./...

test-race:
	go test -race ./...

fmt:
	gofmt -w cmd internal tests