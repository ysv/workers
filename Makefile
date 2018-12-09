build:
	docker build -t gcr.io/penny-auction-project/workers .

push:
	gcloud docker -- push gcr.io/penny-auction-project/workers

deploy:
	helm install charts/penny-auction-worker --name penny-auction-worker-lot-created
