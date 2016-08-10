FROM kaihofstetter/wordpress-cli:latest
MAINTAINER Kai Hofstetter <kai.hofstetter@gmx.de>

# Install plugins
RUN apt-get update && \
    apt-get -y install php5-xdebug php5-curl
    
# Add configuration script
ADD config_xdebug.sh /config_xdebug.sh
ADD run_wordpress_xdebug.sh /run_wordpress_xdebug.sh
RUN chmod 755 /*.sh

# Xdebug environment variables
ENV XDEBUG_PORT 9000

EXPOSE 80 3306 
CMD ["/run_wordpress_xdebug.sh"]
