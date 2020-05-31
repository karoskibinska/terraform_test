DOCKER_IMAGE:=karoskibinska/flask-hello
APP_VERSION:=latest

check-aws-env:
	@test -n "${AWS_ACCESS_KEY_ID}" || (echo "AWS_ACCESS_KEY_ID env not set"; exit 1)
	@test -n "${AWS_SECRET_ACCESS_KEY}" || (echo "AWS_SECRET_ACCESS_KEY env not set"; exit 1)

run-local:
	cd app && docker build -t ${DOCKER_IMAGE}:${APP_VERSION} .
	docker run -d -p 8080:5000 ${DOCKER_IMAGE}:${APP_VERSION}

push-to-dockerhub:
	cd app && docker build -t ${DOCKER_IMAGE}:${APP_VERSION} .
	docker login --username "${DOCKER_USERNAME}" --password "${DOCKER_PASSWORD}"
	docker push ${DOCKER_IMAGE}:latest

init: check-aws-env
	terraform init

infra: check-aws-env
	terraform apply

infra-destroy: check-aws-env
	terraform destroy

run-all: push-to-dockerhub init apply
