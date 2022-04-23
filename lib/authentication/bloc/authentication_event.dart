// part of 'authentication_bloc.dart';
//
// //объекты этого класса будут входными данными для AuthBloc,
// // будут обрабатываться и использоваться для создания новых объектов AuthState
// //описываем на какие события необходимо реагировать
// abstract class AuthenticationEvent extends Equatable {
//   const AuthenticationEvent();
//
//   @override
//   List<Object> get props => [];
// }
// ///отправляет событие изменение статуса в bloc
// class AuthenticationStatusChanged extends AuthenticationEvent{
//   const AuthenticationStatusChanged(this.status);
//
//   final AuthenticationStatus status;
//
//   @override
//   List<Object> get props => [status];
//
//
// }
// ///событие на выход из приложения (logout)
// class AuthenticationLogoutRequested extends AuthenticationEvent {}