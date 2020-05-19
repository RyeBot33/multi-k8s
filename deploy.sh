docker build -t ryebot33/multi-client:latest -t ryebot33/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t ryebot33/multi-server:latest -t ryebot33/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t ryebot33/multi-worker:latest -t ryebot33/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push ryebot33/multi-client:latest
docker push ryebot33/multi-server:latest
docker push ryebot33/multi-worker:latest
docker push ryebot33/multi-client:$SHA
docker push ryebot33/multi-server:$SHA
docker push ryebot33/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/client-deployment client=ryebot33/multi-client:$SHA
kubectl set image deployments/server-deployment server=ryebot33/multi-server:$SHA
kubectl set image deployments/worker-deployment worker=ryebot33/multi-worker:$SHA

