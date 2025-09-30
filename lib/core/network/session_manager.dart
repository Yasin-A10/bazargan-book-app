import 'package:shared_preferences/shared_preferences.dart';

class SessionManager {
  //! for singleton
  SessionManager._privateConstructor();
  static final SessionManager instance = SessionManager._privateConstructor();

  SharedPreferences? _preferences;

  static const _keyAccess = 'access';
  static const _keyRefresh = 'refresh';
  static const _keyRole = 'role';

  // static const String accessToken =
  //     "eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJ0b2tlbl90eXBlIjoiYWNjZXNzIiwiZXhwIjoxNzU4MzYzNDA2LCJpYXQiOjE3NTcxNTM4MDYsImp0aSI6IjRlNDY4ZTVkZmVkMTRjNWQ4NjBhOWJjYzVkYmM5ZDg5IiwidXNlcl9pZCI6IjdhMGU0ODhjLTU0NWQtNGEzNy04NTdiLTI5ZTBlN2M4NjY5YSJ9.gCCD9EDLlcqIzRKD4tuQlKYma9QUfoIEpMZ6Du6jgAI";
  // static const String refreshToken =
  //     "eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTc3MjcwNTgwNiwiaWF0IjoxNzU3MTUzODA2LCJqdGkiOiIxMjY3ZWE1YzEzOGY0MTRjYmYxOTAyZmRiNmI0YzRhNiIsInVzZXJfaWQiOiI3YTBlNDg4Yy01NDVkLTRhMzctODU3Yi0yOWUwZTdjODY2OWEifQ.clGKyfhkWI98NzNIq8dgd0jEa4MBX7fjK32QNSve2l0";
  // static const String userId = "7a0e488c-545d-4a37-857b-29e0e7c8669a";

  //! for init
  Future<void> init() async {
    _preferences = await SharedPreferences.getInstance();
  }

  //! for save session
  Future<void> saveSession({
    required String access,
    required String refresh,
    required String role,
  }) async {
    if (_preferences == null) await init();

    await _preferences!.setString(_keyAccess, access);
    await _preferences!.setString(_keyRefresh, refresh);
    await _preferences!.setString(_keyRole, role);
  }

  //! for get access token
  String? get access => _preferences?.getString(_keyAccess);

  //! for get refresh token
  String? get refresh => _preferences?.getString(_keyRefresh);

  //! for get role
  String? get role => _preferences?.getString(_keyRole);

  //! for check if user is logged in
  bool isLoggedIn() {
    return _preferences?.getString(_keyAccess) != null &&
        _preferences?.getString(_keyRefresh) != null;
  }

  //! for logout
  // Future<void> clearSession() async {
  //   await _preferences?.clear();
  // }
  Future<void> clearSession() async {
    await _preferences?.remove(_keyAccess);
    await _preferences?.remove(_keyRefresh);
    await _preferences?.remove(_keyRole);
  }
}
