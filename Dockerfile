# # 1. Usa uma imagem leve do Node.js
# FROM node:20-alpine

# # 2. Define onde os arquivos ficarão dentro do contêiner
# WORKDIR /app

# # 3. Copia apenas os arquivos de dependências primeiro (otimiza o cache)
# COPY package*.json ./

# # 4. Instala as dependências dentro do Linux do Docker
# RUN npm install

# # 5. Copia o restante dos arquivos do seu projeto
# COPY . .

# # 6. Expõe a porta que o Vite usa
# EXPOSE 5173

# # 7. Comando para rodar o projeto com suporte a rede externa (--host)
# CMD ["npm", "run", "dev", "--", "--host"]

# ESTÁGIO 1: Build (A "Fábrica")
FROM node:20-alpine AS builder

WORKDIR /app

COPY package*.json ./

RUN npm install

COPY . .

# Linha antiga: (Não existia um passo de build focado em produção no seu)
# Comando novo: Gera a pasta /dist com os arquivos otimizados
RUN npm run build

# ---

# ESTÁGIO 2: Execução (O "Site no Ar")
# Linha antiga: FROM node:20-alpine (Você continuava na mesma imagem pesada)
# Linha nova: Iniciamos uma imagem limpa para jogar fora o lixo do build
FROM node:20-alpine

WORKDIR /app

# Linha antiga: (Não existia, pois você rodava o código fonte direto)
# Linha nova: Instala um servidor estático leve para rodar o site profissionalmente
RUN npm install -g serve

# Linha antiga: COPY . . (Copiava tudo, incluindo pastas pesadas como node_modules)
# Linha nova: Copia APENAS a pasta de produção que foi gerada no estágio "builder"
COPY --from=builder /app/dist ./dist

# Linha antiga: EXPOSE 5173
# Linha nova: Mantemos a porta, mas agora focada no servidor de produção
EXPOSE 5173

# Linha antiga: CMD ["npm", "run", "dev", "--", "--host"]
# Linha nova: Roda o servidor de produção servindo a pasta compactada
CMD ["serve", "-s", "dist", "-l", "5173"]