docker build -t willempoort/multi-client:$SHA -t willempoort/multi-client:latest -f ./client/Dockerfile ./client
docker build -t willempoort/multi-server:$SHA -t willempoort/multi-server:latest -f ./server/Dockerfile ./server
docker build -t willempoort/multi-worker:$SHA -f willempoort/multi-worker:latest -f ./worker/Dockerfile ./worker

docker push willempoort/multi-client:latest
docker push willempoort/multi-client:$SHA
docker push willempoort/multi-server:latest
docker push willempoort/multi-server:$SHA
docker push willempoort/multi-worker:latest
docker push willempoort/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=willempoort/multi-server:$SHA
kubectl set image deployments/client-deployment client=willempoort/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=willempoort/multi-worker:$SHA
