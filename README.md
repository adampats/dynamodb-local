### dynamodb-local

A docker image for running DynamoDB locally.

See this [Amazon Docs page](http://docs.aws.amazon.com/amazondynamodb/latest/developerguide/Tools.DynamoDBLocal.html) for details.

How to use it:
```bash
git clone https://github.com/adampats/dynamodb-local.git
cd dynamodb-local
docker build -t dynamodb-local:latest .
docker run -d -p 8000:8000 dynamodb-local:latest
```

Optionally mount the data directory to a host location with the `-v ./dynamodb_data:/opt/data` flag or similar.
