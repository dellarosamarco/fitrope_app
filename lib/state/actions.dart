import 'package:fitrope_app/types/fitropeUser.dart';

class SetUserAction {
  final FitropeUser user;

  SetUserAction(this.user);
}

class StartLoadingAction {
  StartLoadingAction();
}

class FinishLoadingAction {
  FinishLoadingAction();
}