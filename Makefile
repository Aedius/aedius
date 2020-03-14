

build:
	docker build -t aedius/website: .

push:
	docker push aedius/website:0.1.3

helm-test:
	helm install --dry-run --debug ./helm-chart --generate-name -n aedius

helm-install:
	helm install ./helm-chart --generate-name -n aedius
