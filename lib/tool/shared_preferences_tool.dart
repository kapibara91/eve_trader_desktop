import 'package:shared_preferences/shared_preferences.dart';

late SharedPreferences _prefs;
const _codeVerifierKey = 'codeVerifierKey';

setup() async {
  _prefs = await SharedPreferences.getInstance();
}

saveCodeVerifier(String codeVerifier) async {
  await _prefs.setString(_codeVerifierKey, codeVerifier);
}

String? getCodeVerifier() {
  return _prefs.getString(_codeVerifierKey);
}