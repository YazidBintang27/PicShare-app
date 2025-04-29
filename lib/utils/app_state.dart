sealed class AppState {}

class AppNoneState extends AppState {}

class AppLoadingState extends AppState {}

class AppErrorState extends AppState {
  final String error;

  AppErrorState({required this.error});
}

class AppLoadedState extends AppState {
  final dynamic response;

  AppLoadedState({required this.response});
}
