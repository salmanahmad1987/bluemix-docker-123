FROM centos:6
MAINTAINER salman.ahmad.9211@gmail.com

RUN yum -y install php httpd;\
	yum clean all


COPY index.php /var/www/html/

# Export port 80
EXPOSE 80

# This container is a web server serving PHP apps, so a plain Apache is our entry point
ENTRYPOINT [ "/usr/sbin/httpd", "-DFOREGROUND" ]
