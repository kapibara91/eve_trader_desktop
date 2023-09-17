import 'dart:async';
import 'dart:math';

import 'package:app_links/app_links.dart';
import 'package:dart_jsonwebtoken/dart_jsonwebtoken.dart';
import 'package:eve_trader_desktop/tool/shared_preferences_tool.dart'
    as shared_pre;
import 'package:http/http.dart' as http;
import 'package:oauth2/oauth2.dart' as oauth2;
import 'package:url_launcher/url_launcher.dart';

const String _charset =
    'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789-._~';

String _createCodeVerifier() {
  return List.generate(
      128, (i) => _charset[Random.secure().nextInt(_charset.length)]).join();
}

const _scopes = [
  'publicData',
  'esi-skills.read_skillqueue.v1',
  'esi-skills.read_skills.v1',
  'esi-characters.read_blueprints.v1',
  'esi-markets.read_character_orders.v1'
];

final _authorizationEndpoint =
    Uri.parse('https://login.eveonline.com/v2/oauth/authorize');
final _tokenEndpoint = Uri.parse('https://login.eveonline.com/v2/oauth/token');
const _clientId = '173497b442c64951a341cebc81c5ff48';
const _eveAuthCallbackUrl = 'eveauth-app-trader-desktop://authcallback';
final _appLinks = AppLinks();
StreamSubscription<Uri>? _listen;

void toAuth() {
  final codeVerifier = _createCodeVerifier();
  shared_pre.saveCodeVerifier(codeVerifier);

  final grant = oauth2.AuthorizationCodeGrant(
      _clientId, _authorizationEndpoint, _tokenEndpoint,
      httpClient: http.Client(), codeVerifier: codeVerifier);
  final callbackUrl = Uri.parse(_eveAuthCallbackUrl);
  var authorizationUrl = grant.getAuthorizationUrl(callbackUrl,
      scopes: _scopes, state: 'xyzABC123');
  launchUrl(authorizationUrl);

  _listen ??= _appLinks.allUriLinkStream.listen((uri) async {
    if (_eveAuthCallbackUrl.startsWith(uri.scheme)) {
      final client =
      await grant.handleAuthorizationResponse(uri.queryParameters);
      String accessToken = client.credentials.accessToken;
      String? refreshToken = client.credentials.refreshToken;
      print('accessToken: $accessToken\nrefreshToken: $refreshToken');
      final jwt = JWT.decode(accessToken);
      print('Payload: ${jwt.payload}');
    }
  });
}
