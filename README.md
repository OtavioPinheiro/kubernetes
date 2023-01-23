# Kubernets
Projeto criado com o objetivo de aprender e estudar o Kubernets.

## Sumário
1. [O que é Kubernets?](#o-que-é-kubernets)
2. [Tipos de serviços no Kubernetes](#tipos-de-serviços-no-kubernetes)
3. [O que é Kind?](#o-que-é-kind)
4. [O que é Minikube?](#o-que-é-minikube)
5. [Conceitos básicos](#conceitos-básicos)
6. [O que é um pod?](#o-que-é-um-pod)
7. [O que é um cluster](#o-que-é-um-cluster)
8. [Instalações](#instalações)
9. [Comandos do Kubernets e do kind](#comandos-do-kubernets-e-do-kind)
10. [Dicas](#dicas)
11. [Para lembrar](#para-lembrar)

# O que é Kubernets?
Kubernets é um produto Open Source utilizado para automatizar a implantação, o dimensionamento e o gerenciamento de aplicativos em contâiner. O projeto é hospedado por the Cloud Native Computing Foundation([CNCF](https://www.cncf.io/about))

**Referências:**
- [Kubernetes](https://kubernetes.io/pt-br/)

**Para saber mais:**
- [O que é Kubernetes?](https://kubernetes.io/pt-br/docs/concepts/overview/what-is-kubernetes/)

[Voltar para o sumário](#sumário)

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

[Voltar para o sumário](#sumário)

# Tipos de serviços no Kubernetes
No Kubernetes existem, basicamente, cinco(5) tipos de serviços: 
- [ClusterIP](#clusterip): os clientes internos enviam solicitações para um endereço IP interno estável.
- [NodePort](#nodeport): os clientes enviam solicitações para o endereço IP de um nó em um ou mais valores nodePort especificados pelo serviço.
- [LoadBalancer](#loadbalancer): os clientes enviam solicitações para o endereço IP de um balanceador de carga de rede.
- [ExternalName](#externalname): os clientes internos usam o nome DNS de um serviço como um alias para um nome DNS externo.
- [Headless](#headless): use um serviço sem comando (*Headless*) quando quiser um agrupamento de *pods*, mas sem precisar de um endereço IP estável.

O tipo **NodePort** é uma extensão do tipo **ClusterIP**. Portanto, um serviço do tipo **NodePort** tem um endereço IP de *cluster*. O tipo **LoadBalancer** é uma extensão do tipo **NodePort**. Portanto, um *Service* do tipo **LoadBalancer** tem um endereço IP de *cluster* e um ou mais valores **NodePort**.

Vamos falar de cada um desses serviços, mas antes vamos entender o que é um serviço no Kubernetes.

## O que é um serviço no Kubernetes?
Um [*Service*](https://kubernetes.io/docs/concepts/services-networking/service/) (serviço) agrupa um conjunto de endpoints de [*pod*](#o-que-é-um-pod) em um único recurso. Existem várias maneiras de acessar esse agrupamento, mas, por padrão, é através de um endereço IP do [*cluster*](#o-que-é-um-cluster) que os clientes conseguem acessar os *pods* nos serviços. Um cliente envia uma solicitação ao endereço IP estável e a solicitação é encaminhada a um dos *pods* no serviço. Um serviço identifica seus *pods* membro com um seletor. Para que um pod seja membro do serviço, ele precisa ter todos os rótulos especificados no seletor. Um [rótulo](https://kubernetes.io/docs/concepts/overview/working-with-objects/labels/) é um par de chave-valor arbitrário anexado a um objeto.

### Por que usar um serviço do Kubernetes?
Em um *cluster* do Kubernetes, cada pod tem um endereço IP interno. Mas, em uma implantação, os *pods* vêm e vão, e seus endereços IP mudam. Portanto, não faz sentido usar os endereços IP do *pod* diretamente. Com um serviço, você recebe um endereço IP estável válido durante a vida útil do serviço, mesmo quando os endereços IP dos *pods* membro são alterados.

Um serviço também fornece balanceamento de carga. Os clientes chamam um endereço IP único e estável, e suas solicitações são balanceadas nos *pods* que são membros do serviço.

## ClusterIP
Quando você cria um Serviço do tipo ClusterIP, o Kubernetes cria um endereço IP estável que pode ser acessado pelos nós do cluster.

Veja a seguir um exemplo de um manifesto de um serviço do tipo ClusterIP:

```yaml
apiVersion: v1
kind: Service
metadata:
  name: my-cip-service
spec:
  selector:
    app: metrics
    department: sales
  type: ClusterIP
  ports:
  - protocol: TCP
    port: 80
    targetPort: 8080
```

É possível [criar o serviço](https://cloud.google.com/kubernetes-engine/docs/how-to/exposing-apps) usando o comando `kubectl apply -f [MANIFEST_FILE]`. Depois de criar o serviço, use `kubectl get service` para ver o endereço IP estável, saída do comando:

```terminal
NAME             TYPE        CLUSTER-IP      EXTERNAL-IP   PORT(S)
my-cip-service   ClusterIP   10.11.247.213   none          80/TCP
```

Os clientes no cluster chamam o Serviço usando o endereço IP do cluster e a porta TCP especificada no campo `port` do manifesto Serviço. A solicitação é encaminhada para um dos *pods* membros na porta TCP especificada no campo `targetPort`. No exemplo anterior, um cliente chama o serviço no endereço IP `10.11.247.213` na porta TCP `80`. A solicitação é encaminhada a um dos *pods* membros na porta TCP `8080`. Cada *pod* membro precisa ter um contêiner detectando a porta TCP `8080`. Se nenhum contêiner estiver escutando a porta `8080`, os clientes verão uma mensagem como "Falha ao conectar" ou "Este site não pode ser acessado", ou seja, nesse contêiner é necessário ter uma aplicação que esteja ouvindo na porta `8080`.

## NodePort
Quando você cria um serviço do tipo `NodePort`, o Kubernetes fornece um valor `nodePort`. Em seguida, o Serviço pode ser acessado usando o endereço IP de qualquer nó junto com o valor `nodePort`.

Segue um exemplo de um manifesto para um Serviço do tipo `NodePort`:

```yaml
apiVersion: v1
kind: Service
metadata:
  name: my-np-service
spec:
  selector:
    app: products
    department: sales
  type: NodePort
  ports:
  - protocol: TCP
    port: 80
    targetPort: 8080
```

Depois de criar o Serviço, use `kubectl get service -o yaml` para visualizar sua especificação e ver o valor `nodePort`.

```yaml
spec:
  clusterIP: 10.11.254.114
  externalTrafficPolicy: Cluster
  ports:
  - nodePort: 32675
    port: 80
    protocol: TCP
    targetPort: 8080
```

Clientes externos chamam o Serviço usando o endereço IP externo de um nó junto com a porta TCP especificada por `nodePort`. A solicitação é encaminhada para um dos *pods* membro na porta TCP especificada pelo campo `targetPort`.

Por exemplo, suponha que o endereço IP externo de um dos nós do *cluster* seja `203.0.113.2`. Em seguida, no exemplo anterior, o cliente externo chama o serviço em `203.0.113.2` na porta TCP `32675`. A solicitação é encaminhada a um dos *pods* membro na porta TCP `8080`. O *pod* membro precisa ter um contêiner escutando a porta TCP `8080`.

O tipo de serviço `NodePort` é uma extensão do tipo de serviço `ClusterIP`. Portanto, os clientes internos têm duas maneiras de chamar o serviço:

- Use `clusterIP` e `port`.
- Use o endereço IP de um nó e `nodePort`.

Para algumas configurações de *cluster*, [o balanceador de carga HTTP(S) externo](https://cloud.google.com/load-balancing/docs/https) usa um Serviço do tipo `NodePort`. Para mais informações, consulte [Como configurar o balanceamento de carga HTTP(S) com a Entrada](https://cloud.google.com/kubernetes-engine/docs/tutorials/http-balancer).

Um balanceador de carga HTTP(S) externo é um servidor proxy e é fundamentalmente diferente do [balanceador de carga da rede](https://cloud.google.com/load-balancing/docs/network) descrito no serviço do tipo [LoadBalancer](#loadbalancer).

**Observação**: é possível especificar seu próprio valor **nodePort** no intervalo `30000-32767`. No entanto, é melhor omitir o campo e permitir que o Kubernetes aloque um **nodePort** para você. Isso evita colisões entre os serviços.

## LoadBalancer


## ExternalName


## Headless



**Referências**
- [Google cloud - Serviços Kubernetes](https://cloud.google.com/kubernetes-engine/docs/concepts/service)
- [Kubernetes - Services](https://kubernetes.io/docs/concepts/services-networking/service/)
- [Kubernetes - Labels](https://kubernetes.io/docs/concepts/overview/working-with-objects/labels/)

[Voltar para o sumário](#sumário)

# O que é Kind?
Kind é uma ferramenta para executar *clusters* Kubernetes locais usando "nós" de container do Docker. Foi projetado principalmente para testar o próprio Kubernetes, mas pode ser usada para desenvolvimento local ou CI.

Para instalar o *kind* siga os passos descritos [aqui](https://www.zup.com.br/blog/kind-cluster-kubernetes#:~:text=kind%20%C3%A9%20uma%20ferramenta%20para,ferramenta%20em%20seu%20site%20oficial.).

Em resumo os passos são:
```
    sudo curl -Lo ./kind https://kind.sigs.k8s.io/dl/v0.11.1/kind-linux-amd64
    sudo chmod +x ./kind
    sudo mv ./kind /usr/bin/kind
```

Outros métodos de instalação são apresentados [aqui](https://kind.sigs.k8s.io/).

**Referência:**
- [Kind](https://kind.sigs.k8s.io/);
- [Zup](https://www.zup.com.br/blog/kind-cluster-kubernetes#:~:text=kind%20%C3%A9%20uma%20ferramenta%20para,ferramenta%20em%20seu%20site%20oficial.)

[Voltar para o sumário](#sumário)

# O que é Minikube?
O Minikube é uma implementação leve do Kubernetes que cria uma VM em sua máquina local e implanta um cluster simples contendo apenas um nó. O Minikube está disponível para sistemas Linux, macOS e Windows. A linha de comando (cli) do Minikube fornece operações básicas de inicialização para trabalhar com seu cluster, incluindo iniciar, parar, status e excluir.

Para instalar o *MiniKube* siga os passos descritos [aqui](https://minikube.sigs.k8s.io/docs/start/)

Em resumo:
- Para Windows: A maneira mais simples é baixar o executável (.exe) do *Minikube* ou executar os comandos:
    ```
        New-Item -Path 'c:\' -Name 'minikube' -ItemType Directory -Force
        Invoke-WebRequest -OutFile 'c:\minikube\minikube.exe' -Uri 'https://github.com/kubernetes/minikube/releases/latest/download/minikube-windows-amd64.exe' -UseBasicParsing

        $oldPath = [Environment]::GetEnvironmentVariable('Path', [EnvironmentVariableTarget]::Machine)
        if ($oldPath.Split(';') -inotcontains 'C:\minikube'){ `
            [Environment]::SetEnvironmentVariable('Path', $('{0};C:\minikube' -f $oldPath), [EnvironmentVariableTarget]::Machine) `
        }
    ```
- Para Linux, executar o comando:
    ```
        curl -LO https://storage.googleapis.com/minikube/releases/latest/minikube-linux-amd64
        sudo install minikube-linux-amd64 /usr/local/bin/minikube
    ```
- Para MacOS, executar o comando:
    ```
        curl -LO https://storage.googleapis.com/minikube/releases/latest/minikube-darwin-amd64
        sudo install minikube-darwin-amd64 /usr/local/bin/minikube
    ```

**Referência:**
- [Minikube](https://kubernetes.io/pt-br/docs/tutorials/kubernetes-basics/create-cluster/cluster-intro/#:~:text=O%20Minikube%20%C3%A9%20uma%20implementa%C3%A7%C3%A3o,sistemas%20Linux%2C%20macOS%20e%20Windows.);
- [Minikube/Documentação](https://minikube.sigs.k8s.io/docs/start/)

[Voltar para o sumário](#sumário)

# Conceitos básicos
A seguir serão descritos alguns conceitos básicos a respeito do Kubernetes, Minikube, Kind e sobre o ambiente de serviços distribuídos em contêineres.

## O que é um Pod?
*Pod*, no Kubernetes, trata-se de um ou mais contêineres agrupados para fins de administração e gerenciamento de rede. Os *Pods* são as menores unidades implantáveis de computação que você pode criar e gerenciar no Kubernetes. Além dos *pods* serem um grupo de um ou mais contêineres que possuem armazenamento e recursos de rede compartilhados, também possuem uma especificação de como executar os contêineres. Assim como as aplicações de contêineres, um *Pod* pode conter um contêiner inicial que é executado durante a inicialização do *Pod*, sendo possível também injetar um contêiner efêmero (contêiner temporário) para *debugging*, se o *cluster* oferecer essa opção. Em resumo, um *pod* é similar a um conjunto de contêineres com *namespaces* e volumes compartilhados.

*Pods* no Kubernetes são usados de duas maneiras principais:
1. ***Pods* que executam um único contêiner**: O modelo de um contêiner por *pod* é o caso de uso mais comum no Kubernetes. Neste caso podemos pensar no *Pod* como sendo uma camada que envolve um único contêiner, assim o Kubernetes gerencia os *pods* ao em vez de gerenciar os contêineres diretamente.
2. ***Pods* que executam múltiplos contêineres que precisam trabalhar juntos**: Um *pod* pode encapsular uma aplicação composta por vários contêineres locais que compartilham os mesmos recursos. Esses contêineres locais formam uma única unidade coesa de serviço, como por exemplo um contêiner que atende dados armazenados em um volume compartilhado para o público, enquanto um outro contêiner (secundário) separado atualiza esses arquivos. O *pod*, então, agrupa esses contêineres, juntamente com os recursos de armazenamento e rede efêmera como uma única unidade.

Cada *Pod* é feito com o objetivo de rodar (executar) apenas uma única instância de uma dada aplicação. Para escalar a aplicação horizontalmente, oferecer mais recursos gerais executando mais instâncias, deve-se usar múltiplos *Pods*, um para cada instância. No Kubernetes isso é referenciado como "replicação". *Pods* replicados geralmente são criados e gerenciados como um grupo pelo recurso de carga de trabalho (*workload*) e seu controlador.

**Referências:**
- [*Pods*](#https://kubernetes.io/docs/concepts/workloads/pods/)

[Voltar para o sumário](#sumário)

## O que é um cluster?
*Cluster*, no Kubernetes, é um conjunto de nós (*nodes*) que executam aplicativos em contêineres. Os *clusters* são compostos por um nó mestre e vários nós de trabalho, sendo que estes nós podem ser computadores físicos ou máquinas virtuais. A função do nó mestre é controlar o estado do *cluster* e fornece todas as atribuições de tarefas, coordenando processos como:
- Agendamento e dimensionamento de aplicativos
- Manutenção do estado de um *cluster*
- Implementações de atualizações

Já os nós de trabalho são responsáveis por executar as tarefas atribuidas pelo nó mestre. Deve haver pelo menos um nó mestre (ou nó principal) e um nó de trabalho para que o *cluster* possa operar.

**Referências:**
- [*Cluster*](https://www.vmware.com/br/topics/glossary/content/kubernetes-cluster.html#:~:text=Um%20cluster%20de%20Kubernetes%20%C3%A9,flex%C3%ADveis%20que%20as%20m%C3%A1quinas%20virtuais.)

[Voltar para o sumário](#sumário)


# Instalações
Para usar o Kubernets é necessário instalar o kubectl. Recomenda-se sempre utilizar a versão mais atualizada do kubectl para evitar problemas.

Independente do sistema operacional, há pelo menos duas maneiras de se instalar o kubectl, baixando o arquivo binário utilizando o comando `curl` ou utlizando um gerenciador de pacotes.

## Instalação no Windows
Utilizando o [Chocolatey](https://chocolatey.org/) para realizar a instalação do kubectl. Execute os seguintes comandos na ordem:
1. `choco install kubernetes-cli`
2. Verifique se a versão instalada é a mais atual: <br> `kubectl version --client`
3. Navegue até o diretório home, normalmente `C:\Users\<user-name>`.<br>`cd ~`
4. Crie um diretório .kube: `mkdir .kube`
5. Mude para o diretório: `cd .kube`
6. Configure o kubectl para usar um *cluster* remoto do Kubernetes: `New-Item config -type file`
7. Verifique se o kubectl está devidamente configurado, verificando o estado do *cluster*: `kubectl cluster-info`. Se receber uma URL como resposta, então o kubectl está corretamente configurado para acessar o *cluster*.

Para mais informações ou outras formas de instalar o kubectl, acesse: https://kubernetes.io/docs/tasks/tools/install-kubectl-windows/ 

## Instalação no Linux
Utilizando uma distribuição Linux baseada em Debian e utilizando o gerenciador de pacotes padrão apt, siga os passos a seguir para instalar o kubectl:
1. Atualize o índice do pacote `apt` e instale os pacotes necessários para usar o repositório `apt` Kubernetes.
   ```
    sudo apt-get update
    sudo apt-get install -y ca-certificates curl
   ```
   Em casos de sistemas operacionais Debian ou distribuições baseadas em versões anteriores ao Debian 9, também será necessário instalar o `apt-transport-https`.
   ```
    sudo apt-get install -y apt-transport-https
   ```
2. Baixe a chave de assinatura pública do Google Cloud:
   ```
    sudo curl -fsSLo /etc/apt/keyrings/kubernetes-archive-keyrings.gpg https://packages.cloud.google.com/apt/doc/apt-key.gpg
   ```
3. Adicionar o Kubernetes ao repositório:
   ```
    echo "deb [signed-by=/etc/apt/keyrings/kubernetes-archive-keyring.gpg] https://apt.kubernetes.io/ kubernetes-xenial main" | sudo tee /etc/apt/sources.list.d/kubernetes.list
   ```
4. Atualize o índice do pacote com o novo repositório e instale o kubectl:
   ```
    sudo apt-get update
    sudo apt-get install -y kubectl
   ```
5. Verifique se o kubectl está devidamente configurado, verificando o estado do *cluster*: `kubectl cluster-info`. Se receber uma URL como resposta, então o kubectl está corretamente configurado para acessar o *cluster*.

Para mais informações ou outras maneiras de instalar o kubectl em distribuições Linux, acesse: https://kubernetes.io/docs/tasks/tools/install-kubectl-linux/

## Instalação no MacOS
Para instalar o kubectl em sistemas MacOS utilizando o gerenciador de pacotes [Homebrew](https://brew.sh/), siga os passos a seguir:
1. Execute o comando de instalação: `brew install kubectl` ou `brew install kubernetes-cli`.
2. Faça um teste para garantir que a versão instalada está atualizada: `kubectl version --client`
3. Verifique se o kubectl está devidamente configurado, verificando o estado do *cluster*: `kubectl cluster-info`. Se receber uma URL como resposta, então o kubectl está corretamente configurado para acessar o *cluster*.

Para mais informações ou outras maneiras de instalar o kubectl em sistemas MacOS, acesse: https://kubernetes.io/docs/tasks/tools/install-kubectl-macos/ 

[Voltar para o sumário](#sumário)

# Comandos do Kubernets e do Kind
Tabela de comandos do Kubernets

| Comando | Para que serve |
|---------|----------------|
| `kind create cluster --config=k8s/kind.yaml --name=fullcycle` | Comando usado para criar um cluster utilizando um arquivo para configuração passado na *flag* *config* com o nome definido pela *flag* *name*. |
| `kubectl cluster-info --context kind-fullcycle` | Exibe as informações do cluster com o nome (contexto) informado pela flag *context*. |
| `kubectl config get-clusters` | Comando usado para exibir uma list dos *clusters*. |
| `kubectl config get-contexts` | Comando usado para exibir uma lista dos contextos. |
| `kind get clusters` | Comando usado para retornar uma lista de *clusters* que estão ativos. |
| `kind delete clusters <cluster-name>` | Comando usado para deletar *clusters* pelo nome. |
| `kubectl apply -f <filepath>` | Comando usado para executar determinadas especificações descritas em um arquivo. |
| `kubectl get deployments` | Comando usado para retornar uma lista dos *deployments* sendo executados. |
| `kubectl get replicasets` | Comando usado para retornar uma lista de replicas. |
| `kubectl get services` | Comando usado para retornar uma lista de serviços. |
| `kubectl get pod` | Comando usado para retornar uma lista dos *pods* sendo executados. |
| `kubectl get pods` | Comando usado para retornar uma lista dos *pods* sendo executados. |
| `kubectl rollout history <object-type> <object-name>` | Verifica o histórico do objeto Kubernetes especificado, incluindo revisões, pelo nome. |
| `kubectl rollout history deployment goserver` | Verifica o histórico dos *Deployments* incluindo revisões. |
| `kubectl rollout undo deployment <nome-do-deploy>` | Retorna para a última versão do *Deployment*. |
| `kubectl rollout undo deployment <deploy-name> --to-revision=<revision-number>` | Retorna para uma revisão específica. |
| `kubectl rollout status -w <deployment>` | Monitora o status de atualização da implantação (*deployment*) especificada até a conclusão. |
| `kubectl rollout restart <deployment>` | Reinicializa a implantação (*deployment*) especificada. |
| `kubectl describe pod <pod-name>` | Comando usado para descrever um *Pod*. Esse comando exibe as informações do *Pod* especificado. |
| `kubectl port-forward pod/<pod-name> <host-port>:<pod-port>` | Comando usado para definir a porta que será usada pelo *host* e pelo *pod* (mapeamento/redirecionamento de portas). |
| `kubectl port-forward svc/<service-name> <host-port>:<service-port>`| Comando usado para definir a porta que será usada pelo *host* e pelo serviço (*service*) (mapeamento/redirecionamento de portas). |
| `kubectl proxy --port=8080` | Inicia um servidor proxy para o servidor API do Kubernete na porta especificada. |
| `kubectl delete replicaset <replicaset-name>` | Deleta um **ReplicaSet** pelo nome. |

**Para saber mais**: 
- [kubectl Cheat Sheet](https://kubernetes.io/docs/reference/kubectl/cheatsheet/)
- [Use an HTTP Proxy to Access the Kubernetes API](https://kubernetes.io/docs/tasks/extend-kubernetes/http-proxy-access-api/)

[Voltar para o sumário](#sumário)

# Dicas


[Voltar para o sumário](#sumário)

# Para lembrar
- Para criar um pod ou qualquer objeto Kubernetes utilizamos os arquivos .yaml (ou .yml) para passar as especificações e depois executar o comando `kubectl apply -f <filepath>` para efetivamente criar o objeto Kubernetes.
- *ReplicaSet* é um objeto Kubernetes que ajuda o gerenciamento dos *Pods* e de suas replicas. A vantagem é que caso um *Pod* caia, o *ReplicaSet* irá construir o *Pod* novamente.
- As *labels* (propriedade definida no arquivo .yml do objeto Kubernetes) são importantes para facilitar as buscas pelo objeto Kubernetes.
  - Problema do *ReplicaSet* é quando atualizamos a imagem na qual ele se basea para criar os contêineres dos *pods*, pois o *ReplicaSet* não cria atomaticamente novos *pods* com a nova imagem fornecida, é necessário excluir cada um dos *pods* do *ReplicaSet*.
  - Para solucionar/contornar o problema do *ReplicaSet* precisamos usar outro objeto do Kubernetes, o *Deployment*.
- O *selector*, uma propriedade definida dentro da propriedade *spec* do objeto Kubernetes, é um seletor de *labels* que consegue selecionar apenas as *labels* com determinadas especificações.
  Exemplo:
    ``` k8s
    spec:
        selector:
            matchLabels:
                app: goserver
    ```
É graças à propriedade *seletor* que conseguimos diferenciar um serviço do outro, pois utilizamos o *seletor* como uma espécie de filtro.
- Ordem de grandeza dos objetos Kubernetes: *Deployments* > *ReplicaSets* > *Pods*
- Quando os *Deployments* estão realizando a atualização dos *ReplicaSets* e dos *Pods*, há um tempo de zero *downtime*, ou seja, sua aplicação não ficará fora do ar durante esse período de atualização, pois ela é feita de maneira progressiva.
  - O *ReplicaSet* não será deletado, será criado um novo *ReplicaSet* e o antigo ficará sem nenhum *Pod*, ou seja, ficará vazio.
- Um rótulo é um par de chave-valor arbitrário anexado a um objeto.

[Voltar para o sumário](#sumário)