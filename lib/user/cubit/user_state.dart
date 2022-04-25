part of 'user_cubit.dart';

enum UserStatus { initial, loading, success, failure }
enum AuthenticationStatus { authenticated, unauthenticated }

extension AuthenticationStatusX on AuthenticationStatus {
  bool get isAuthenticated => this == AuthenticationStatus.authenticated;

  bool get isUnauthenticated => this == AuthenticationStatus.unauthenticated;
}

extension UserStatusX on UserStatus {
  bool get isInitial => this == UserStatus.initial;

  bool get isLoading => this == UserStatus.loading;

  bool get isSuccess => this == UserStatus.success;

  bool get isFailure => this == UserStatus.failure;
}

@JsonSerializable()
class UserState extends Equatable {
  UserState(
      {this.status = UserStatus.initial,
      User? user,
      this.authenticationStatus = AuthenticationStatus.unauthenticated})
      : user = user ?? User.empty;

  //для сохранения состояния
  factory UserState.fromJson(Map<String, dynamic> json) =>
      _$UserStateFromJson(json);

  Map<String, dynamic> toJson() => _$UserStateToJson(this);

  final UserStatus status;
  final User user;
  final AuthenticationStatus authenticationStatus;

  UserState copyWith(
      {UserStatus? status,
      User? user,
      AuthenticationStatus? authenticationStatus}) {
    return UserState(
        status: status ?? this.status,
        user: user ?? this.user,
        authenticationStatus:
            authenticationStatus ?? this.authenticationStatus);
  }

  @override
  List<Object?> get props => [status, user, authenticationStatus];
}
