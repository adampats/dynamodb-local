FROM debian:jessie

# http://docs.aws.amazon.com/amazondynamodb/latest/developerguide/Tools.DynamoDBLocal.html
MAINTAINER adampats "https://github.com/adampats"

ENV AWS_URL "http://dynamodb-local.s3-website-us-west-2.amazonaws.com/dynamodb_local_latest.tar.gz"
ENV DYNAMO_DIR "/opt/dynamodb"
ENV DB_DIR "/opt/dynamodb/data"

# Java 7
RUN \
    apt-get update && \
    export DEBIAN_FRONTEND=noninteractive && \
    apt-get upgrade -y && \
    apt-get install -y openjdk-7-jdk && \
    rm -fr /var/cache/oracle-jdk7-installer && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# DynamoDB Local
RUN \
  apt-get install -y curl && \
  cd /tmp && \
  curl -k "$AWS_URL" -O && \
  mkdir -p "$DYNAMO_DIR" && \
  tar xzf dynamodb_local_latest.tar.gz -C "$DYNAMO_DIR/" && \
  rm -f dynamodb_local_latest.tar.gz

WORKDIR "$DYNAMO_DIR"
VOLUME "$DB_DIR"

ENTRYPOINT ["/usr/bin/java", "-Djava.library.path=.", "-jar", "DynamoDBLocal.jar", "-dbPath", "$DB_DIR", "-sharedDb"]
CMD [""]

EXPOSE 8000
