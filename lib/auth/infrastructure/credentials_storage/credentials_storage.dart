import 'package:oauth2/oauth2.dart';

// Keeping this class Abstract as we will be having separate implementations for Mobile and Web
abstract class CredentialsStorage {
  Future<void> save(Credentials credentials);

  Future<Credentials?> read();

  Future<void> clear();
}
