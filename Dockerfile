########################################################################
#                    guacamole Web App for OpenShift                   #
########################################################################

FROM fedora:22

MAINTAINER Rich Lucente <rlucente@redhat.com>

LABEL vendor="Red Hat"
LABEL version="0.1"
LABEL description="guacamole Web App for OpenShift"

# Add the needed package for guacamole and set permissions so any
# unprivileged user can run guacamole

RUN    dnf -y update \
    && dnf -y install \
           guacamole \
    && dnf -y clean all \
    && chmod -R a+rwX \
           /etc/tomcat \
           /var/cache/tomcat \
           /var/lib/tomcat \
           /var/log/tomcat

ADD resources/user-mapping.xml /etc/guacamole/

RUN    chmod -R a+rX \
           /etc/guacamole

USER 1000

EXPOSE 8080

CMD ["/usr/libexec/tomcat/server", "start"]

