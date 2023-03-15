postgres:
	docker run --name simple-bank -p 5455:5432 -e POSTGRES_USER=postgres -e POSTGRES_PASSWORD=postgrespw -d postgres:latest

start:
	docker start simple-bank

stop:
	docker stop simple-bank

createdb:
	docker exec -it simple-bank createdb --username=postgres --owner=postgres simple_bank

dropdb:
	docker exec -it simple-bank dropdb --username=postgres simple_bank

migrateup:
	migrate -path db/migration -database "postgresql://postgres:postgrespw@localhost:5455/simple_bank?sslmode=disable" -verbose up

migratedown:
	migrate -path db/migration -database "postgresql://postgres:postgrespw@localhost:5455/simple_bank?sslmode=disable" -verbose down

sqlc-pull:
	docker pull kjconroy/sqlc

sqlc-init:
	docker run --rm -v "%cd%:/src" -w /src kjconroy/sqlc init

sqlc-run:
	docker run --rm -v "%cd%:/src" -w /src kjconroy/sqlc generate

sqlc-version:
	docker run --rm -v "%cd%:/src" -w /src kjconroy/sqlc version

test:
	go test -v -cover ./...

.PHONY: postgres start stop createdb dropdb migrateup migratedown sqlc-pull sqlc-run sqlc-init test