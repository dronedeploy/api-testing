# API Load & Performance Testing

This repository is for load and performance testing DroneDeploy's various APIs.

It uses [K6](https://k6.io/) as the testing frame work and runs in our GKE clusters. It's broken down into two groups
of tests, load and performance. These groups test fundamentally different things but tests within each can leverage
much of the configuration. See the READMEs in the individual directories for more details.

## Running Tests

## Writing Tests

[Javascript API](https://k6.io/docs/javascript-api/)
