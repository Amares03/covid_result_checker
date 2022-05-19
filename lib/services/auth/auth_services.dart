import 'package:covid_result_checker/services/auth/auth_provider.dart';
import 'package:covid_result_checker/services/auth/auth_user.dart';

class AuthServices implements AuthProvider {
  final AuthProvider provider;

  AuthServices(this.provider);

  @override
  AuthUser? get currentUser {
    return provider.currentUser;
  }

  @override
  Future<void> initialize() {
    return provider.initialize();
  }

  @override
  Future<AuthUser> login({required String email, required String password}) {
    return provider.login(email: email, password: password);
  }

  @override
  Future<void> logout() {
    return provider.logout();
  }

  @override
  Future<AuthUser> register({required String email, required String password}) {
    return provider.register(email: email, password: password);
  }

  @override
  Future<void> sendEmailVerification() {
    return provider.sendEmailVerification();
  }
}
