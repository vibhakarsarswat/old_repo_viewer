import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:oauth2/oauth2.dart';
import 'package:repo_viewer/auth/infrastructure/credentials_storage/credentials_storage.dart';

class SecureCredentialsStorage implements CredentialsStorage {
  final FlutterSecureStorage _storage;

  SecureCredentialsStorage(this._storage);

  // declaring a private variable to be used to store key values
  static const _key = 'oauth2_credentials';

  // declaring a nullable variable to store 'cached credentials'
  Credentials? _cachedCredentials;

  @override
  Future<void> save(Credentials credentials) {
    _cachedCredentials = credentials;
    return _storage.write(key: _key, value: credentials.toJson());
  }

  @override
  Future<Credentials?> read() async {
    if (_cachedCredentials != null) {
      return _cachedCredentials;
    }

    final json = await _storage.read(key: _key);
    if (json == null) {
      return null;
    }

    try {
      return _cachedCredentials = Credentials.fromJson(json);
    } on FormatException {
      return null;
    }
  }

  @override
  Future<void> clear() {
    // TODO: implement clear
    throw UnimplementedError();
  }
}

/*Notes
**********************
  1. In 'save' method, for '_storage.write' we have used 'credentials.toJson()' for 'value' param,
  as it needs to be a String, and 'Credentials' has an inbuilt 'toJson()' method available.
*/
