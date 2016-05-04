########################################################################
#                    guacamole Web App for OpenShift                   #
########################################################################

FROM fedora:23

MAINTAINER Rich Lucente <rlucente@redhat.com>

LABEL vendor="Red Hat"
LABEL version="0.2"
LABEL description="guacamole Web App for OpenShift"

# Add the needed package for guacamole and set permissions so any
# unprivileged user can run guacamole

RUN    dnf -y update \
    && dnf -y install \
           guacamole \
    && dnf -y clean all

ADD resources/user-mapping.xml /etc/guacamole/
ADD resources/logback.xml /etc/guacamole/
ADD resources/tomcat-users.xml /etc/tomcat/

RUN    chmod 640 /etc/guacamole/*.xml \
    && chmod 660 /etc/tomcat/tomcat-users.xml

USER 1000

EXPOSE 8080

CMD ["/usr/libexec/tomcat/server", "start"]

