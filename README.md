# Kubernets
Projeto criado com o objetivo de aprender e estudar o Kubernets.

## Sumário
1. [O que é Kubernets?](#o-que-é-kubernets)
2. [O que é Kind?](#o-que-é-kind)
3. [O que é Minikube?](#o-que-é-minikube)
4. [Conceitos básicos](#conceitos-básicos)
5. [Instalação](#instalação)
6. [Comandos do Kubernets e do kind](#comandos-do-kubernets-e-do-kind)

# O que é Kubernets?
Kubernets é um produto Open Source utilizado para automatizar a implantação, o dimensionamento e o gerenciamento de aplicativos em contâiner. O projeto é hospedado por the Cloud Native Computing Foundation([CNCF](https://www.cncf.io/about))

Referências: [Kubernetes](https://kubernetes.io/pt-br/)
Para saber mais: [O que é Kubernetes?](https://kubernetes.io/pt-br/docs/concepts/overview/what-is-kubernetes/)

## O que o Kubernetes pode fazer?
Os benefícios de ser utilizar o Kubernetes são, basicamente, o escalonamento, recuperação à falha e sistemas distribuídos de forma resiliente. Além disso, o Kubernetes oferece:
1. **Descoberta de serviços e balanceamento de carga**: O Kubernetes pode expor um contêiner usando o nome fornecido pelo DNS ou seu próprio endereço de IP. Se o tráfego para um contêiner for alto, o Kubernetes pode balancear a carga e distribuir o tráfego de rede para que a implantação seja estável.
2. **Orquestração de armazenamento**: O Kubernetes permite que você monte automaticamente um sistema de armazenamento de sua escolha, como armazenamentos locais, provedores de nuvem pública, etc.
3. **Lançamentos e reversões automatizadas**: É possível descrever o estado desejado dos contêineres usando o Kubernetes, alterando o estado real para o estado desejado de forma controlada.
4. **Empacotamento binário automático**: Com Kubernetes você pode criar um cluster com vários nodes (nós) para executar tarefas distintas nos contêineres, podendo informar a quantidade de CPU e de memória RAM que deverá ser alocada para cada um, tendo um melhor aproveitamento desses recursos.
5. **Autocorreção**: O Kubernetes substitui e reinicia os contêineres que falham, elimina os contêineres que não respondem a verificação de integridade e não serve os contêineres aos clientes até que estejam prontos.
6. **Gerenciamento de configuração e Gerenciamento de segredos**: O Kubernetes permite armazenar e gerenciar informações confidenciais, como senhas, tokens *OAuth* e chaves SSH. Você pode implantar e atualizar segredos e configurações de aplicações sem precisar reconstruir as imagens dos contêineres e sem expor segredos nas configurações.

**FONTE:** [Kubernetes - Documentação](https://kubernetes.io/pt-br/docs/concepts/overview/what-is-kubernetes/)

## O que o Kubernetes não é
É importante lembrar que o Kubernetes não se trata de um sistema de serviço como plataforma (*PaaS*), apesar de possuir elementos desse tipo de serviço por operar no nível de contêiner, como balenceamento de carga, escalonamento, implantação, interação do usuário com as suas soluções de *logging*, monitoramento e alerta. Portanto, o Kubernetes:
- Não limita os tipos de aplicações suportadas, ou seja, oferece um grande suporte a uma variedade de cargas de trabalho, incluindo cargas de trabalho sem estado, com estado e de processamento de dados. Se uma aplicação puder ser executada em um contêiner, então ela poderá ser executada perfeitamente no Kubernetes.
- Não implanta o código-fonte e não constrói sua aplicação. Os fluxos de trabalho de Entrega Contínua e de Implantação e Integração Contínua (CI/CD) são determinados pela culturas e preferências da organização.
- Não fornece serviços em nível de aplicação, como *middlewares*, estruturas de processamento de dados, banco de dados, caches, nem sistemas de armazenamento em *cluster* como serviços integrados. Esses componentes podem ser acessados/executados no Kubernetes por meio de outras aplicações que estão sendo executadas no Kubernetes, utilizando os mecanismo portáteis, como o [Open Service Broker](https://www.openservicebrokerapi.org/).
- Não força o uso de determinadas soluções de *logging*, monitoramento e alerta. Apenas fornece algumas integrações como prova de conceito (POC) e mecanismos para coletar e exportar métricas.
- Não fornece e nem exige um sistema de configuração, mas fornece uma API declarativa que pode ser direcionada por formas arbitrárias de especificações declarativas.
- Não fornece e nem adota sistemas abrangentes de configuração de máquinas, manutenção, gerenciamento ou autocorreção.

**FONTE:** [Kubernetes - Documentação](https://kubernetes.io/pt-br/docs/concepts/overview/what-is-kubernetes/)

# O que é Kind?
Kind é uma ferramenta para executar *clusters* Kubernetes locais usando "nós" de container do Docker. Foi projetado principalmente para testar o próprio Kubernetes, mas pode ser usada para desenvolvimento local ou CI.

Referência: [Kind](https://kind.sigs.k8s.io/); [Zup](https://www.zup.com.br/blog/kind-cluster-kubernetes#:~:text=kind%20%C3%A9%20uma%20ferramenta%20para,ferramenta%20em%20seu%20site%20oficial.)

# O que é Minikube?
O Minikube é uma implementação leve do Kubernetes que cria uma VM em sua máquina local e implanta um cluster simples contendo apenas um nó. O Minikube está disponível para sistemas Linux, macOS e Windows. A linha de comando (cli) do Minikube fornece operações básicas de inicialização para trabalhar com seu cluster, incluindo iniciar, parar, status e excluir.

Referência: [Minikube](https://kubernetes.io/pt-br/docs/tutorials/kubernetes-basics/create-cluster/cluster-intro/#:~:text=O%20Minikube%20%C3%A9%20uma%20implementa%C3%A7%C3%A3o,sistemas%20Linux%2C%20macOS%20e%20Windows.)


# Conceitos básicos
A seguir serão descritos alguns conceitos básicos a respeito do Kubernetes, Minikube, Kind e sobre o ambiente de serviços distribuídos em contêineres.

## O que é um Pod?
*Pod*, no Kubernetes, trata-se de um ou mais contêineres agrupados para fins de administração e gerenciamento de rede. Os *Pods* são as menores unidades implantáveis de computação que você pode criar e gerenciar no Kubernetes. Além dos *pods* serem um grupo de um ou mais contêineres que possuem armazenamento e recursos de rede compartilhados, também possuem uma especificação de como executar os contêineres. Assim como as aplicações de contêineres, um *Pod* pode conter um contêiner inicial que é executado durante a inicialização do *Pod*, sendo possível também injetar um contêiner efêmero (contêiner temporário) para *debugging*, se o *cluster* oferecer essa opção. Em resumo, um *pod* é similar a um conjunto de contêineres com *namespaces* e volumes compartilhados.

*Pods* no Kubernetes são usados de duas maneiras principais:
1. ***Pods* que executam um único contêiner**: O modelo de um contêiner por *pod* é o caso de uso mais comum no Kubernetes. Neste caso podemos pensar no *Pod* como sendo uma camada que envolve um único contêiner, assim o Kubernetes gerencia os *pods* ao em vez de gerenciar os contêineres diretamente.
2. ***Pods* que executam múltiplos contêineres que precisam trabalhar juntos**: Um *pod* pode encapsular uma aplicação composta por vários contêineres locais que compartilham os mesmos recursos. Esses contêineres locais formam uma única unidade coesa de serviço, como por exemplo um contêiner que atende dados armazenados em um volume compartilhado para o público, enquanto um outro contêiner (secundário) separado atualiza esses arquivos. O *pod*, então, agrupa esses contêineres, juntamente com os recursos de armazenamento e rede efêmera como uma única unidade.

Cada *Pod* é feito com o objetivo de rodar (executar) apenas uma única instância de uma dada aplicação. Para escalar a aplicação horizontalmente, oferecer mais recursos gerais executando mais instâncias, deve-se usar múltiplos *Pods*, um para cada instância. No Kubernetes isso é referenciado como "replicação". *Pods* replicados geralmente são criados e gerenciados como um grupo pelo recurso de carga de trabalho (*workload*) e seu controlador.

Referência: [*Pods*](#https://kubernetes.io/docs/concepts/workloads/pods/)

# Instalações
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
