docker build -t omkarsayajihande/multi-client:latest -t omkarsayajihande/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t omkarsayajihande/multi-server:latest -t omkarsayajihande/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t omkarsayajihande/multi-worker:latest -t omkarsayajihande/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push omkarsayajihande/multi-client:latest
docker push omkarsayajihande/multi-server:latest
docker push omkarsayajihande/multi-worker:latest

docker push omkarsayajihande/multi-client:$SHA
docker push omkarsayajihande/multi-server:$SHA
docker push omkarsayajihande/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=omkarsayajihande/multi-server:$SHA
kubectl set image deployments/client-deployment client=omkarsayajihande/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=omkarsayajihande/multi-worker:$SHA