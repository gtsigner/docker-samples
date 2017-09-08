FROM nginx:1.13.3

COPY ./app /app
COPY ./dockerfiles/nginx/conf.d /etc/nginx/conf.d
COPY ./dockerfiles/nginx/nginx.conf /etc/nginx/nginx.conf

WORKDIR /app
