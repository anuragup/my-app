FROM jenkins/jenkins:lts

USER root

ARG USER_GROUP_ID
ARG USER_ID

# RUN groupmod -g ${USER_GROUP_ID} jenkins
RUN usermod -u ${USER_ID} -g ${USER_GROUP_ID} jenkins \ 
    # chown ${REF} since we changed the UID
    && chown -R jenkins ${REF}

USER jenkins

# copy plugins.txt to the $REF/init.groovy.d directory 

COPY plugins.txt ${REF}/init.groovy.d/plugins.txt
# install all plugins listed up there
RUN install-plugins.sh < ${REF}/init.groovy.d/plugins.txt


WORKDIR $JENKINS_HOME
