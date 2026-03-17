# Considerações de Segurança

## Gerenciamento de segredos em produção real
Em um ambiente real, o ideal é não deixar segredos diretamente no código, Dockerfile, manifestos Kubernetes ou pipeline em texto puro.

Uma abordagem boa seria utilizar soluções próprias para isso, como:
- AWS Secrets Manager - "Serviço da AWS para armazenar e gerenciar segredos (senhas, tokens, chaves), com suporte a rotação automática e controle de acesso."
- AWS Systems Manager Parameter Store - "  Armazena parâmetros e segredos de forma segura. Mais simples e econômico, porém com menos recursos que o Secrets Manager."
- Kubernetes Secrets integrado com algum secret manager externo - "Recurso do Kubernetes para armazenar segredos no cluster. Com integração externa, evita manter dados sensíveis diretamente nele."
- Secrets do GitHub Actions - "Armazena segredos usados em pipelines de CI/CD, injetando-os com segurança durante a execução dos workflows."

Dessa forma fica mais fácil centralizar o armazenamento e reduzir a exposição

## Como evitar exposição de credenciais
Algumas práticas relevantes para evitar exposição de credenciais:
- Nunca versionar senhas, tokens ou chaves privadas no repositório (Por isso utilizar o .gitignore)
- Utilizar variáveis de ambiente ou secret managers em vez de hardcode (Muito melhor até mesmo se tiver rotação de variaveis e secrets, pra nao precisar mexer diretamente no codigo)
- Adicionar arquivos sensíveis como `.env` no `.gitignore`
- Restringir secrets no CI/CD somente ao necessário
- Revisar logs para evitar que alguma informação sensível apareça

## Melhorias de segurança na imagem Docker
Na imagem Docker, algumas boas práticas seriam:
- Utilizar imagens oficiais e mais enxutas, como `python:3.12-slim` (As vezes pesamos muito as imagens sem necessidade)
- Executar o container com usuário não root
- Evitar instalar pacotes desnecessários
- Manter dependências atualizadas
- Utilizar ferramentas de scan como Trivy no pipeline

## Boas práticas de acesso em cloud
Em cloud, algumas práticas importantes:
- Aplicar o princípio do menor privilégio nas permissões IAM
- Evitar uso da conta root no dia a dia
- Separar acessos por função ou ambiente (IAM Groups)
- Habilitar logs e monitoramento
- Proteger recursos sensíveis com políticas adequadas

## Melhorias possíveis em um cenário real
Se fosse um ambiente mais completo, também seria interessante considerar:
- Assinatura de imagens Docker
- Network Policies no Kubernetes
- MFA para acessos administrativos
- Rotação periódica de segredos
- Logging centralizado e alertas