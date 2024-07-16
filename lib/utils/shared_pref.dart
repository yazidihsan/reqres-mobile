import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefKey {
  static const String _accessToken = 'ACCESS_TOKEN';
  static const String _email = 'EMAIL';
  static const String _user = 'USERNAME';
  static const String _password = 'PASSWORD';
}

class SharedPref {
  final SharedPreferences sharedPreferences;

  SharedPref({required this.sharedPreferences});

  Future<bool> setAccessToken(String accessToken) async {
    bool accessTokenSaved = await sharedPreferences.setString(
        SharedPrefKey._accessToken, accessToken);

    return accessTokenSaved;
  }

  String? getAccessToken() {
    String? accessToken =
        sharedPreferences.getString(SharedPrefKey._accessToken);

    return accessToken;
  }

  Future<bool> clearAccessToken() async {
    bool accessTokenRemoved =
        await sharedPreferences.remove(SharedPrefKey._accessToken);

    return accessTokenRemoved;
  }

  Future<bool> setEmail(String email) async {
    bool emailSaved =
        await sharedPreferences.setString(SharedPrefKey._email, email);

    return emailSaved;
  }

  String? getEmail() {
    String? email = sharedPreferences.getString(SharedPrefKey._email);

    return email;
  }

  Future<bool> clearEmail() async {
    bool emailRemoved = await sharedPreferences.remove(SharedPrefKey._email);

    return emailRemoved;
  }

  Future<bool> setUsername(String username) async {
    bool usernameSaved =
        await sharedPreferences.setString(SharedPrefKey._user, username);

    return usernameSaved;
  }

  String? getUsername() {
    String? username = sharedPreferences.getString(SharedPrefKey._user);

    return username;
  }

  Future<bool> clearUsername() async {
    bool usernameRemoved = await sharedPreferences.remove(SharedPrefKey._user);

    return usernameRemoved;
  }

  Future<bool> setPassword(String password) async {
    bool passwordSaved =
        await sharedPreferences.setString(SharedPrefKey._password, password);

    return passwordSaved;
  }

  String? getPassword() {
    String? password = sharedPreferences.getString(SharedPrefKey._password);

    return password;
  }

  Future<bool> clearPassword() async {
    bool passwordRemoved =
        await sharedPreferences.remove(SharedPrefKey._password);

    return passwordRemoved;
  }
}
