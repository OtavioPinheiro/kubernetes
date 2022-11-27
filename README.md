# Kubernets
Projeto criado com o objetivo de aprender e estudar o Kubernets.

## Sumário
1. [O que é Kubernets?](#o-que-é-kubernets)
2. [O que é Kind?](#o-que-é-kind)
3. [O que é Minikube?](#o-que-é-minikube)
4. [Instalação](#instalação)
5. [Comandos do Kubernets e do kind](#comandos-do-kubernets-e-do-kind)

# O que é Kubernets?
Kubernets é um produto Open Source utilizado para automatizar a implantação, o dimensionamento e o gerenciamento de aplicativos em contâiner. O projeto é hospedado por the Cloud Native Computing Foundation([CNCF](https://www.cncf.io/about))

Referências: [Kubernetes](https://kubernetes.io/pt-br/)
Para saber mais: [O que é Kubernetes?](https://kubernetes.io/pt-br/docs/concepts/overview/what-is-kubernetes/)

# O que é Kind?
Kind é uma ferramenta para executar clusters Kubernetes locais usando "nós" de container do Docker. Foi projetado principalmente para testar o próprio Kubernetes, mas pode ser usada para desenvolvimento local ou CI.

Referência: [Kind](https://kind.sigs.k8s.io/); [Zup](https://www.zup.com.br/blog/kind-cluster-kubernetes#:~:text=kind%20%C3%A9%20uma%20ferramenta%20para,ferramenta%20em%20seu%20site%20oficial.)

# O que é Minikube?


# Instalação
Para usar o Kubernets é necessário ...

# Comandos do Kubernets e do Kind
Tabela de comandos do Kubernets

| Comando | Para que serve |
|---------|----------------|
| `kind create cluster --config=k8s/kind.yaml --name=fullcycle` |  |
| `kubectl cluster-info --context kind-fullcycle` |  |
| `kubectl config get-clusters` |  |
| `kind get clusters` | Comando usado para retornar uma lista de clusters que estão ativos. |
| `kind delete clusters <cluster-name>` |  |
| `kubectl apply -f <filepath>` | Comando usado para executar determinadas especificações descritas em um arquivo. |
| `kubectl get replicasets` | Comando usado para retornar uma lista de replicas. |
| `kubectl get services` | Comando usado para retornar uma lista de serviços. |
| `kubectl rollout history deployment goserver` |  |
| `kubectl rollout undo deployment <nome-do-deploy> --> volta para a última versão` |  |
| `kubectl rollout undo deployment <deploy-name> --to-revision=<revision-number>` |  |
| `kubectl describe pod <pod-name>` |  |
| `kubectl port-forward pod/<pod-name> <host-port>:<pod-port>` |  |
| `kubectl port-forward svc/<service-name> <host-port>:<service-port>`|  |
| `kubectl proxy --port=8080` |  |
