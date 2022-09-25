FROM jenkins/jenkins:lts-jdk11

LABEL maintainer="trantienduat98@gmail.com"

RUN set +x
ENV HOME=/home
ENV JENKINS_HOME=$HOME/jenkins
WORKDIR $JENKINS_HOME
RUN mkdir -p /home/jenkins/casc_config
ENV CASC_JENKINS_CONFIG=$JENKINS_HOME/casc_config

# turn-off runSetupWizard
ARG JAVA_OPTS
ENV JAVA_OPTS "-Djenkins.install.runSetupWizard=false ${JAVA_OPTS:-}"
# ARG -Dcasc.jenkins.config=$JENKINS_HOME/casc_config
USER 1000:1000
VOLUME /Users/duattran/jenkins_home:$JENKINS_HOME

COPY --chown=jenkins:jenkins casc_config $CASC_JENKINS_CONFIG
COPY --chown=jenkins:jenkins plugins.txt $JENKINS_HOME/plugins.txt
RUN jenkins-plugin-cli -f $JENKINS_HOME/plugins.txt

# RUN JENKINS DOCKER IMAGE
# docker build . -t jenkins 
# docker run -d -v jenkins_home:$HOME/jenkins_home -p 8080:8080 -p 50000:50000 --restart=on-failure c72f1a265231
