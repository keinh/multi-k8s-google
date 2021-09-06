docker build -t khilario/multi-client:latest -t khilario/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t khilario/multi-server:latest -t khilario/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t khilario/multi-worker:latest -t khilario/multi-worker:$SHA -f ./worker/Dockerfile ./worker
docker push khilario/multi-client
docker push khilario/multi-server
docker push khilario/multi-worker

docker push khilario/multi-client:$SHA
docker push khilario/multi-server:$SHA
docker push khilario/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=khilario/multi-server:$SHA
kubectl set image deployments/client-deployment client=khilario/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=khilario/multi-worker:$SHA
