class Validation {
  // Helper method for validating the email
  String? validateUser(String email) {
    if (email.isEmpty) {
      return 'Please enter your Username';
    }
    return null;
  }

  // Helper method for validating the email
  String? validateEmail(String email) {
    if (email.isEmpty) {
      return 'Please enter your email';
    } else if (!RegExp(r"^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$")
        .hasMatch(email)) {
      return 'Please enter a valid email';
    }
    return null;
  }

  // Helper method for validating the password
  String? validatePassword(String password) {
    if (password.isEmpty) {
      return 'Please enter your password';
    } else if (password.length < 5) {
      return 'Password must be at least 6 characters';
    }
    return null;
  }
}
