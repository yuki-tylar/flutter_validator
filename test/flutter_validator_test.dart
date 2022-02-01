import 'package:flutter_test/flutter_test.dart';

import 'package:flutter_validator/flutter_validator.dart';

void main() {
  test('required', () {
    Validator t = Validator.required(errorMessage: 'This field is required.');

    expect(t.validate(null), isNot(null));
    expect(t.validate(''), isNot(null));
    expect(t.validate('test'), null);
  });

  test('email', () {
    var t = Validator.email(errorMessage: 'Please enter valid email address');

    expect(t.validate(null), null);
    expect(t.validate(''), isNot(null));
    expect(t.validate('test--test--tet@'), isNot(null));
    expect(t.validate('test1.test2+test3-123test@gmail.com'), null);
  });

  test('price', () {
    var t = Validator.price(errorMessage: 'Please enter valid price');

    expect(t.validate(null), null);
    expect(t.validate(''), isNot(null));
    expect(t.validate('123..05'), isNot(null));
    expect(t.validate('\$123.05'), isNot(null));
    expect(t.validate('CA\$123.05'), isNot(null));
    expect(t.validate('123.'), isNot(null));
    expect(t.validate('123'), null);
    expect(t.validate('123.4'), null);
    expect(t.validate('12343.42'), null);
  });

  test('password', () {
    var t = Validator.password(errorMessage: 'Please enter valid password');

    expect(t.validate(null), null);
    expect(t.validate(''), isNot(null));
    expect(t.validate('abc'), isNot(null));
    expect(t.validate('abcdefgh'), isNot(null));
    expect(t.validate('123456789'), isNot(null));
    expect(t.validate('ABCDEFGH'), isNot(null));
    expect(t.validate('abcdABCD'), isNot(null));
    expect(t.validate('abcd1234'), isNot(null));
    expect(t.validate('A123456789'), null);
    expect(t.validate('Acde4567'), null);
    expect(t.validate('ACde123%^&'), null);
  });

  test('minLength', () {
    var t = Validator.minLength(10, errorMessage: 'Please enter longer');
    expect(t.validate(null), null);
    expect(t.validate(''), isNot(null));
    expect(t.validate('Ad E5'), isNot(null));
    expect(t.validate('abder123458'), null);
    expect(t.validate('abder 123458'), null);
  });

  test('maxLength', () {
    var t = Validator.maxLength(10, errorMessage: 'Please enter shorter');
    expect(t.validate(null), null);
    expect(t.validate(''), null);
    expect(t.validate('Ad E5'), null);
    expect(t.validate('abder123458'), isNot(null));
    expect(t.validate('abder 123458'), isNot(null));
  });
}
