part of 'app_cubit.dart';
@immutable
abstract class AppState {}
class AppInitial extends AppState {}
class AppLoadingResponse extends AppState {}
class AppSuccessResponse extends AppState {}
class AppFailedResponse extends AppState {}
class AppSendMessage extends AppState {}

