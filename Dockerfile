FROM httpd:latest
COPY taxigrabber/* /usr/local/apache2/htdocs/
EXPOSE 80
