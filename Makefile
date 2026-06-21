.PHONY: deps lint test docker_build docker_push

deps:
	pip install -r requirements.txt
	pip install -r test_requirements.txt

lint:
	flake8 hello_world test

test:
	python -m pytest --verbose -s

docker_build:
	docker build -t hello-world-printer .

docker_push: docker_build
	@echo "$$DOCKER_PASSWORD" | docker login -u "$$DOCKER_USER" --password-stdin
	docker tag hello-world-printer "$$DOCKER_USER/hello-world-printer"
	docker push "$$DOCKER_USER/hello-world-printer"