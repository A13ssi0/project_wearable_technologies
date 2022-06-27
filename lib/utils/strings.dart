class Strings {
  // Fitbit Client ID (replace XXX with your client ID)
  static const String fitbitClientID = '238KZ8';

  // Fitbit Client Secret (replace XXX with your client secret)
  static const String fitbitClientSecret = '7c95c7568d9af431d1dc9a695644a60e';

  /// Auth Uri (replace XXX with your Uri)
  static const String fitbitRedirectUri = 'projectgroup12://fitbit/auth';

  /// Callback scheme (replace XXX with your callback scheme)
  static const String fitbitCallbackScheme = 'projectgroup12';

  static String userId = '';

  static void writeUserId(String id) => userId = id;
  // Loginpage
  static const String LoginUserName = '209';
  static const String LoginPassword = '803';
}//Strings