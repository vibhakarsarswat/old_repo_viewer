import 'package:flutter/services.dart';
import 'package:oauth2/oauth2.dart';
import 'package:repo_viewer/auth/infrastructure/credentials_storage/credentials_storage.dart';

class GithubAuthenticator {
  final CredentialsStorage _credentialsStorage;

  GithubAuthenticator(this._credentialsStorage);

  // Once User is Authenticated, below method will be used to retrieve the 'Access Token'
  Future<Credentials?> getSignedInCredentials() async {
    try {
      final storedCredentials = await _credentialsStorage.read();
      if (storedCredentials != null) {
        if (storedCredentials.canRefresh && storedCredentials.isExpired) {
          // TODO: refresh token
        }
      }
      return storedCredentials;
    } on PlatformException {
      return null;
    }
  }

  // Helper method to check is the User is SignedIn or not
  Future<bool> isSignedIn() => getSignedInCredentials().then((credentials) => credentials != null);
}
