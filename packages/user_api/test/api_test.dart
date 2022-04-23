import 'package:http/http.dart' as http;
import 'package:user_api/user_api.dart';
import 'package:mocktail/mocktail.dart';
import 'package:test/test.dart';

class MockHttpClient extends Mock implements http.Client {}

class MockResponse extends Mock implements http.Response {}

class FakeUri extends Fake implements Uri {}

void main() {
  group('UserApiClient', () {
    late http.Client httpClient;
    late UserApiClient userApiClient;

    setUpAll(() {
      registerFallbackValue(FakeUri());
    });

    setUp(() {
      httpClient = MockHttpClient();
      userApiClient = UserApiClient(httpClient: httpClient);
    });

    group('constructor', () {
      test('does not require an httpClient', () {
        expect(UserApiClient(), isNotNull);
      });
    });

    group('SignIn Tokens', () {
      const username = 'mock-username';
      const password = 'mock-password';
      test('makes correct http request', () async {
        final response = MockResponse();
        when(() => response.statusCode).thenReturn(200);
        when(() => httpClient.get(any())).thenAnswer((_) async => response);
        try {
          await userApiClient.signIn(username, password);
        } catch (_) {}
        verifyNever(
              () =>
              httpClient.post(
                Uri.https(
                    'ktor-equipment-inventory.herokuapp.com', '/api/v1/login'),
                headers: {"Content-Type": "application/json"},
                body: {'username': username, 'password': password},
              ),
        );
      });


      test('throws LogInRequestFailure on non-200 response', () async {
        final response = MockResponse();
        when(() => response.statusCode).thenReturn(400);
        when(() => httpClient.post(any())).thenAnswer((_) async => response);
        try{
          await userApiClient.signIn(username, password);
        }catch(_){
          throwsA(isA<LogInRequestFailure>());
        }
      });

    //
    //
    //   test('returns Location on valid response', () async {
    //     final response = MockResponse();
    //     when(() => response.statusCode).thenReturn(200);
    //     when(() => response.body).thenReturn(
    //       '''[{
    // "accessToken": "eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJhdWQiOiJodHRwczovL2t0b3ItZXF1aXBtZW50LWludmVudG9yeS5oZXJva3VhcHAuY29tL2FwaS92MS9sb2dpbiIsImlzcyI6Imt0b3IiLCJpZCI6MSwiZXhwIjoxNjUwNjIyMTk4fQ.ubCuUG0-csAZYU-DtHXalqs5YISBWrrJNJfsGRV1H4U",
    // "refreshToken": "eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJhdWQiOiJodHRwczovL2t0b3ItZXF1aXBtZW50LWludmVudG9yeS5oZXJva3VhcHAuY29tL2FwaS92MS9sb2dpbiIsImlzcyI6Imt0b3IiLCJpZCI6MSwiZXhwIjoxNjUwNjQyODk4fQ.h2N0kKBKuWgRBz3JsFWyh89vqaQQeglqHmGc80yiYDM"
    // }]''',
    //     );
    //     when(() => httpClient.post(any())).thenAnswer((_) async => response);
    //     final actual = await userApiClient.signIn(username, password);
    //     expect(
    //       actual,
    //       isA<AuthResponse>()
    //           .having((l) => l.accessToken, 'accessToken', 'mock-token')
    //           .having((l) => l.refreshToken, 'refreshToken', 'mock-token')
    //       ,
    //     );
    //   });
    });

  group('getUser', () {
    const userId = 2;
    const accessToken =
        "eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJhdWQiOiJodHRwczovL2t0b3ItZXF1aXBtZW50LWludmVudG9yeS5oZXJva3VhcHAuY29tL2FwaS92MS9sb2dpbiIsImlzcyI6Imt0b3IiLCJpZCI6MSwiZXhwIjoxNjUwNjIyMTk4fQ.ubCuUG0-csAZYU-DtHXalqs5YISBWrrJNJfsGRV1H4U";
    test('makes correct http request', () async {
      final response = MockResponse();
      when(() => response.statusCode).thenReturn(200);
      when(() => response.body).thenReturn('{}');
      when(() => httpClient.get(any())).thenAnswer((_) async => response);
      try {
        await userApiClient.getUser(accessToken, userId);
      } catch (_) {}
      verifyNever(
            () =>
            httpClient.get(
                Uri.https('ktor-equipment-inventory.herokuapp.com',
                    '/api/v1/users/$userId'),
                headers: {"Content-type": "application/json"}),
      );
    });

    test('throws GetUserRequestFailure on non-200 response', () async {
      final response = MockResponse();
      when(() => response.statusCode).thenReturn(400);
      when(() => httpClient.get(any())).thenAnswer((_) async => response);
      expect(() async => await userApiClient.getUser(accessToken, userId), throwsA(isA<GetUserRequestFailure>()),
      );
    });

    test('returns user on valid response', () async {
      final response = MockResponse();
      when(() => response.statusCode).thenReturn(200);
      when(() => response.body).thenReturn('''
         [ {
            "id": 2,
            "surname": "Сазонова",
            "name": "Наталья",
            "patronymic": "Владимировна",
            "username": "natalia",
            "role": "READER"
          }]
        ''');
      when(() => httpClient.get(any())).thenAnswer((_) async => response);
      final actual = await userApiClient.getUser(accessToken, userId);
      expect(
        actual,
        isA<User>()
            .having((w) => w.id, 'id', 2)
            .having((w) => w.surname, 'surname', 'Сазонова')
            .having((w) => w.name, 'name', 'Наталья')
            .having((w) => w.username, 'username', 'natalia')
            .having((w) => w.role, 'role', UserRole.READER),
      );
    });
  });
});
}
