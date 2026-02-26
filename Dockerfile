# 1. Usa uma imagem leve do Node.js
FROM node:20-alpine

# 2. Define onde os arquivos ficarão dentro do contêiner
WORKDIR /app

# 3. Copia apenas os arquivos de dependências primeiro (otimiza o cache)
COPY package*.json ./

# 4. Instala as dependências dentro do Linux do Docker
RUN npm install

# 5. Copia o restante dos arquivos do seu projeto
COPY . .

# 6. Expõe a porta que o Vite usa
EXPOSE 5173

# 7. Comando para rodar o projeto com suporte a rede externa (--host)
CMD ["npm", "run", "dev", "--", "--host"]