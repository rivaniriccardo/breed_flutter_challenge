build_runner:
	@dart run build_runner build --delete-conflicting-outputs

test-unit:
	@flutter test

test-coverage:
	@flutter test --coverage && lcov --remove coverage/lcov.info -o coverage/lcov.info && genhtml coverage/lcov.info --output=coverage && open coverage/index.html

test-golden:
	@flutter test --update-goldens

clean:
	@rm -rf pubspec.lock
	@flutter clean