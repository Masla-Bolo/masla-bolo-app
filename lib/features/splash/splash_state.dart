class SplashState {
  bool isLoaded;
  SplashState({this.isLoaded = false});

  factory SplashState.empty() => SplashState();

  copyWith({bool? isLoaded}) => SplashState(
        isLoaded: isLoaded ?? this.isLoaded,
      );
}
