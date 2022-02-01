<!-- 
This README describes the package. If you publish this package to pub.dev,
this README's contents appear on the landing page for your package.

For information about how to write a good package README, see the guide for
[writing package pages](https://dart.dev/guides/libraries/writing-package-pages). 

For general information about developing packages, see the Dart guide for
[creating packages](https://dart.dev/guides/libraries/create-library-packages)
and the Flutter guide for
[developing packages and plugins](https://flutter.dev/developing-packages). 
-->

## Features

Form validator for flutter
## Getting started

Copy file `flutter_validator.dart` into your project.

## Usage

```dart
const validator = Validator.required();
validator.validate(''); // --> returned value will be String 'Required' because passed value is empty string.
```

You can customize error message.
```dart
const validator = Validator.required(errorMessage: 'Please enter your name');
validator.validate(null); // --> returned value will be String 'Please enter your name'
```

Available validators
* required
* email
* price 
* password
* minLength
* maxLength

You can customize price pattern & password pattern
```dart
const validator1 = Validator.price(pattern=r'\d{4,}');
const validator2 = Validator.password(pattern=r'^(?=.*[A-Z])[a-zA-Z\d]{8,}$');
```