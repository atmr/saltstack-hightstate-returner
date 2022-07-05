## Description

Docker setup to test salt stack highstate returner module

## Getting started

```
$ docker-compose build
$ docker-compose up -d smtp
$ docker-compose run --rm saltstack-py3 test # test current version
$ docker-compose run --rm saltstack-py3 test-patch # test patched version
```

this will launch a salt-master instance, a salt-minion instance and try to execute highstate using the returner to send an email. Email sents can be inspected using mailhog instance in port 8025.

`
$ curl -s http://localhost:8025/api/v2/message | jq
`

If a message is received then the test was not successfull as the highstate returner is configured not to send anything in case of success
