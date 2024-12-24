class BaseUrl {
  static const String _baseUrl = 'http://dpkrm.pythonanywhere.com';

  // A function to generate the full URL dynamically
  static String getFullUrl(String endpoint) {
    return '$_baseUrl$endpoint';
  }

// Auth
  static final String login = getFullUrl("/accounts/login/");
  static final String logout = getFullUrl("/accounts/logout/");
  static final String changePassword = getFullUrl("/accounts/change_password/");
  static final String signup = getFullUrl("/accounts/register/");
  static final String recommendation = getFullUrl("/home/recommendation/");


// Profile 
  static final String userprofile = getFullUrl("/accounts/profile/");
  static final String editUserProfile = getFullUrl("/accounts/profile/edit/");

  // check username and email
  static final String username = getFullUrl("/accounts/check/username/");
  static final String email = getFullUrl("/accounts/check/email/");



}
