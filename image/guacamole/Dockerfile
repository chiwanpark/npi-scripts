FROM chiwanpark/zulu-embedded:8.44.0.213-aarch64
MAINTAINER Chiwan Park <chiwanpark@hotmail.com>

ARG GUAC_VERSION
ENV UGID=1000
ENV GUACAMOLE_HOME /home/guacamole
ENV JETTY_VERSION 9.4.30.v20200611
ENV PG_JDBC_VERSION 42.2.14

RUN addgroup --system --gid $UGID guacamole \
 && adduser --system --uid $UGID --gid $UGID guacamole \
 && apt -y update \
 && apt -y install \
      libcairo2-dev libjpeg62-turbo-dev libpng-dev libtool-bin libossp-uuid-dev \
      libavcodec-dev libavformat-dev libavutil-dev libswscale-dev freerdp2-dev libfreerdp-client2-2 \
      libpango1.0-dev libssh2-1-dev libtelnet-dev libvncserver-dev libwebsockets-dev \
      libpulse-dev libssl-dev libvorbis-dev libwebp-dev ghostscript make supervisor \
 && /sbin/ldconfig \
 && cd /tmp \
 && rm -rf *.deb \
 && curl -L -O "http://apache.org/dyn/closer.cgi?action=download&filename=guacamole/${GUAC_VERSION}/source/guacamole-server-${GUAC_VERSION}.tar.gz" \
 && tar -xzf guacamole-server-${GUAC_VERSION}.tar.gz \
 && cd guacamole-server-${GUAC_VERSION} \
 && ./configure --prefix=/usr \
 && make -j8 \
 && make install \
 && /sbin/ldconfig \
 && cd /tmp \
 && rm -rf guacamole-server-${GUAC_VERSION}* \
 && cd $GUACAMOLE_HOME \
 && curl -L -O https://repo1.maven.org/maven2/org/eclipse/jetty/jetty-distribution/${JETTY_VERSION}/jetty-distribution-${JETTY_VERSION}.tar.gz \
 && tar -xzf jetty-distribution-${JETTY_VERSION}.tar.gz \
 && rm -rf *.tar.gz \
 && mv jetty-distribution-${JETTY_VERSION} jetty \
 && curl -L -O "http://apache.org/dyn/closer.cgi?action=download&filename=guacamole/${GUAC_VERSION}/binary/guacamole-${GUAC_VERSION}.war" \
 && mv guacamole-${GUAC_VERSION}.war jetty/webapps/guacamole.war \
 && mkdir -p $GUACAMOLE_HOME/extensions $GUACAMOLE_HOME/lib $GUACAMOLE_HOME/log \
 && cd /tmp \
 && curl -L -O "http://apache.org/dyn/closer.cgi?action=download&filename=guacamole/${GUAC_VERSION}/binary/guacamole-auth-jdbc-${GUAC_VERSION}.tar.gz" \
 && tar -xzf guacamole-auth-jdbc-${GUAC_VERSION}.tar.gz \
 && mv guacamole-auth-jdbc-${GUAC_VERSION}/postgresql/*.jar $GUACAMOLE_HOME/extensions/ \
 && mv guacamole-auth-jdbc-${GUAC_VERSION}/postgresql/schema $GUACAMOLE_HOME/schema \
 && rm -rf guacamole-auth-jdbc* \
 && cd $GUACAMOLE_HOME/lib \
 && curl -L -O "https://jdbc.postgresql.org/download/postgresql-${PG_JDBC_VERSION}.jar" \
 && apt clean \
 && apt autoclean

ADD spv.conf $GUACAMOLE_HOME/spv.conf
ADD guacamole.properties $GUACAMOLE_HOME/guacamole.properties
RUN chown -R guacamole:guacamole $GUACAMOLE_HOME

USER guacamole
WORKDIR $GUACAMOLE_HOME
CMD ["supervisord", "-c", "spv.conf"]
