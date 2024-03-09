# Kubernets
Projeto criado com o objetivo de aprender e estudar o Kubernets.

## Sumário
1. [O que é Kubernets?](#o-que-é-kubernets)
2. [Tipos de serviços no Kubernetes](#tipos-de-serviços-no-kubernetes)
   1. [O que é um serviço no Kubernetes](#o-que-é-um-serviço-no-kubernetes)
   2. [ClusterIP](#clusterip)
   3. [NodePort](#nodeport)
   4. [LoadBalancer](#loadbalancer)
   5. [ExternalName](#externalname)
   6. [Headless](#headless)
3. [O que é Kind?](#o-que-é-kind)
4. [O que é Minikube?](#o-que-é-minikube)
5. [Conceitos básicos](#conceitos-básicos)
   1. [O que é um pod?](#o-que-é-um-pod)
   2. [O que é um cluster](#o-que-é-um-cluster)
6. [Configurações de objetos](#configurações-de-objetos)
   1. [Variáveis de ambiente](#variáveis-de-ambiente)
      1. [ConfigMap](#configmap)
7. [Instalações](#instalações)
   1. [Windows](#instalação-no-windows)
   2. [Linux](#instalação-no-linux)
   3. [MacOS](#instalação-no-macos)
8.  [Comandos do Kubernets e do kind](#comandos-do-kubernets-e-do-kind)
9. [Comandos úteis do Linux](#comandos-úteis-do-linux)
10.  [Configurações de objetos](#configurações-de-objetos)
    1.  [Variáveis de ambiente](#variáveis-de-ambiente)
        1.  [ConfigMap](#configmap)
11. [Secrets](#secrets)
12. [Health check](#health-check)
13. [Configurando Probes](#configurando-probes)
14. [Healthz, livez e readyz](#healthz-livez-e-readyz)
15. [HPA](#hpa)
16. [Dicas](#dicas)
17. [Para lembrar](#para-lembrar)

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

[Voltar para o sumário](#sumário)

## O que é um serviço no Kubernetes?
Um [*Service*](https://kubernetes.io/docs/concepts/services-networking/service/) (serviço) agrupa um conjunto de *endpoints* de [*pod*](#o-que-é-um-pod) em um único recurso. Existem várias maneiras de acessar esse agrupamento, mas, por padrão, é através de um endereço IP do [*cluster*](#o-que-é-um-cluster) que os clientes conseguem acessar os *pods* nos serviços. Um cliente envia uma solicitação ao endereço IP estável e a solicitação é encaminhada a um dos *pods* no serviço.

Um serviço identifica seus *pods* membro com um seletor. Para que um pod seja membro do serviço, ele precisa ter todos os rótulos especificados no seletor.

Um [rótulo](https://kubernetes.io/docs/concepts/overview/working-with-objects/labels/) é um par de chave-valor arbitrário anexado a um objeto.

[Voltar para o sumário](#sumário)

### Por que usar um serviço do Kubernetes?
Em um *cluster* do Kubernetes, cada pod tem um endereço IP interno. Mas, em uma implantação, os *pods* vêm e vão, e seus endereços IP mudam. Portanto, não faz sentido usar os endereços IP do *pod* diretamente. Com um serviço, você recebe um endereço IP estável válido durante a vida útil do serviço, mesmo quando os endereços IP dos *pods* membro são alterados.

Um serviço também fornece balanceamento de carga. Os clientes chamam um endereço IP único e estável, e suas solicitações são balanceadas nos *pods* que são membros do serviço.

[Voltar para o sumário](#sumário)

## ClusterIP
Quando você cria um Serviço do tipo ClusterIP, o Kubernetes cria um endereço IP estável (**interno**) que pode ser acessado pelos nós do cluster.

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

Os clientes no cluster chamam o Serviço usando o endereço IP do cluster e a porta TCP especificada no campo `port` do manifesto Serviço. A solicitação é encaminhada para um dos *pods* membros na porta TCP especificada no campo `targetPort`. No exemplo anterior, um cliente chama o serviço no endereço IP `10.11.247.213` na porta TCP `80`, ou seja, `10.11.247.213:80`. A solicitação é encaminhada a um dos *pods* membros na porta TCP `8080`. Cada *pod* membro precisa ter um contêiner detectando a porta TCP `8080`. Se nenhum contêiner estiver escutando a porta `8080`, os clientes verão uma mensagem como "Falha ao conectar" ou "Este site não pode ser acessado", ou seja, nesse contêiner é necessário ter uma aplicação que esteja ouvindo na porta `8080`.

[Voltar para o sumário](#sumário)

## NodePort
Quando você cria um serviço do tipo `NodePort`, o Kubernetes fornece um valor `nodePort`. Em seguida, o Serviço pode ser acessado usando o endereço IP de qualquer nó junto com o valor `nodePort`. Ou seja, este tipo de serviço expõe a porta dos *nodes* (nós) para que possam ser acessados, logo se o *browser* acessar o serviço informando a porta definida na propriedade `nodePort`, ele será redirecionado para o serviço na porta especificada na propriedade `port` (ou seja, será a própria porta do serviço) que, por sua vez, redirecionará para o contêiner (que está dentro dos nodes) na porta especificada em `targetPort` (que é a própria porta do contêiner utilizada pela a aplicação).

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

Clientes externos chamam o Serviço usando o endereço IP externo de um nó (*node*) junto com a porta TCP especificada por `nodePort`. A solicitação é encaminhada para um dos *pods* membro na porta TCP especificada pelo campo `targetPort`.

Por exemplo, suponha que o endereço IP externo de um dos nós do *cluster* seja `203.0.113.2`. Em seguida, no exemplo anterior, o cliente externo chama o serviço em `203.0.113.2` na porta TCP `32675`, ou seja `203.0.113.2:32675`. A solicitação é encaminhada a um dos *pods* membro na porta TCP `8080`. O *pod* membro precisa ter um contêiner escutando a porta TCP `8080`.

O tipo de serviço `NodePort` é uma extensão do tipo de serviço `ClusterIP`. Portanto, os clientes internos têm duas maneiras de chamar o serviço:

- Use `clusterIP` e `port`. Exemplo: `203.0.113.2:80`
- Use o endereço IP de um nó e `nodePort`. Exemplo: `203.0.113.2:32675`

Para algumas configurações de *cluster*, [o balanceador de carga HTTP(S) externo](https://cloud.google.com/load-balancing/docs/https) usa um Serviço do tipo `NodePort`. Para mais informações, consulte [Como configurar o balanceamento de carga HTTP(S) com a Entrada](https://cloud.google.com/kubernetes-engine/docs/tutorials/http-balancer).

Um balanceador de carga HTTP(S) externo é um servidor proxy e é fundamentalmente diferente do [balanceador de carga da rede](https://cloud.google.com/load-balancing/docs/network) descrito no serviço do tipo [LoadBalancer](#loadbalancer).

**Observação**: é possível especificar seu próprio valor **nodePort** no intervalo `30000-32767`. No entanto, é melhor omitir o campo e permitir que o Kubernetes aloque um **nodePort** para você. Isso evita colisões entre os serviços.

[Voltar para o sumário](#sumário)

## LoadBalancer
O tipo de serviço LoadBalancer tem o objetivo de fornecer um IP externo para que um servidor, que contenha os serviços e *nodes* Kubernetes, possa ser acessado. Este tipo de serviço é normalmente utilizado em *clusters* gerenciados ou *clusters* Kubernetes que estão conectados diretamente a um provedor de nuvem (AWS, Asure, Google Cloud, Digital Ocean etc.). Nos provedores de nuvem que suportam os *load balancers* (balanceadores de carga) há um campo `type` que pode ser definido como `LoadBalancer` para que assim o serviço na nuvem possa receber o balanceador de carga.

Segue um exemplo de um *LoadBalancer*:

```yaml
apiVersion: v1
kind: Service
metadata:
  name: my-service
spec:
  selector:
    app.kubernetes.io/name: MyApp
  ports:
    - protocol: TCP
      port: 80
      targetPort: 9376
  clusterIP: 10.0.171.239
  type: LoadBalancer
status:
  loadBalancer:
    ingress:
    - ip: 192.0.2.127
```

Neste exemplo, o tráfico de dados vindo do load balancer externo é direcionado para os *Pods* do *backend*. O provedor de nuvem decidirá como irá balancear as cargas.

Alguns provedores de nuvem permitem que você especifique o valor do campo *loadBalancerIP*. Nestes casos, o serviço *loadBalancer* é criado com o valor especificado em *loadBalancerIP*. Se este campo, *loadBalancerIP*, não é especificado, então, o serviço *loadBalancer* é definido com um IP temporário (efêmero). Se você especificar o campo *loadBalancerIP*, mas seu provedor de nuvem não suportar esta funcionalidade, então, o campo *loadBalancerIP* será ignorado.

Para implementar um serviço do tipo *LoadBalancer*, o Kubernetes normalmente começa fazendo as alterações que são equivalentes a solicitação de um serviço do tipo *NodePort*. O componente `cloud-controller-manager` configura o balanceador de carga externo para encaminhar o tráfego para a porta do *node* (nó) atribuída.

Vale lembrar que este tipo de serviço também possui IP interno (*ClusterIP*) e também define as portas dos nodes (*NodePort*), logo, este serviço incluí caracteristicas dos outros serviços do tipo *ClusterIP* e *NodePort*. O IP externo só será definido se houver um provedor de nuvem especificado, caso contrário ficará com *status* pendente (*pending*).

[Voltar para o sumário](#sumário)

## ExternalName
Um serviço do tipo `ExternalName` fornece um alias (apelido) interno para um nome DNS externo. Clientes internos fazem solicitações usando o nome definido para o DNS interno e as solicitações são redirecionadas para o nome externo.

Aqui está um manifesto para um Serviço do tipo `ExternalName`:

```yaml
apiVersion: v1
kind: Service
metadata:
  name: my-xn-service
spec:
  type: ExternalName
  externalName: example.com
```

Quando você cria um serviço, o Kubernetes cria um nome DNS que os clientes internos podem usar para chamar o serviço. No exemplo anterior, o nome DNS é `my-xn-service.default.svc.cluster.local`. Quando um cliente interno faz uma solicitação para esse DNS, ele é redirecionado para `example.com`.

O tipo de serviço `ExternalName` é fundamentalmente diferente dos outros tipos de serviço. Na verdade, um Serviço do tipo `ExternalName` não se ajusta à definição de Serviço fornecido no início deste tópico. Um serviço do tipo `ExternalName` **não está associado a um conjunto de *pods*** e **não tem um endereço IP estável**. Em vez disso, um serviço do tipo `ExternalName` **é um mapeamento de um nome DNS interno para um nome DNS externo**.

[Voltar para o sumário](#sumário)

## Headless
Às vezes, você não precisa de balanceamento de carga e nem de um endereço IP de serviço. Nesse caso, você pode criar o que chamamos de Serviços *headless*, especificando explicitamente `None` para o IP do cluster (`.spec.clusterIP`).

Você pode usar um serviço *headless* para interagir com outros mecanismos de descoberta de serviço, sem estar vinculado à implementação do Kubernetes.

Para serviços *headless*, um IP de cluster não é alocado, o kube-proxy não lida com esses serviços e não há balanceamento de carga ou proxy feito pela plataforma para eles. Como o DNS é configurado automaticamente, depende se o Serviço tem seletores definidos:

### Com seletores
Para serviços *headless* que definem seletores, o plano de controle do Kubernetes cria objetos [`EndpointSlice`](https://kubernetes.io/docs/concepts/services-networking/service/#endpointslices) na API do Kubernetes e modifica a configuração do DNS para retornar registros A ou AAAA (endereços IPv4 ou IPv6) que apontam diretamente para os *pods* que suportam o serviço.

### Sem seletores
Para serviços *headless* que não definem seletores, o plano de controle não cria objetos `EndpointSlice`. No entanto, o sistema DNS procura e configura:

- Registros DNS `CNAME` para o tipo: `ExternalName` Services.
- Registros DNS A/AAAA para todos os endereços IP dos *endpoints* prontos do serviço, para todos os tipos de serviço diferentes de `ExternalName`.
  - Para terminais IPv4, o sistema DNS cria registros A.
  - Para terminais IPv6, o sistema DNS cria registros AAAA.

[Voltar para o sumário](#sumário)

**Referências**
- [Google cloud - Serviços Kubernetes](https://cloud.google.com/kubernetes-engine/docs/concepts/service)
- [Kubernetes - Services](https://kubernetes.io/docs/concepts/services-networking/service/)
- [Kubernetes - Labels](https://kubernetes.io/docs/concepts/overview/working-with-objects/labels/)
- [Kubernetes - LoadBalancer](https://kubernetes.io/docs/concepts/services-networking/service/#headless-services)
- [Conceitos do serviço LoadBalancer](https://cloud.google.com/kubernetes-engine/docs/concepts/service-load-balancer?hl=pt-br)
- [Kubernetes - Headless Services](https://kubernetes.io/docs/concepts/services-networking/service/#headless-services)

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

[Voltar para o sumário](#sumário)

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

[Voltar para o sumário](#sumário)

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

[Voltar para o sumário](#sumário)

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

[Voltar para o sumário](#sumário)

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
| `kubectl delete svc <service-name>` | Comando usado para deletar um serviço pelo nome. |
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
| `kubectl proxy --port=<port-number>` | Inicia um servidor proxy para o servidor API do Kubernetes na porta especificada. |
| `kubectl delete replicaset <replicaset-name>` | Deleta um **ReplicaSet** pelo nome. |
| `kubectl logs <nome-do-pod>` | Exibe os logs do pod especificado. |

**Para saber mais**: 
- [kubectl Cheat Sheet](https://kubernetes.io/docs/reference/kubectl/cheatsheet/)
- [Kubernetes Cheat Sheet](https://kubernetes.io/pt-br/docs/reference/kubectl/cheatsheet/)
- [Use an HTTP Proxy to Access the Kubernetes API](https://kubernetes.io/docs/tasks/extend-kubernetes/http-proxy-access-api/)

[Voltar para o sumário](#sumário)

# Comandos úteis do Linux
| Descrição | Comando |
|-----------|---------|
| Monitora a saída de um comando em um dado intervalo de tempo | watch -n1 <comando-a-ser-monitorado> |

[Voltar para o sumário](#sumário)

# Configurações de objetos
Seção dedicada às configurações dos objetos do Kubernetes e seus recursos.

## Variáveis de ambiente
Para declara variáveis de ambiente no Kubernetes basta usar o parâmetro `env` e definir dentro desse parâmetro o valor da variável dentro do arquivo de especificação do componente kubernetes (deployment).
Exemplo:
```yaml
...
spec:
  containers:
    - name: goserver
      image: "imagem-docker/servico:tag-versao"
    env:
      - name: NAME
        value: "Teste"
      - name: AGE
        value: "20"
```
Após adicionado as informações sobre as variáveis de ambiente, executar os comandos:
1. `kubectl apply -f k8s/deployment.yaml`
2. `kubectl port-forward svc/goserver-service 9000:80`
3. (Para este exemplo) Abrir o *browser* (navegador) e acessar `localhost:9000`

**Obs.:** O serviço ou a aplicação em questão devem consumir as informações fornecidas pelas variáveis de ambiente.

### ConfigMap
Trata-se de um arquivo onde podemos fornecer informações de variáveis de ambiente para que possamos enviar o *hard coded* das variáveis de ambiente no código.

**Exemplo:**
Arquivo configMap: [*configMap-env.yaml*](./k8s/configMap-env.yaml)
Modificações necessárias no arquivo do deployment:
```yaml
...
spec:
  containers:
    - name: goserver
      image: "imagem-docker/servico:tag-versao"
      env:
        - name: NAME
          valueFrom:
            configMapKeyRef:
              name: goserver-env
              key: NAME

        - name: AGE
          valueFrom:
            configMapKeyRef:
              name: goserver-env
              key: AGE

```

Obs.: ***IMPORTANTE:***Mudar o configMap não significa que os novos valores das variáveis serão reflitas automaticamente na aplicação, é necessário criar um novo deployment.

Após a criação do configMap e as alterações no deployment.yaml, executar os comandos, para este exemplo:
1. `kubectl apply -f k8s/configmap-env.yaml`
2. `kubectl apply -f k8s/deployment.yaml`
3. `kubectl port-forward svc/goserver-service 9000:80`

Uma outra forma de se utilizar as variáveis de ambiente com o configMap é ilustrada a seguir. Ideal para casos onde existem várias variáveis de ambiente para serem utilizadas.
Exemplo:
```yaml
...
spec:
  container:
    - name: <nome-do-container>
      image: "imagem-docker/servico:tag-versao"
      envFrom:
        - configMapRef:
          name: <nome-do-configMap>
```

Da mesma forma que antes, os comandos do `kubectl apply -f k8s/deployment.yaml` (nome do arquivo com as especificações mencionadas no exemplo acima) e `kubectl port-forward svc/goserver-service 9000:80` devem ser executados.

Podemos ainda utilizar vários arquivos de configMap, assim como podemos injetar um configMap no container por meio dos *volumes*. Para isso, no arquivo de *deployment* é necessário declarar o volume e informar o parâmetro `volumeMounts`, responsável por informar ao Kubernetes qual volume queremos montar. Exemplo do arquivo de deployment:

```yaml
...
spec:
  container:
    - name: <nome-do-container>
      image: ...
      
      volumeMounts:
        - mountPath: "<caminho-do-volume-no-container>"
          name: <nome-do-volume>
          readOnly: true
  volumes:
    - name: <nome-do-volume>
      configMap:
        name: <nome-do-configMap>
        items:
          - key: <nome-da-chave>
            path: "<nome-do-arquivo>"
```

**Algumas explicações.**
- O campo `mountPath` é o caminho absoluto dentro do container onde será montado o volume.
- o campo `name`, do `configMap`, deve ser o nome do arquivo configMap criado sem a extensão do arquivo.
- O campo `key` em `items` deve ser o nome do campo criado dentro de `data`, no arquivo configMap.
- O campo `path` dentro de `items` refere-se ao nome do arquivo mais a sua extensão, que estará disponível, depois criado, dentro do `volume`. Ou seja, irá ler o configMap definido, acessando o parâmetro definido na `key` e o valor ser colocado no arquivo definido no parâmetro `path` de `items` para ser acessado pela aplicação dentro do contairner.

[Voltar para o sumário](#sumário)

### Secrets
*Secrets* é um outro objeto Kubernets que é utilizado para guardar dados sensíveis. Exemplo:
```yaml
apiVersion: v1
kind: Secret
metadata:
  name: <nome-do-secret>
type: <tipo-do-secret>
data:
  USER: "<valor-em-base64>"
  PASSWORD: "<valor-em-base64>"
```

No Kubernetes, Secrets são objetos que são usados para armazenar informações sensíveis, como senhas, chaves de API ou certificados TLS. Eles são destinados a garantir a segurança dessas informações, uma vez que podem ser criptografados quando em repouso e só são acessíveis pelos processos autorizados.

Os Secrets são armazenados no cluster Kubernetes e podem ser usados por aplicativos dentro do cluster. Eles são usados principalmente para passar informações confidenciais para os containers em tempo de execução, sem expor essas informações diretamente nos arquivos de configuração.

**Os Secrets no Kubernetes podem ser de dois tipos:**

1. **Secrets genéricos:** que consistem em pares de chave-valor, onde a chave é o nome do segredo e o valor é o dado confidencial. Eles são usados para armazenar informações simples, como senhas de banco de dados ou tokens de API.

**Exemplo de Secrets genéricos no Kubernetes:**
```yaml
apiVersion: v1
kind: Secret
metadata:
  name: my-secret
stringData:
  username: myUser
  password: myPassword
```

2. Secrets baseados em arquivo: que contêm arquivos, como chaves privadas ou certificados TLS. Eles são usados para fornecer informações confidenciais em formato de arquivo para aplicativos.

**Exemplo de Secrets baseados em arquivo no Kubernetes:**

```yaml
apiVersion: v1
kind: Secret
metadata:
  name: tls-secret
data:
  tls.crt: <base64-encoded certificate file>
  tls.key: <base64-encoded private key file>
```

Os Secrets podem ser referenciados em tempo de execução pelos pods ou deployments que precisam acessar as informações confidenciais. Essas informações podem ser montadas em um volume ou injetadas como variáveis de ambiente no container, garantindo que apenas os recursos autorizados tenham acesso aos dados sensíveis.

Por exemplo, um pod que precisa de acesso a um banco de dados pode referenciar um Secret que contém as credenciais do banco de dados, montando o Secret como um volume e acessando o arquivo de senha diretamente. Dessa forma, as informações confidenciais não são expostas diretamente no arquivo de configuração do pod.

No Kubernetes, os Secrets são utilizados para armazenar informações sensíveis, como senhas, tokens, chaves de API, certificados TLS, entre outros. Existem diferentes **tipos de Secrets** disponíveis no Kubernetes:

**1. secrets Opaque:**
- Este tipo de Secret armazena dados arbitrários como pares de chave-valor, onde os valores são representados como strings base64-encoded. Os Secrets Opaque são úteis quando se deseja armazenar informações arbitrárias que não precisam ser interpretadas pelo Kubernetes.

**2. secrets Docker-registry:**
- Este tipo de Secret é utilizado para armazenar credenciais de autenticação de registro Docker. Ele contém informações como o servidor do registro, nome do usuário, senha e e-mail associado. Essas informações são usadas pelo Kubernetes para autenticar um pod em um registro Docker privado.

**3. secrets TLS:**
- Os Secrets TLS são usados para armazenar certificados SSL/TLS. Ele inclui as chaves pública e privada, bem como qualquer cadeia de certificados adicional necessária para o certificado. Esses Secrets podem ser usados para configurar comunicações seguras entre componentes do Kubernetes ou para disponibilizar certificados para aplicativos em execução nos pods.

**4. secrets Service Account:**
- Quando um pod precisa acessar a API do Kubernetes, o Secrets Service Account é usado para fornecer as credenciais necessárias. Esse Secrets é criado automaticamente quando um Service Account é criado e contém um token de acesso que pode ser usado pelo pod para autenticar-se na API.

**5. secrets External:**
- Os Secrets External são usados quando as informações delicadas ou confidenciais não são armazenadas diretamente no cluster Kubernetes. Em vez disso, um objeto Secret é criado que faz referência ao local externo, onde as informações são armazenadas com segurança. O Kubernetes é capaz de buscar esses dados externos sempre que necessário, utilizando autenticação e autorização adequada.

É importante ressaltar que os Secrets são armazenados no cluster Kubernetes de forma criptografada e só podem ser acessados pelos pods e usuários autorizados. Eles são uma maneira segura de gerenciar e fornecer informações sensíveis aos aplicativos que estão em execução no Kubernetes.

#### Para saber mais
Para saber mais sobre ***Secrets*** no Kubernetes leia a documentação sobre [Secrets](https://kubernetes.io/docs/concepts/configuration/secret/).

# Health check
*Health check* é uma verificação de saúde que garante que a aplicação esteja funcionando corretamente.

O Kubernetes fornece vários tipos de verificações de saúde para garantir que suas aplicações estão funcionando corretamente:

## Liveness Probes
O Kubernetes usa *liveness probes* para saber quando reiniciar um contêiner. Por exemplo, as *liveness probes* podem detectar um *deadlock*, onde uma aplicação está em execução, mas incapaz de progredir. Reiniciar um contêiner nesse estado pode ajudar a tornar a aplicação mais disponível, apesar dos *bugs*.

## Readiness Probes
O Kubernetes usa *readiness probes* para saber quando um contêiner está pronto para começar a aceitar tráfego. Um Pod é considerado pronto quando todos os seus contêineres estão prontos. Um uso desse sinal é controlar quais Pods são usados como backends para Services. Quando um Pod não está pronto, ele é removido dos balanceadores de carga do Service.

## Startup Probes
O Kubernetes usa *startup probes* para saber quando uma aplicação de contêiner foi iniciada. Quando a verificação estiver configurada, as verificações do *liveness* e do *readiness* não irão começar até que o *startup probe* tenha sucesso, garantindo que essas verificações não interfiram na inicialização da aplicação.

Cada tipo de verificação de saúde expõe um endpoint HTTP e pode ser verificado individualmente. As verificações de saúde devem ser configuradas com cuidado para garantir que elas realmente indiquem falhas irreparáveis na aplicação, por exemplo, um *deadlock*. A implementação incorreta das sondas de *liveness* pode levar a falhas em cascata.

**FONTE**: [Configure Liveness, Readiness and Startup Probes](https://kubernetes.io/docs/tasks/configure-pod-container/configure-liveness-readiness-startup-probes/)

[Voltar para o sumário](#sumário)

## Configurando Probes
No Kubernetes quando vamos definir um Probe, como, por exemplo, o *livenessProbe*, temos que informar alguns campos, são eles:
- **initialDelaySeconds:** especifica o tempo, em segundos, para que o *Probe* (*liveness*, *readiness* e *starup*) deve espere para começar a verificação. Se o *startup probe* estiver definido, o tempo de espera para o *liveness* e o *readiness probe* iniciarem a verificação só irá começar quando o starup probe tiver sido bem-sucedido. E se o valor do *periodSeconds* for maior do que o valor no *initialDelaySeconds*, então o *initialDelaySeconds* será ignorado. Por padrão o valor deste campo é 0.
- **periodSeconds:** especifica o intervalo de tempo, em segundos, enter as verificações do *livenessProbe*, sendo o valor padrão de 30 segundos. Ou seja, de quanto em quanto tempo a verificação do *livenessProve* será realizada.
- **failureThreshold:** especifica o número máximo de falhas consecutivas permitas antes que o Kubernetes reinicie o pod, sendo 3 o valor padrão.
- **successThreshold:** especifica o número mínimo de sucessos consecutivos necessários para que o *livenessProbe* seja considerado bem-sucedido, onde o valor padrão é 1.
- **timeoutSeconds:** especifica

**FONTE**: [Configure Probes](https://kubernetes.io/docs/tasks/configure-pod-container/configure-liveness-readiness-startup-probes/)

[Voltar para o sumário](#sumário)

## Healthz, Livez e Readyz
`/healthz`, `/livez` e `/readyz` são endpoints de verificação de saúde usados em sistemas de software, como serviços baseados em microserviços, para avaliar o estado de um serviço. Eles são especialmente úteis em ambientes de orquestração, como Kubernetes, onde a verificação de saúde é crítica para o dimensionamento automático e a alta disponibilidade. Cada um desses endpoints tem uma finalidade específica:

1. **/healthz**: Este endpoint é usado para verificar a saúde geral do serviço. Ele deve retornar uma resposta bem-sucedida (como HTTP 200 OK) quando o serviço estiver operacional. Caso contrário, ele deve retornar um erro (como HTTP 500 Internal Server Error). O /healthz é usado para verificar se o serviço está "vivo" e funcionando em um nível básico.
   
2. **/livez**: Este endpoint verifica se o serviço está "vivo" e funcionando, mas pode ser mais abrangente do que o /healthz. Ele pode realizar verificações adicionais, como conexão com bancos de dados ou serviços externos. É usado para avaliar a "vivacidade" do serviço em um nível mais profundo.
   
3. **/readyz**: Este endpoint é usado para verificar se o serviço está "pronto" para receber tráfego. Ele pode realizar verificações específicas para determinar se o serviço está em um estado de leitura para atender às solicitações. Isso é particularmente útil durante o processo de inicialização de um serviço, permitindo que o sistema de orquestração aguarde até que o serviço esteja totalmente pronto.

[Voltar para o sumário](#sumário)

# HPA
O HPA é uma funcionalidade do Kubernetes que permite o dimensionamento automático de recursos de carga de trabalho, como **Deployments** ou **StatefulSets**, para atender à demanda. Isso é feito através do ajuste do número de **Pods** (a menor e mais básica unidade de computação implantável em Kubernetes) com base em métricas observadas, como o uso de CPU ou memória.

O HPA funciona da seguinte maneira:
1. O HPA observa a métrica (ou métricas) especificada.
2. Se a métrica observada exceder o limite definido, o HPA aumentará o número de Pods.
3. Se a métrica observada estiver abaixo do limite definido, o HPA diminuirá o número de Pods.

Isso é conhecido como **dimensionamento horizontal**, que é a resposta ao aumento da carga através do deployment de mais Pods. Isso é diferente do **dimensionamento vertical**, que para o Kubernetes significaria atribuir mais recursos (por exemplo: memória ou CPU) aos Pods que já estão em execução para a carga de trabalho.

O HPA é uma ferramenta poderosa para manter as aplicações resilientes e disponíveis, mesmo durante picos de tráfego inesperados. Ele ajuda a otimizar o uso de recursos, garantindo que você tenha capacidade suficiente para atender à demanda sem pagar por recursos não utilizados.

**FONTES:**
- [Horizontal Pod Autoscaling | Kubernetes](https://kubernetes.io/docs/tasks/run-application/horizontal-pod-autoscale/)
- [HorizontalPodAutoscaler Walkthrough | Kubernetes](https://kubernetes.io/docs/tasks/run-application/horizontal-pod-autoscale-walkthrough/)

[Voltar para o sumário](#sumário)

# Dicas
As vezes podem ocorrer problemas durante a execução do Kubernetes, seja de um serviço, pod, deployments, etc. Para verificar os logs de erros e/ou tentar realizar o processo de *debug* existem alguns comandos mais usados para auxiliar nesta tarefa. Os comandos mais usados para se obter informações de pods são:
- `kubectl logs <nome-do-pod>`
- `kubectl describe <nome-do-pod>`

[Voltar para o sumário](#sumário)


# HPA - Horizontal POD Autoscaler
HPA (Horizontal POD Autoscale) é um controlador que escala automaticamente o número de Pods em um Deployment, Replica Set ou StatefulSet com base em uma métrica (como CPU, memória, etc.) que são coletadas em intervalos regulares.

O HPA usa informações do Metrics Server para detectar o aumento no uso de recursos e responde escalando a carga de trabalho. Isso é especialmente útil nas arquiteturas de microsserviços e dá ao cluster Kubernetes a capacidade de escalar seu deployment com base em métricas como a utilização da CPU.

Porém, é importante notar que o _autoscaling_ funciona melhor para aplicativos sem estado ou stateless, especialmente aqueles capazes de ter várias instâncias da aplicação em execução e aceitando tráfego em paralelo.

**FONTES:**
- [Como Escalar Automaticamente suas Cargas de Trabalho no Kubernetes da DigitalOcean](https://www.digitalocean.com/community/tutorials/como-escalar-automaticamente-suas-cargas-de-trabalho-no-kubernetes-da-digitalocean-pt)
- [https://www.azurebrasil.cloud/kubernetes-diminuindo-custos-na-nuvem-autoscaler-hpa/](https://www.azurebrasil.cloud/kubernetes-diminuindo-custos-na-nuvem-autoscaler-hpa/)

[Voltar para o sumário](#sumário)

# Metrics Server
Metrics Server nada mais é do que um componente do Kubernetes que coleta métricas, como o uso de CPU e memória, dos pods e nós do cluster e as expõe no servidor de API do Kubernetes por meio da API de Métricas. Essas métricas são usadas por outros componentes do Kubernetes para fins de escalonamento automático e ajuste de recursos.

## Instalação
Normalmente quando estamos trabalhando com o Kubernetes nas nuvens ou Kubernetes gerenciado (GCP, GKE, EKS, AKS)o metrics-server já vem instalado por padrão, o que não é o caso para quando estamos trabalhando no ***kind***. Além disso, o metrics-server exige uma conexão segura em todos os clusters, exigindo o TLS. Em **ambiente de desenvolvimento**, é possível ignorar o uso do TLS. A seguir o passo-a-passo para instalar o metrics-server no kind em ambiente de desenvolvimento:
1. Execute o seguinte comando dentro de uma pasta específica para o Kubernetes (e.g. **k8s/**). Esse comando irá fazer o download do arquivo components.yaml
`wget https://github.com/kubernetes-sigs/metrics-server/releases/download/v0.7.0/components.yaml`
2. (Opcional) Renomeie o arquivo para "metrics-server.yaml"
3. Encontre o trecho `kind: Deployment`
4. Vá até
```yaml
spec:
  containers:
  - args:
    - --cert-dir=/tmp
    - --secure-port=4443
    - --kubelet-preferred-address-types=InternalIP,ExternalIP,Hostname
    - --kubelet-use-node-status-port
    - --metric-resolution=15s
```
5. Inclua `--kubelet-insecure-tls` logo abaixo de `--kubelet-use-node-status-port`. <br>**Resultado:**
```yaml
spec:
  containers:
  - args:
    - --cert-dir=/tmp
    - --secure-port=4443
    - --kubelet-preferred-address-types=InternalIP,ExternalIP,Hostname
    - --kubelet-use-node-status-port
    - --kubelet-insecure-tls
    - --metric-resolution=15s
```
6. Execute `kubectl apply -f metrics-server.yaml`
7. Verifique se o `metrics-server` está funcionando com o comando `kubectl get apiservices`. Em seguida encontre o service `kube-system/metrics-server`, deve estar como disponível (i.e. AVAILABLE = True).

[Voltar para o sumário](#sumário)


# Recursos (*Resources*)
No **Kubernetes** os recursos definidos indicam qual é o mínimo para que o container funcione. Definimos esses valores em `requests` dentro de `resources`, passando os valores para os campos `cpu` e `memory` em unidades de milicores.

Para entender as unidades de medidas utilizadas para definir a capacidade dos recursos que serão utilizados no Kubernetes no campo `cpu`, precisamos entender o que é **vCPU** e **milicores**. `vCPU` significa ***virtual Central Processing Unit***, que nada mais é do que uma CPU virtual que possui a mesma capacidade de processamento do que uma CPU física. Já **milicores** significa milisegundos de CPU, pode-se entender que <u>**milicores** é a milésima parte de um Core de CPU</u>, logo **1.000 (mil) milicores** é igual a **1 Core de CPU** que é igual a **1 vCPU**. A unidade de medida de processamento milicores é representada pela letra `m` e serve como um controle fino dos recursos de processamento que serão utilizados pelo container.

No campo `memory` informamos a quantidade mínima de memória necessária para o container. São utilizadas as unidades binárias que representam múltiplos de 1024, ou seja, Ki (Kibibytes), Mi (Mebibytes), Gi (Gibibytes), etc. Em palavras simples, 1KiB (um kibibyte) é o mesmo que dizer 1KB (um kilobyte), porém utilizasse a base binária, kibi, para evitar confusões e ambiguidades, já que 1KB são 1.000 bytes e 1KiB são, exatamente, 1.024 bytes, logo usar as bases binárias evita essa perda de 24 bytes quando fazemos a conversão ([Ver a tabela de perda de Bytes](#tabelas-das-unidades-binárias)).

Também podemos definir o limite de recursos que serão utilizados, ou seja, até qual quantidade que o contaiter podeconsumir de recursos. Essa especificação é passada no campo `limits`, também dentro do campo `resources`, que também possui os campos `cpu` e `memory`.

É importante salientar que não devemos permitir que a soma dos limites ultrapasse a quantidade de recursos disponíveis, por exemplo, imagine que temos 3 vCPU para usar de recurso e cada container consome 100m (ou 0.1 vCPU), logo, podemos subir 30 desses containeres. Quando definimos um limite de 500m (ou 0.5 vCPU), os containeres podem não consumir apenas os 100m, se estiverem trabalhando no limite irão consumir **até** 500m, sendo assim <u>temos que realizar a conta com o limite</u>, desta forma poderemos subir **até** 6 containeres sem ultrapassar a quantidade de recursos disponíveis e não mais 30.

[Voltar para o sumário](#sumário)


## Tabelas das unidades binárias

**Tabelas das unidades binárias**

| Símbolo | Nome Completo | Valor em Bytes                                 |
| ------- | ------------- | ---------------------------------------------- |
| KiB     | Kibibyte      | 1024 (2^10)                                    |
| MiB     | Mebibyte      | 1024 * 1024 (2^20)                             |
| GiB     | Gibibyte      | 1024 * 1024 * 1024 (2^30)                      |
| TiB     | Tebibyte      | 1024 * 1024 * 1024 * 1024 (2^40)               |
| PiB     | Pebibyte      | 1024 * 1024 * 1024 * 1024 * 1024 (2^50)        |
| EiB     | Exbibyte      | 1024 * 1024 * 1024 * 1024 * 1024 * 1024 (2^60) |

Tabela 1: Mostra o símbolo, nome e o valor em Bytes de cada unidade binária.


| Unidade        | Equivalente em Bytes                        |
| -------------- | ------------------------------------------- |
| Byte (B)       | 1 Byte                                      |
| Kibibyte (KiB) | 1.024 Bytes                                 |
| Mebibyte (MiB) | 1.048.576 Bytes (1.024 KiB)                 |
| Gibibyte (GiB) | 1.073.741.824 Bytes (1.024 MiB)             |
| Tebibyte (TiB) | 1.099.511.627.776 Bytes (1.024 GiB)         |
| Pebibyte (PiB) | 1.125.899.906.842.624 Bytes (1.024 TiB)     |
| Exbibyte (EiB) | 1.152.921.504.606.846.976 Bytes (1.024 PiB) |

Tabela 2: Tabela das unidades binárias e o equivalente em Bytes.


**Comparativo entre as unidades binárias e as unidades decimais**

| Unidade Binária | Equivalente em Bytes                        | Unidade Decimal | Equivalente em Bytes                       |
| --------------- | ------------------------------------------- | --------------- | ------------------------------------------ |
| Byte (B)        | 1 Byte                                      | Byte (B)        | 1 Byte                                     |
| Kibibyte (KiB)  | 1.024 Bytes                                 | Kilobyte (KB)   | 1.000 Bytes                                |
| Mebibyte (MiB)  | 1.048.576 Bytes (1.024 KiB)                 | Megabyte (MB)   | 1.000.000 Bytes (1.000 KB)                 |
| Gibibyte (GiB)  | 1.073.741.824 Bytes (1.024 MiB)             | Gigabyte (GB)   | 1.000.000.000 Bytes (1.000 MB)             |
| Tebibyte (TiB)  | 1.099.511.627.776 Bytes (1.024 GiB)         | Terabyte (TB)   | 1.000.000.000.000 Bytes (1.000 GB)         |
| Pebibyte (PiB)  | 1.125.899.906.842.624 Bytes (1.024 TiB)     | Petabyte (PB)   | 1.000.000.000.000.000 Bytes (1.000 TB)     |
| Exbibyte (EiB)  | 1.152.921.504.606.846.976 Bytes (1.024 PiB) | Exabyte (EB)    | 1.000.000.000.000.000.000 Bytes (1.000 PB) |

Tabela 3: Comparativo entre unidades binárias e unidades decimais.

Observe que quanto maior a unidade binária, mais Bytes são "perdidos" em relação a equivalente decimal, como ilustra a tabela abaixo.

**Perda de Bytes entre unidades binárias e decimais**

| Unidade Binária | Unidade Decimal | Diferença | Diferença em Bytes            |
| --------------- | --------------- | --------- | ----------------------------- |
| Byte (B)        | Byte (B)        | 0 Bytes   | 0 Bytes                       |
| Kibibyte (KiB)  | Kilobyte (KB)   | 24 Bytes  | 24 Bytes                      |
| Mebibyte (MiB)  | Megabyte (MB)   | 47,5 KiB  | 48.576 Bytes                  |
| Gibibyte (GiB)  | Gigabyte (GB)   | 70,3 MiB  | 73.741.824 Bytes              |
| Tebibyte (TiB)  | Terabyte (TB)   | 93,1 GiB  | 99.511.627.776 Bytes          |
| Pebibyte (PiB)  | Petabyte (PB)   | 112,6 TiB | 125.899.906.842.624 Bytes     |
| Exbibyte (EiB)  | Exabyte (EB)    | 125,8 PiB | 152.921.504.606.846.976 Bytes |

<u>Observações:</u>
1. A vírgula é a separadora de decimais e o ponto é o separador de milhares.
2. Os cálculos são aproximados, para um valor exato use sempre a diferença em Bytes.

[Voltar para o sumário](#sumário)


# Para lembrar
- Para criar um pod ou qualquer objeto Kubernetes utilizamos os arquivos .yaml (ou .yml) para passar as especificações e depois executaamos o comando `kubectl apply -f <filepath>` para efetivamente criar o objeto Kubernetes.
- *ReplicaSet* é um objeto Kubernetes que ajuda o gerenciamento dos *Pods* e de suas replicas. A vantagem é que caso um *Pod* caia, o *ReplicaSet* irá construir o *Pod* novamente.
  - Problema do *ReplicaSet* é quando atualizamos a imagem na qual ele se basea para criar os contêineres dos *pods*, pois o *ReplicaSet* não cria atomaticamente novos *pods* com a nova imagem fornecida, é necessário excluir cada um dos *pods* do *ReplicaSet*.
  - Para solucionar/contornar o problema do *ReplicaSet* precisamos usar outro objeto do Kubernetes, o *Deployment*.
- Quando os *Deployments* estão realizando a atualização dos *ReplicaSets* e dos *Pods*, há um tempo de zero *downtime*, ou seja, sua aplicação não ficará fora do ar durante esse período de atualização, pois ela é feita de maneira progressiva.
  - O *ReplicaSet* não será deletado, será criado um novo *ReplicaSet* e o antigo ficará sem nenhum *Pod*, ou seja, ficará vazio.
- As *labels* (propriedade definida no arquivo .yml do objeto Kubernetes) são importantes para facilitar as buscas pelo objeto Kubernetes.
- O *selector*, uma propriedade definida dentro da propriedade *spec* do objeto Kubernetes, é um seletor de *labels* que consegue selecionar apenas as *labels* com determinadas especificações.

  **Exemplo:**
    ``` k8s
    spec:
        selector:
            matchLabels:
                app: goserver
    ```

É graças à propriedade *seletor* que conseguimos diferenciar um serviço do outro, pois utilizamos o *seletor* como uma espécie de filtro.
- Ordem de grandeza dos objetos Kubernetes: *Deployments* > *ReplicaSets* > *Pods*
- Um rótulo é um par de chave-valor arbitrário anexado a um objeto.
- A diferença entre *port* e *targetPort* é que a propriedade *port* refere-se a porta do *service* e o *targetPort* refere-se a porta do contêiner que será acessada pelo serviço.
- O `kubectl` é um binário executável que é o *command client interface* utilizado para se comunicar com a API do Kubernetes através de certificados autenticados, porém a API do Kubernetes pode ser acessada diretamente por meio do comando `kubectl proxy --port=<port-number>`. Após executar o comando basta digitar no navegador `localhost:8080` para acessar a API local do Kubernetes.
  - Para acessar o endpoint do serviço criado: `localhost:<port-number>/api/v1/namespaces/default/service/<service-name>`
    - <port-number> é o número da porta usada no comando `kubectl proxy`
    - <service-name> é o nome do serviço
    - api/v1 normalmente é a API que usamos no Kubernetes

[Voltar para o sumário](#sumário)
