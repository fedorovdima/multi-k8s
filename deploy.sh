docker build -t ciklumdevops8953/multi-client:latest -t ciklumdevops8953/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t ciklumdevops8953/multi-server:latest -t ciklumdevops8953/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t ciklumdevops8953/multi-worker:latest -t ciklumdevops8953/multi-worker:$SHA -f ./worker/Dockerfile ./worker
docker push ciklumdevops8953/multi-client:latest
docker push ciklumdevops8953/multi-server:latest
docker push ciklumdevops8953/multi-worker:latest

docker push ciklumdevops8953/multi-client:$SHA
docker push ciklumdevops8953/multi-server:$SHA
docker push ciklumdevops8953/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=ciklumdevops8953/multi-server:$SHA
kubectl set image deployments/client-deployment client=ciklumdevops8953/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=ciklumdevops8953/multi-worker:$SHA