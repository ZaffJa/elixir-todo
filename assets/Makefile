setup:
	docker run --rm -it -v $(PWD):/app/assets -w /app/assets busybox rm -rf node_modules
	docker run --rm -it -v $(PWD):/app/assets -w /app/assets node:10.15.1-alpine npm install