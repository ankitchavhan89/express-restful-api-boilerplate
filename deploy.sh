#!/bin/bash
docker build -t ankitchavhan89/express-restful-api-boilerplate .
docker push ankitchavhan89/express-restful-api-boilerplate

ssh deploy@$DEPLOY_SERVER << EOF
docker pull ankitchavhan89/express-restful-api-boilerplate
docker stop api-boilerplate || true
docker rm api-boilerplate || true
docker rmi ankitchavhan89/express-restful-api-boilerplate:current || true
docker tag ankitchavhan89/express-restful-api-boilerplate:latest ankitchavhan89/express-restful-api-boilerplate:current
docker run -d --restart always --name api-boilerplate -p 3000:3000 ankitchavhan89/express-restful-api-boilerplate:current
EOF
