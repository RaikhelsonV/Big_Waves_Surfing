FROM nginx

RUN rm /etc/nginx/conf.d/default.conf

COPY index.html /usr/share/nginx/html
COPY style.css /usr/share/nginx/html
COPY image /usr/share/nginx/html/image

EXPOSE 80
