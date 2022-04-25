import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ptk_inventory/user/cubit/user_cubit.dart';
import 'package:ptk_inventory/user/user.dart';
import 'package:mocktail/mocktail.dart';
import 'package:user_repository/user_repository.dart' as user_repository;

import 'hydrated_bloc.dart';

const surname = 'Потемкина';
const name = 'Елена';
const patronymic = 'Юрьевна';
const username = 'elena';
const password = 'admin';

class MockUserRepository extends Mock
    implements user_repository.UserRepository {}

class MockUser extends Mock implements user_repository.User {}

void main() {
  group('WeatherCubit', () {
    late user_repository.User user;
    late user_repository.UserRepository userRepository;
    late UserCubit userCubit;

    setUp(() async {
      user = MockUser();
      userRepository = MockUserRepository();
      when(() => user.surname).thenReturn(surname);
      when(() => user.name).thenReturn(name);
      when(() => user.patronymic).thenReturn(patronymic);
      when(() => user.username).thenReturn(username);
      when(
        () => userRepository.getUser(username: any(),password: any()),
      ).thenAnswer((_) async => user);
      userCubit = await mockHydratedStorage(() => UserCubit(userRepository));
    });

    test('initial state is correct', () {
      mockHydratedStorage(() {
        final userCubit = UserCubit(userRepository);
        expect(userCubit.state, UserState());
      });
    });

    group('toJson/fromJson', () {
      test('work properly', () {
        mockHydratedStorage(() {
          final userCubit = UserCubit(userRepository);
          expect(
            userCubit.fromJson(userCubit.toJson(userCubit.state)),
            userCubit.state,
          );
        });
      });
    });

    group('fetchUser', () {
      blocTest<UserCubit, UserState>(
        'calls getUser with correct username and password',
        build: () => mockHydratedStorage(() => UserCubit(userRepository)),
        act: (cubit) => cubit.fetchUser(username, password),
        verify: (_) {
          verify(() => userRepository.getUser(username : username, password: password)).called(1);
        },
      );

      blocTest<UserCubit, UserState>(
        'emits [loading, failure] when getUser throws',
        setUp: () {
          when(
            () => userRepository.getUser(username: any(),password: any()),
          ).thenThrow(Exception('oops'));
        },
        build: () => mockHydratedStorage(() => UserCubit(userRepository)),
        act: (cubit) => cubit.fetchUser(username, password),
        expect: () => <UserState>[
          UserState(status: UserStatus.loading),
          UserState(status: UserStatus.failure),
        ],
      );

      blocTest<UserCubit, UserState>(
        'emits [loading, success] when getUser returns User Data',
        build: () => mockHydratedStorage(() => UserCubit(userRepository)),
        act: (cubit) => cubit.fetchUser(username, password),
        expect: () => <dynamic>[
          UserState(status: UserStatus.loading),
          isA<UserState>()
              .having((w) => w.status, 'status', UserStatus.success)
              .having(
                (w) => w.user,
                'user',
                isA<User>()
                    .having((w) => w.surname, 'surname', isNotNull)
                    .having((w) => w.name, 'name', isNotNull)
                    .having((w) => w.patronymic, 'patronymic', isNotNull)
                    .having((w) => w.username, 'username', isNotNull),
              ),
        ],
      );


      blocTest<UserCubit, UserState>(
        'invokes getUser with correct Data',
        build: () => mockHydratedStorage(() => UserCubit(userRepository)),
        seed: () => UserState(
          status: UserStatus.success,
          user: User(
            surname: surname,
            name: name,
            patronymic: patronymic,
            username: username,
            role: user.role
          ),
        ),
        verify: (_) {
          verifyNever(() => userRepository.getUser(username: username, password: password));
        },
      );

      blocTest<UserCubit, UserState>(
        'emits nothing when exception is thrown',
        setUp: () {
          when(
                () => userRepository.getUser(username: any(),password:any()),
          ).thenThrow(Exception('oops'));
        },
        build: () => mockHydratedStorage(() => UserCubit(userRepository)),
        seed: () => UserState(
          status: UserStatus.success,
          user: User(
            surname: surname,
            name: name,
            patronymic: patronymic,
            username: username,
            role: user.role
          ),
        ),
        expect: () => <UserState>[],
      );


    });
  });
}
//Разобраться почему нет .toJson в cubit.g
