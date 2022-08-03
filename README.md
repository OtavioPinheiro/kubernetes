# Kubernets
Projeto criado com o objetivo de aprender e estudar o Kubernets.

## Sumário
1. [O que é Kubernets?](#o-que-é-kubernets)
2. [O que é Kind?](#o-que-é-kind)
3. [Instalação]()
4. [Comandos do Kubernets]()

# O que é Kubernets?
Kubernets é ...

# O que é Kind?
Kind é ...

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
