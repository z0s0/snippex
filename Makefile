CLUSTER := snippex-cluster

kind-up:
	kind create cluster \
		--image kindest/node:v1.23.0@sha256:49824ab1727c04e56a21a5d8372a402fcd32ea51ac96a2706a12af38934f81ac \
		--name $(CLUSTER) \
		--config k8s/kind-config.yaml
	kubectl config set-context --current --namespace=snippex

kind-down:
	kind delete cluster --name $(CLUSTER)

kind-load:
	kind load docker-image service --name $(CLUSTER)

kind-status-service:
	kubectl get pods -o wide --watch -n snippex