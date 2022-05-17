part of 'authentication_bloc.dart';

class AuthenticationState extends Equatable {
  const AuthenticationState._({
    this.user = User.empty,
    this.status = AuthenticationStatus.unauthenticated,
    this.dummy = "dummy",
  });

  const AuthenticationState.unknown() : this._();

  const AuthenticationState.authenticated(User user, String dummy)
      : this._(status: AuthenticationStatus.authenticated, user: user);

  const AuthenticationState.unauthenticated()
      : this._(status: AuthenticationStatus.unauthenticated);

  final User user;
  final AuthenticationStatus status;
  final String dummy;
  @override
  List<Object> get props => [user, status, dummy];

  AuthenticationState copyWith({
    User? ourUser,
    AuthenticationStatus? status,
    String? ourDummy,
  }) {
    print("our $ourDummy");
    return AuthenticationState.authenticated(
      ourUser ?? user,
      ourDummy ?? dummy,
    );
  }
}
