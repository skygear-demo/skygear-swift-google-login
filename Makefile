.PHONY: test
test: test-objc test-swift

.PHONY: test-objc
test-objc:
	-rm -rf build/YourProjectName
	mkdir -p build
	cd build; SKIP_FAREWELL=true pod lib create --silent --template-url=.. "YourProjectName" < ../scripts/script-objc
	cd build/YourProjectName; xcodebuild -workspace YourProjectName.xcworkspace -scheme YourProjectName -sdk iphonesimulator

.PHONY: test-swift
test-swift:
	-rm -rf build/YourProjectName
	mkdir -p build
	cd build; SKIP_FAREWELL=true pod lib create --silent --template-url=.. "YourProjectName" < ../scripts/script-swift
	cd build/YourProjectName; xcodebuild -workspace YourProjectName.xcworkspace -scheme YourProjectName -sdk iphonesimulator
