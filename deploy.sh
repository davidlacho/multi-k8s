docker build -t davidlacho/multi-client:latest -t davidlacho/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t davidlacho/multi-server:latest -t davidlacho/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t davidlacho/multi-worker:latest -t davidlacho/multi-worker:$SHA -f ./worker/Dockerfile ./worker
docker push davidlacho/multi-client:latest
docker push davidlacho/multi-client:$SHA
docker push davidlacho/multi-server:latest
docker push davidlacho/multi-server:$SHA
docker push davidlacho/multi-worker:latest
docker push davidlacho/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=davidlacho/multi-server:$SHA
kubectl set image deployments/client-deployment client=davidlacho/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=davidlacho/multi-worker:$SHA