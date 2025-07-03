# Use uma imagem base oficial do Python. A versão alpine é leve.
FROM python:3.13.4-alpine3.22

# Define o diretório de trabalho dentro do contêiner
WORKDIR /app

# Copia o arquivo de dependências para o diretório de trabalho.
# Isso é feito primeiro para aproveitar o cache de camadas do Docker.
# As dependências só serão reinstaladas se o requirements.txt mudar.
COPY requirements.txt ./

# Instala as dependências do projeto
# --no-cache-dir garante que não haverá cache do pip, mantendo a imagem menor
RUN pip install --no-cache-dir -r requirements.txt

# Copia todo o código da aplicação para o diretório de trabalho
COPY . .

# Expõe a porta que a aplicação vai usar
EXPOSE 8000

# Comando para iniciar a aplicação quando o contêiner for executado
# Usamos 0.0.0.0 para que a aplicação seja acessível de fora do contêiner.
CMD ["uvicorn", "app:app", "--host", "0.0.0.0", "--port", "8000"]