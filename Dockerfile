FROM python:3.7

MAINTAINER Ernesto Sequeira "erdaseq@gmail.com"

ENV HOME=/opt/app-root

RUN mkdir -p ${HOME} && \
    useradd -u 1001 -r -g 0 -d ${HOME} -s /sbin/nologin \
            -c "Default Application User" default

COPY openshift/s2i ${HOME}/s2i
COPY openshift/run ${HOME}/run

RUN pip install flask

ENV BUILDER_VERSION 1.0

LABEL io.k8s.description="Platform for building Python" \
      io.k8s.display-name="Python Flask 1.0" \
      io.openshift.expose-services="5000:http"
      io.openshift.s2i.scripts-url="image://${HOME}/s2i/bin"

ENTRYPOINT ["python"]
USER 1001
EXPOSE 5000
CMD ["/opt/app-root/app.py"]


