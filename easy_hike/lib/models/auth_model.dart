import 'package:easy_hike/services/auth.dart';
import 'package:scoped_model/scoped_model.dart';
import '../service_locator.dart';

class AuthModel extends Model {
  final Auth _authService = locator<Auth>();

  void login(String email, String password) {
    _authService.signIn(email: email, password: password);
  }

  void loginWithGoogle() {
    _authService.signInWithGoogle();
  }

  void createAccount(String email, String password) {
    _authService.createAccount(email: email, password: password);
  }

  void signOut() {
    _authService.signOut();
  }
}
