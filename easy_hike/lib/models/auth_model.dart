import 'package:easy_hike/services/auth.dart';
import 'package:easy_hike/services/database.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:scoped_model/scoped_model.dart';
import '../service_locator.dart';

class AuthModel extends Model {
  final Auth _authService = locator<Auth>();
  final DatabaseHelper _databaseService = locator<DatabaseHelper>();

  Stream<User> get user => _authService.user;

  Future<String> login(String email, String password) async {
    return _authService.signIn(email: email, password: password);
  }

  Future<User> loginWithGoogle() async {
    return _authService.signInWithGoogle();
  }

  Future<User> createAccount(String email, String password) async {
    return _authService.createAccount(email: email, password: password);
  }

  Future<String> signOut() async {
    return _authService.signOut();
  }

  Future<void> addJobUser(User user, String fullName) async {
    return _databaseService.addUser(user: user, fullName: fullName);
  }
}
