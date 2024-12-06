class BaseUrl {
  static const String _baseUrl = 'http://dpkrm.pythonanywhere.com';

  // A function to generate the full URL dynamically
  static String getFullUrl(String endpoint) {
    return '$_baseUrl$endpoint';
  }

  static final String login = getFullUrl("/accounts/login/");
  static final String logout = getFullUrl("/accounts/logout/");
  static final String changePassword = getFullUrl("/accounts/change_password/");
  static final String signup = getFullUrl("/accounts/register/");
  static final String userprofile = getFullUrl("/accounts/profile/");
}
