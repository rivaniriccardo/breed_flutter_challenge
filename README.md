# Breed Flutter Challenge

A simple app to show a list of dog breeds and their images,
built with Flutter and the [Dog API](https://dog.ceo/dog-api/).

## Dependencies

1. Flutter and Dart installed on your system (Channel stable)
2. lcov installed on your system (`brew install lcov`) to generate the coverage report
3. Make installed on your system (`brew install make`) to run commands from the Makefile

## How to run the project

1. Clone the project
2. Run `flutter pub get`
3. Run `make build_runner` to generate dependencies files
4. Run `flutter run`

## Unit tests

1. Run `make test-unit` to run the unit tests
2. Run `make test-coverage` to run the tests and generate the coverage report

Tested all business logic and repositories (bloc and repo folders).

## Golden tests

1. Run `make test-golden` to run the golden tests and generate the golden files

Tested all pages and widgets (view folders).

## Integration tests

1. Run `make test-integration` to run the integration tests

There are different libraries to run integration tests, I chose to use the Flutter test_integration library.
Others awesome libraries are: Fluttium, Patrol, Honey.
