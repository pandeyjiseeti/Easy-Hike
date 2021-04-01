import 'package:easy_hike/services/auth.dart';
import 'package:scoped_model/scoped_model.dart';
import '../service_locator.dart';

class AuthModel extends Model {
  final Auth _authService = locator<Auth>();

  Future<String> login(String email, String password) async {
    return _authService.signIn(email: email, password: password);
  }

  Future<String> loginWithGoogle() async {
    return _authService.signInWithGoogle();
  }

  Future<String> createAccount(String email, String password) async {
    return _authService.createAccount(email: email, password: password);
  }

  Future<String> signOut() async {
    return _authService.signOut();
  }
}
