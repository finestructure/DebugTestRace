db-up:
	docker run --name vapor_db \
		-e POSTGRES_DB=vapor_database \
		-e POSTGRES_USER=vapor_username \
		-e POSTGRES_PASSWORD=vapor_password \
		-e PGDATA=/pgdata \
		--tmpfs /pgdata:rw,noexec,nosuid,size=1024m \
		-p 5432:5432 \
		-d \
		postgres:13.5-alpine

db-down:
	docker rm -f vapor_db

db-reset: db-down db-up

migrate:
	echo y | swift run Run migrate
