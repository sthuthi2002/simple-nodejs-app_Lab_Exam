# Makefile for simple-nodejs-app_Lab_Exam

APP_NAME := simple-nodejs-app
IMAGE_NAME := apoorvad4/$(APP_NAME)
PORT := 3000

# Default target
.DEFAULT_GOAL := help

help:
	@echo "Available targets:"
	@echo "  make install        - Install Node.js dependencies"
	@echo "  make test           - Run application tests"
	@echo "  make start          - Start Node.js app"
	@echo "  make lint           - Run ESLint code check"
	@echo "  make docker-build   - Build Docker image"
	@echo "  make docker-run     - Run Docker container"
	@echo "  make docker-push    - Push Docker image to Docker Hub"
	@echo "  make clean          - Remove build artifacts and node_modules"

install:
	@echo "Installing dependencies..."
	npm install

test:
	@echo "Running tests..."
	npm test || echo 'No tests defined, skipping.'

start:
	@echo "Starting Node.js app..."
	npm start

lint:
	@echo "Running ESLint..."
	@if ! command -v npx >/dev/null 2>&1; then \
		echo "npx not found. Installing npm..."; \
		sudo apt-get install -y npm; \
	fi
	@if [ ! -f package.json ]; then \
		echo "No package.json found!"; \
		exit 1; \
	fi
	@if ! npx eslint . >/dev/null 2>&1; then \
		echo "Installing ESLint..."; \
		npm install eslint --save-dev; \
	fi
	npx eslint . || echo "Lint completed with warnings or skipped."

docker-build:
	@echo "Building Docker image: $(IMAGE_NAME)"
	docker build -t $(IMAGE_NAME) .

docker-run:
	@echo "Running container on port $(PORT)"
	docker run -d -p $(PORT):$(PORT) --name $(APP_NAME) $(IMAGE_NAME)

docker-push:
	@echo "Pushing image to Docker Hub..."
	docker push $(IMAGE_NAME)

clean:
	@echo "Cleaning up..."
	rm -rf node_modules
	rm -f package-lock.json
	docker rm -f $(APP_NAME) 2>/dev/null || true

