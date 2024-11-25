class AppStrings {
  // App Titles
  static const String appTitle = 'Your App Name';
  static const String profileTitle = 'User Profile';
  static const String loginTitle = 'Login';
  static const String registerTitle = 'Register';
  static const String homeTitle = 'Home';

  // Button Labels
  static const String loginButtonLabel = 'Нэвтрэх';
  static const String registerButtonLabel = 'Бүртгүүлэх';
  static const String saveButtonLabel = 'Save';
  static const String cancelButtonLabel = 'Cancel';
  static const String onboardingButtonLabel = 'Эхлэх';

  // Form Validation Messages
  static const String emailRequired = 'Имэйлээ оруулна уу';
  static const String passwordRequired = 'Нууц үгээ оруулна уу';
  static const String invalidEmail = 'Имэйл хаяг буруу байна';
  static const String passwordLength =
      'Нууц үг хамгийн багадаа 6 тэмдэгтэй байх ёстой';

  // Error Messages
  static const String generalError = 'Something went wrong. Please try again';
  static const String loginError =
      'Алдаа гарлаа. Та имэйл болон нууц үгээ шалгана уу';
  static const String updateProfileError = 'Failed to update profile';
  static const String fetchUserError = 'Failed to fetch user data';

  // Success Messages
  static const String loginSuccess = 'Амжилттай нэвтэрлээ!';
  static const String profileUpdatedSuccess = 'Profile updated successfully!';
  static const String passwordResetEmailSent =
      'Password reset email has been sent';

  // Login-specific messages
  static const String loginTitleMessage = 'Тавтай морилно уу!';
  static const String rememberMeLabel = 'Remember Me';
  static const String registerPrompt =
      'Don\'t have an account?'; // Added string
  static const String forgotPasswordLabel = 'Нууц үгээ мартсан уу?';
}
