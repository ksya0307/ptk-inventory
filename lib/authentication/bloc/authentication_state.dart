// part of 'authentication_bloc.dart';
//
//
// enum AuthenticationStatus { authenticated, unauthenticated }
//
// //объекты класса являются выходными данными нашего bloc и будут использованы presentation layer
// class AuthenticationState extends Equatable {
//   //._ - обозначает именнованный конструктор и приватность конструктора
//   const AuthenticationState._({this.user = User.empty,
//     this.status = AuthenticationStatus.unauthenticated,
//   });
//
//   final AuthenticationStatus status;
//
//   final User user;
//
//   //два именнованных(named) конструктора
//
//   ///состояние, указывающее на то, что пользователь в данный момент аутентифицирован
//   const AuthenticationState.authenticated(User user) :
//         this._(status: AuthenticationStatus.authenticated, user: user);
//
//   ///состояние, указывающее на то, что пользователь в данный момент не аутентифицирован
//   const AuthenticationState.unauthenticated()
//       : this._(status: AuthenticationStatus.unauthenticated);
//
//   @override
//   List<Object> get props => [status, user];
// }
