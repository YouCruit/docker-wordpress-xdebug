FROM kaihofstetter/wordpress-cli:latest
MAINTAINER Tobias <tobias@youcruit.com>

# Install plugins
RUN apt-get update && \
    apt-get -y install php5-xdebug php5-curl
    
# Add configuration script
ADD config_xdebug.sh /config_xdebug.sh
ADD run_wordpress_xdebug.sh /run_wordpress_xdebug.sh
RUN chmod 755 /*.sh

# Xdebug environment variables
ENV XDEBUG_PORT 9000
ENV XDEBUG_HOST ""

# Add more debugging in wordpress
RUN find / -name "wp-config.php" -print0 | xargs -0 sed "s/define('WP_DEBUG', false);/define('WP_DEBUG', true);/g" -i

# Output emails to console (docker logs)
RUN echo -e '#!/bin/bash\necho ARGS: "$*";echo; echo; cat' >/usr/sbin/sendmail
RUN chmod a+rx /usr/sbin/sendmail

EXPOSE 80 3306 
CMD ["/run_wordpress_xdebug.sh"]
