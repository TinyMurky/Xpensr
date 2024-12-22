# expense_tracker_app

## Java And Gradle Version
This app use gradle 8.3, can be check in `expense_tracker_app/android/gradle/wrapper/gradle-wrapper.properties`. 

If flutter default java and default gradle not match, 

Please check [java gradle matching table](https://docs.gradle.org/current/userguide/compatibility.html#java) for gradle java match, ex java 23 match gradle 8-10, java 20 match gradle 8.3

Then download java sdk tar version in [jdk archive](https://www.oracle.com/java/technologies/downloads/archive/)


Then Use `flutter config --jdk-dir=<jdk-direct>` to set up flutter default java sdk

## Git hook install
please run:
```
chmod +x ./scripts/post-pub-get.sh
./scripts/post-pub-get.sh
./scripts/install-hooks.bash
./scripts/pre-commit.bash
```
to install pre-commit hook in scripts


## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://docs.flutter.dev/cookbook)

For help getting started with Flutter development, view the
[online documentation](https://docs.flutter.dev/), which offers tutorials,
samples, guidance on mobile development, and a full API reference.
