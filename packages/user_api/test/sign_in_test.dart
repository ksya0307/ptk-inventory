
import 'package:test/test.dart';
import 'package:user_api/user_api.dart';

void main() {
  group('Sign In', () {
    group('fromJson', () {
      test('Авторизация пользователя и получение токена', () {
        //проверка если результат коректен
        expect(
              AuthResponse.fromJson(<String, dynamic>{
                "accessToken": "kdfhksdhjhgkdj.dfhgk.dkfgk",
                "refreshToken": "sdlfjsk.fskjdf.skdfj"
              }),
          isA<AuthResponse>(),
        );
      });
    });
  });

  group('Get User', () {
    group('fromJson', () {
      test('Получение данных о юзере по токену и id', () {
        expect(
            User.fromJson(<String, dynamic>{
              "id": 928349,
              "surname": "mock surname",
              "name": "mock name",
              "patronymic": "mock ",
              "username": "mock mock",
              "role": "READER"
            })
            , isA<User>());
      });
    });
  });
}
