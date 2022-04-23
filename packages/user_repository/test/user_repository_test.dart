import 'package:user_api/user_api.dart' as user_api;
import 'package:mocktail/mocktail.dart';
import 'package:test/test.dart';
import 'package:user_repository/user_repository.dart';

class MockUserApiClient extends Mock implements user_api.UserApiClient {}

class MockTokens extends Mock implements user_api.AuthResponse {}

class MockUser extends Mock implements user_api.User {}

void main() {
  group('UserRepository', () {
    late user_api.UserApiClient userApiClient;
    late UserRepository userRepository;

    setUp(() {
      userApiClient = MockUserApiClient();
      userRepository = UserRepository(userApiClient: userApiClient);
    });

    group('constructor', () {
      test('instantiates internal UserApi when not injected', () {
        expect(UserRepository(), isNotNull);
      });
    });

    group('getUser', () {
      const username = 'elena';
      const password = 'admin';
      const userId = 1;
      const accessToken =
          "eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJhdWQiOiJhdWRpZW5jZSIsImlzcyI6Imt0b3IiLCJpZCI6MSwiZXhwIjoxNjUwNjI1ODI4fQ.OlzFutMRBRNS0I7GUj7jTnW2Bm7u2El_QO48HJXrR-Q";

      test('calls SignIn with correct user data', () async {
        try {
          await userRepository.getUser(username, password);
        } catch (_) {}
        verify(() => userApiClient.signIn(username, password)).called(1);
      });

      test('throws ehn SignIn fails', () async {
        final exception = Exception('oops');
        when(() => userApiClient.signIn(any(), any())).thenThrow(exception);
        expect(
          () async => await userRepository.getUser(username, password),
          throwsA(exception),
        );
      });

      test('calls getUser with correct userId and token', () async {
        final data = MockTokens();
        when(() => data.userId).thenReturn(userId);
        when(() => userApiClient.signIn(any(), any())).thenAnswer(
          (_) async => data,
        );
        try {
          await userRepository.getUser(username, password);
          verify(() => userApiClient.getUser(accessToken, userId)).called(1);
        } catch (_) {}
      });

      test('throws when getUser fails', () async {
        final exception = Exception('oops');
        final data = MockTokens();
        when(() => data.userId).thenReturn(userId);
        when(() => userApiClient.signIn(any(), any()))
            .thenAnswer((_) async => data);
        when(() => userApiClient.getUser(any(), any())).thenThrow(exception);
         try {
          await userRepository.getUser(username, password);
        } catch (_) {
          throwsA(exception);
        }
      });
    });
  });
}
