.PHONY: deps lint test run docker_build docker_run docker_push

# Zmienne bazowe
IMAGE_NAME=hello-world-printer

deps:
	pip install -r requirements.txt
	pip install -r test_requirements.txt

lint:
	flake8 hello_world test

test:
	python -m pytest --verbose -s

docker_build:
	docker build -t $(IMAGE_NAME) .

docker_run: docker_build
	docker run --name hello-world-printer-dev -p 5000:5000 -d $(IMAGE_NAME)

docker_push: docker_build
	@echo "Logowanie jako: $(DOCKER_USER)"
	@echo "$(DOCKER_PASSWORD)" | docker login -u "$(DOCKER_USER)" --password-stdin
	docker tag $(IMAGE_NAME) "$(DOCKER_USER)/$(IMAGE_NAME)"
	docker push "$(DOCKER_USER)/$(IMAGE_NAME)"
	docker logout
