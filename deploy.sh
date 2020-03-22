#!/bin/sh

docker build -t karakurty/multi-docker-client:latest -t karakurty/multi-docker-client:$GIT_SHA -f ./client/Dockerfile ./client
docker build -t karakurty/multi-docker-worker:latest -t karakurty/multi-docker-worker:$GIT_SHA -f ./worker/Dockerfile ./worker
docker build -t karakurty/multi-docker-server:latest -t karakurty/multi-docker-server:$GIT_SHA -f ./server/Dockerfile ./server

docker push karakurty/multi-docker-client:latest
docker push karakurty/multi-docker-client:$GIT_SHA
docker push karakurty/multi-docker-worker:latest
docker push karakurty/multi-docker-worker:$GIT_SHA
docker push karakurty/multi-docker-server:latest
docker push karakurty/multi-docker-server:$GIT_SHA

kubectl apply -f k8s

kubectl set image deployments/client-deployment server=karakurty/multi-docker-client:$GIT_SHA
kubectl set image deployments/worker-deployment server=karakurty/multi-docker-worker:$GIT_SHA
kubectl set image deployments/server-deployment server=karakurty/multi-docker-server:$GIT_SHA
