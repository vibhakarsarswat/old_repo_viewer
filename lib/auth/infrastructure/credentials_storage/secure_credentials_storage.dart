import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:oauth2/oauth2.dart';
import 'package:repo_viewer/auth/infrastructure/credentials_storage/credentials_storage.dart';

class SecureCredentialsStorage implements CredentialsStorage {
  final FlutterSecureStorage _storage;

  SecureCredentialsStorage(this._storage);

  // declaring a private key
  static const _key = 'oauth2_credentials';

  @override
  Future<void> save(Credentials credentials) {
    return _storage.write(key: _key, value: credentials.toJson());
  }

  @override
  Future<void> clear() {
    // TODO: implement clear
    throw UnimplementedError();
  }

  @override
  Future<Credentials?> read() {
    // TODO: implement read
    throw UnimplementedError();
  }
}

/*Notes
**********************
  1. In 'save' method, for '_storage.write' we have used 'credentials.toJson()' for 'value' param,
  as it needs to be a String, and 'Credentials' has an inbuilt 'toJson()' method available.
*/
