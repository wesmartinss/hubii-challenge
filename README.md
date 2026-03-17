# DevOps Hubii Challenge

Projeto desenvolvido como solução para desafio técnico com foco em fundamentos de DevOps, containers, Kubernetes, CI/CD, Terraform e boas práticas de segurança.

A proposta foi montar uma estrutura simples, mas organizada, priorizando clareza, funcionamento e decisões técnicas fáceis de explicar.

---

## Estrutura do projeto

```text
.
├── app/
│   ├── main.py
│   └── requirements.txt
│
├── docker/
│   └── Dockerfile
│
├── k8s/
│   ├── deployment.yaml
│   ├── service.yaml
│   └── ingress.yaml
│
├── terraform/
│   ├── main.tf
│   ├── variables.tf
│   └── outputs.tf
│
├── docs/
│   └── security.md
│
├── .github/
│   └── workflows/
│       └── ci.yml
│
├── .gitignore
├── .dockerignore
└── README.md
```

---

## Aplicação

A aplicação foi desenvolvida em Python utilizando FastAPI, por ser uma forma simples e rápida de expor um endpoint leve para este tipo de desafio.

Ela expõe o endpoint:

`/health`

Retornando:

```json
{
  "status": "ok",
  "version": "1.0.0",
  "environment": "APP_ENV"
}
```

A aplicação roda na porta:

`8080`

A variável `APP_ENV` foi utilizada para simular comportamento por ambiente, permitindo identificar facilmente se a aplicação está rodando em desenvolvimento ou produção, algo comum quando a mesma aplicação precisa responder de forma diferente dependendo do ambiente.

---

## Como executar localmente

Antes da containerização, a aplicação também pode ser executada localmente. Isso ajuda em testes rápidos e facilita validar o funcionamento sem depender do container, principalmente durante desenvolvimento.

### Criar ambiente virtual Python

```bash
python3 -m venv venv
source venv/bin/activate
```

### Instalar dependências

```bash
pip install -r app/requirements.txt
```

### Executar aplicação

```bash
uvicorn app.main:app --host 0.0.0.0 --port 8080
```

---

## Docker

Depois da validação local, a aplicação também pode ser executada em container para garantir portabilidade e reproduzir um cenário mais próximo de produção, evitando diferenças entre ambientes.

### Build da imagem

```bash
docker build -f docker/Dockerfile -t devops-hubii:1.0 .
```

### Executar container

```bash
docker run --rm -p 8080:8080 -e APP_ENV=dev devops-hubii:1.0
```

### Decisões adotadas no Dockerfile

- Uso de imagem oficial `python:3.12-slim`, por ser uma imagem mais leve
- Execução com usuário não root, evitando rodar a aplicação com privilégios desnecessários
- Estrutura simples para facilitar leitura e manutenção, já que a ideia aqui foi manter o desafio direto sem complexidade desnecessária

### Melhorias possíveis

- Separar etapas de build para gerar uma imagem final menor e mais limpa (multi-stage build)
- Fixação mais rígida de dependências
- Assinatura de imagem em cenário produtivo

---

## Kubernetes

Foram criados os seguintes manifestos:

- Deployment
- Service
- Ingress

### Deployment

Contém:

- 1 réplica
- variável `APP_ENV`
- requests e limits de CPU e memória
- readinessProbe
- livenessProbe

### Service

Utilizado `ClusterIP` para comunicação interna entre os componentes do cluster, já que nesse cenário o acesso externo fica sob responsabilidade do Ingress.

### Ingress

Responsável por expor acesso HTTP e encaminhar as requisições para o Service, evitando depender diretamente do IP do pod.

---

## CI/CD

Pipeline criada com GitHub Actions contendo:

- validação simples do código Python
- build da imagem Docker
- scan de vulnerabilidade com Trivy

Arquivo: `.github/workflows/ci.yml`

A ideia foi manter uma pipeline simples, porém cobrindo validação básica e segurança, sem adicionar etapas que fugissem do escopo do desafio.

---

## Terraform

Foi criado um exemplo simples utilizando provider AWS para provisionamento de bucket S3.

Inclui:

- variáveis
- output
- tags

Objetivo foi mostrar uso básico de infraestrutura como código sem complexidade desnecessária

---

## Segurança

Foi criado um arquivo específico com considerações de segurança:

Arquivo: `docs/security.md`

Nele foram descritos pontos como:

- gerenciamento de segredos
- proteção de credenciais
- boas práticas em Docker
- boas práticas em cloud

---

## Decisões técnicas adotadas

A ideia principal foi manter o projeto simples e mais organizado.

Evitei adicionar complexidade que não agregaria ao desafio, priorizando fundamentos bem aplicados e fáceis de explicar.

---

## Melhorias que eu aplicaria em um cenário real

- Utilização de registry externo para imagens Docker (Neste desafio a imagem foi utilizada localmente, mas em cenário real eu usaria Docker Hub ou ECR)
- ConfigMap e Secret no Kubernetes
- Deploy automatizado em cluster real
- Terraform com backend remoto
- Observabilidade com logs e métricas
