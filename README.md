# API Load & Performance Testing

This repository is for load and performance testing DroneDeploy's various APIs.

It uses [K6](https://k6.io/) as the testing frame work and runs in our GKE clusters. It's broken down into two groups
of tests, load and performance. These groups test fundamentally different things but tests within each can leverage
much of the same configuration. See the READMEs in the individual directories for more details.

## Running Tests

The pipeline user's key for `stage` is required to run the tests. Make sure to export it as `PIPELINE_KEY`.

```shell
$ PIPELINE_KEY=<redacted> make run-local
```

**CAVEAT**: Currently the test module run is `tests/performance/folders.js`.

## Writing Tests

K6 uses a custom JS interpreter with its own builtin modules. To create a test, create a new module under the `tests`
directory. Your module must export a function called `default` that executes the desired test. It may also export an
object `options` that sets up the parameters for executing your test.

K6 has amazing [documentation](https://k6.io/docs/).
[This section](https://k6.io/docs/getting-started/running-k6/) will get you started writing tests.

For a working example, look at [folders.js](tests/performance/folders.js)
