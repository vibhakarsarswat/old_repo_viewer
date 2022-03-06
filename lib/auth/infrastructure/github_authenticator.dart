import 'package:flutter/services.dart';
import 'package:oauth2/oauth2.dart';
import 'package:repo_viewer/auth/infrastructure/credentials_storage/credentials_storage.dart';

class GithubAuthenticator {
  final CredentialsStorage _credentialsStorage;

  GithubAuthenticator(this._credentialsStorage);

  static const clientId = '';
  static const clientSecret = '';
  static const scopes = ['read:user', 'repo'];
  static final authorizationEndpoint = Uri.parse('https://github.com/login/oauth/authorize');
  static final tokenEndpoint = Uri.parse('https://github.com/login/oauth/access_token');
  // 'redirectEndpoint' is required while implementing the Web version
  static final redirectEndpoint = Uri.parse('https://localhost:3000/callback');

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

  AuthorizationCodeGrant createGrant() {
    return AuthorizationCodeGrant(clientId, authorizationEndpoint, tokenEndpoint, secret: clientSecret);
  }

  Uri getAuthorizationUrl(AuthorizationCodeGrant grant) {
    return grant.getAuthorizationUrl(redirectEndpoint, scopes: scopes);
  }
}

/*
While Using OAuth2 package, we need to define/configure the following to get the 'access_token' i.e.
1. authorizationEndpoint
2. tokenEndpoint
3. redirectEndpoint (applicable for Web only): if a use is authorised, s/he will be sent to 'redirectUri' (along with a query param)
4. clientId: mentioned in the Github developer settings for your repo
5. clientSecrets:	mentioned (or generate) in the Github developer settings for your repo (below 'clientId')
6. scopes: mentioned under 'Personal Access Token' for your repository

Note:
1. OAuth2 requires URIs, so convert Endpoint Strings to URIs by using 'Uri.parse('EndpointUrl')'
2. redirectEndpoint and 'Authorization callback URL' for your repo (mentioned in the Github developer settings) are same things
 */
