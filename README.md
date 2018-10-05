# Data Processor

[![CircleCI](https://circleci.com/gh/DylanGuedes/data_processor/tree/master.svg?style=svg)](https://circleci.com/gh/DylanGuedes/data_processor/tree/master)
[![Coverage Status](https://coveralls.io/repos/github/DylanGuedes/data_processor/badge.svg?branch=master)](https://coveralls.io/github/DylanGuedes/data_processor?branch=master)

## Running for Development

1. With a working docker and docker-compose environment, run:

```
docker-compose up -d
```

(that's it)

The server will be available at [`localhost:4545`](http://localhost:4545).

## Running for Production (using Kubernetes - K8S)

1. With a working and configurated K8S setup, run:

```
sudo ./scripts/run_deploy.sh
```

**To stop:**

```
sudo ./scripts/stop_deploy.sh
```


**To update Docker images (build a new deploy):**

```
sudo ./scripts/new_deploy.sh
```


## Running Tests

You can check our CI config or just run the script `run_tests.sh` in the scripts folder.
