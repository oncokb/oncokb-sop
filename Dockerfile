FROM ubuntu
RUN apt-get update
RUN apt-get install nginx -y
COPY index.html /var/www/html/
COPY sop/OncoKB_Curation_Standard_Operating_Procedure_v2.pdf /var/www/html/
EXPOSE 80
CMD ["nginx","-g","daemon off;"]
