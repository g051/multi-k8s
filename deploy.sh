docker build -t g051/multi-client:latest -t g051/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t g051/multi-server:latest -t g051/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t g051/multi-worker:latest -t g051/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push g051/multi-client:latest
docker push g051/multi-server:latest
docker push g051/multi-worker:latest

docker push g051/multi-client:$SHA
docker push g051/multi-server:$SHA
docker push g051/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/client-deployment client=g051/multi-client:$SHA
kubectl set image deployments/server-deployment server=g051/multi-server:$SHA
kubectl set image deployments/worker-deployment worker=g051/multi-worker:$SHA
