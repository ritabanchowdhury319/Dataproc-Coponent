FROM google/cloud-sdk:latest
ADD ./src code/src
RUN chmod 755 code/src/dataproc.sh
ENTRYPOINT ["code/src/dataproc.sh"]