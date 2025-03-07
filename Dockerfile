FROM ubuntu
RUN apt-get update
RUN apt-get install nginx -y
COPY index.html /var/www/html/
COPY sop /var/www/html/sop
COPY css /var/www/html/css
COPY images /var/www/html/images
COPY js /var/www/html/js

EXPOSE 80
CMD ["nginx","-g","daemon off;"]
