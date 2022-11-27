# Kubernets
Projeto criado com o objetivo de aprender e estudar o Kubernets.

## Sumário
1. [O que é Kubernets?](#o-que-é-kubernets)
2. [O que é Kind?](#o-que-é-kind)
3. [O que é Minikube?](#o-que-é-minikube)
4. [Conceitos básicos]()
5. [Instalação](#instalação)
6. [Comandos do Kubernets e do kind](#comandos-do-kubernets-e-do-kind)

# O que é Kubernets?
Kubernets é um produto Open Source utilizado para automatizar a implantação, o dimensionamento e o gerenciamento de aplicativos em contâiner. O projeto é hospedado por the Cloud Native Computing Foundation([CNCF](https://www.cncf.io/about))

Referências: [Kubernetes](https://kubernetes.io/pt-br/)
Para saber mais: [O que é Kubernetes?](https://kubernetes.io/pt-br/docs/concepts/overview/what-is-kubernetes/)

# O que é Kind?
Kind é uma ferramenta para executar clusters Kubernetes locais usando "nós" de container do Docker. Foi projetado principalmente para testar o próprio Kubernetes, mas pode ser usada para desenvolvimento local ou CI.

Referência: [Kind](https://kind.sigs.k8s.io/); [Zup](https://www.zup.com.br/blog/kind-cluster-kubernetes#:~:text=kind%20%C3%A9%20uma%20ferramenta%20para,ferramenta%20em%20seu%20site%20oficial.)

# O que é Minikube?
O Minikube é uma implementação leve do Kubernetes que cria uma VM em sua máquina local e implanta um cluster simples contendo apenas um nó. O Minikube está disponível para sistemas Linux, macOS e Windows. A linha de comando (cli) do Minikube fornece operações básicas de inicialização para trabalhar com seu cluster, incluindo iniciar, parar, status e excluir.

Referência: [Minikube](https://kubernetes.io/pt-br/docs/tutorials/kubernetes-basics/create-cluster/cluster-intro/#:~:text=O%20Minikube%20%C3%A9%20uma%20implementa%C3%A7%C3%A3o,sistemas%20Linux%2C%20macOS%20e%20Windows.)


# Conceitos báiscos
A seguir serão descritos alguns conceitos básicos a respeito do Kubernetes, Minikube, Kind e sobre o ambiente de serviços distribuídos em contâiners.

## O que é um POD?
POD, no Kubernetes, trata-se de um ou mais contêineres agrupados para fins de administração e gerenciamento de rede. Os PODS são as menores unidades implantáveis de computação que você pode criar e gerenciar no Kubernetes.

Referência: [PODs](#https://kubernetes.io/docs/concepts/workloads/pods/)


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
