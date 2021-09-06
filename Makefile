web:
	docker build -t registry.sdickinson.dev/eater_computer .
	docker push registry.sdickinson.dev/eater_computer:latest

.PHONY: web