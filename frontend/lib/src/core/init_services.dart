import 'package:socialearn/src/core/repo/auth_repo.dart';

class InitService {
  static final InitService _instance = InitService._();
  factory InitService() => _instance;
  InitService._();

  init() async {
    authRepo.navigateUser();
  }
}
