# Notes about this image

* Sets up an environment to run your CDK stack
* Uses Ubuntu 20.04
* Installs python3, boto3, aws-cdk, aws-cdk-lib

# How to run this image

Assuming that you built the image and named it risk-scoring/latest:

```
docker run --workdir=<absolute path to cdk directory> --env VAR=1 risk-scoring/latest \
      bash -c '<some command> --optional-arg "<some value>" --env "some val"'
```
