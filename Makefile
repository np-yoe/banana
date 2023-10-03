build:
	docker build --progress=plain -t banana .

run:
	docker run -it --rm banana
