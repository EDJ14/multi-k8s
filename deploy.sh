docker build -t eddiedj/multi-client:latest -t eddiedj/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t eddiedj/multi-server:latest -t eddiedj/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t eddiedj/multi-worker:latest -t eddiedj/multi-worker:$SHA  -f ./worker/Dockerfile ./worker
docker push eddiedj/multi-client:latest
docker push eddiedj/multi-server:latest
docker push eddiedj/multi-worker:latest

docker push eddiedj/multi-client:$SHA
docker push eddiedj/multi-server:$SHA
docker push eddiedj/multi-worker:$SHA

kubectl apply -f k8s 
kubectl set image deployments/server-deployment server=eddiedj/multi-server:$SHA
kubectl set image deployments/client-deployment client=eddiedj/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=eddiedj/multi-worker:$SHA 