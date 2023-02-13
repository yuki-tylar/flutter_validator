import 'package:flutter_test/flutter_test.dart';

import 'package:validator/flutter_validator.dart';

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

    var val = ['test1', 'test2'];
    expect(t.validate(val),
        'validator error: Passed value type is ${val.runtimeType}. This type is not allowed to pass Validator.minLength');
    var val1 = {'test': true};
    expect(t.validate(val1),
        'validator error: Passed value type is ${val1.runtimeType}. This type is not allowed to pass Validator.minLength');
  });

  test('maxLength', () {
    var t = Validator.maxLength(10, errorMessage: 'Please enter shorter');
    expect(t.validate(null), null);
    expect(t.validate(''), null);
    expect(t.validate('Ad E5'), null);
    expect(t.validate('abder123458'), isNot(null));
    expect(t.validate('abder 123458'), isNot(null));

    var val = ['test1', 'test2'];
    expect(t.validate(val),
        'validator error: Passed value type is ${val.runtimeType}. This type is not allowed to pass Validator.maxLength');
    var val1 = {'test': true};
    expect(t.validate(val1),
        'validator error: Passed value type is ${val1.runtimeType}. This type is not allowed to pass Validator.maxLength');
  });

  test('min', () {
    var t = Validator.min(2, errorMessage: 'Please select 2 or more');
    expect(t.validate(null), null);
    expect(t.validate(['test1']), 'Please select 2 or more');
    expect(t.validate(['test1', 'test2']), null);
    expect(t.validate(['test1', 'test2', 'test3']), null);

    var val = 'test';
    expect(t.validate(val),
        'validator error: Passed value type is ${val.runtimeType}. This type is not allowed to pass Validator.min');
    var val1 = {'test': true};
    expect(t.validate(val1),
        'validator error: Passed value type is ${val1.runtimeType}. This type is not allowed to pass Validator.min');

    var t2 = Validator.min(2, errorMessage: 'Please enter 2 or more');
    expect(t2.validate(1), 'Please enter 2 or more');
    expect(t2.validate(1.5), 'Please enter 2 or more');
    expect(t2.validate(5), null);
    expect(t2.validate(5.7), null);
  });

  test('max', () {
    var t = Validator.max(2, errorMessage: 'Please select 2 or less');
    expect(t.validate(null), null);
    expect(t.validate(['test1']), null);
    expect(t.validate(['test1', 'test2']), null);
    expect(t.validate(['test1', 'test2', 'test3']), 'Please select 2 or less');

    var val = 'test';
    expect(t.validate(val),
        'validator error: Passed value type is ${val.runtimeType}. This type is not allowed to pass Validator.max');
    var val1 = {'test': true};
    expect(t.validate(val1),
        'validator error: Passed value type is ${val1.runtimeType}. This type is not allowed to pass Validator.max');

    var t2 = Validator.max(100, errorMessage: 'Please enter {max} or less');
    expect(t2.validate(101), 'Please enter 100 or less');
    expect(t2.validate(100.58), 'Please enter 100 or less');
    expect(t2.validate(5), null);
    expect(t2.validate(5.2), null);
  });

  test('match', () {
    var target = TextEditingController(text: '');
    var t = Validator.match(target);
    expect(t.validate(''), null);
    expect(t.validate('test', 'Not matched'));
  })
}
