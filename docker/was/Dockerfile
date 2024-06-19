FROM node:latest
ENV MYSQL_HOST=211.183.3.222:3306
ENV MYSQL_DATABASE=counter
ENV MYSQL_USER=root
ENV MYSQL_PASSWORD=test1234
RUN apt update && \
    apt install -y vim && \
    apt install -y default-mysql-client && \
    npm create vite@latest tem -- --template react && \
    cd tem && \
    npm install
WORKDIR /tem
ADD ./vite.config.js .
WORKDIR /tem
ENTRYPOINT ["npm","run","dev"]