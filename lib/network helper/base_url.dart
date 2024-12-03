class BaseUrl {
  static const String _baseUrl = '';

  // A function to generate the full URL dynamically
  static String getFullUrl(String endpoint) {
    return '$_baseUrl$endpoint';
  }

  static final String login = getFullUrl("/endpoint");
  static final String signup = getFullUrl("/endpoint");
}
