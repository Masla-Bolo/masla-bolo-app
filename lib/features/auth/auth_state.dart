class AuthState {
  String email;
  String password;
  bool isLoading;
  AuthState({
    this.isLoading = false,
    required this.email,
    required this.password,
  });

  AuthState copyWith({String? email, String? password, bool? isLoading}) =>
      AuthState(
          email: email ?? this.email,
          password: password ?? this.password,
          isLoading: isLoading ?? this.isLoading);

  factory AuthState.initial() => AuthState(email: '', password: '');
}
