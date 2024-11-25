class ApiConstants {
  // Base API URL
  static const String baseUrl = 'http://10.3.202.117:3000';
  // 'http://192.168.15.107:3000';

  // API Endpoints
  static const String apiLogin = '/users/login';
  static const String apiRegister = '/users/register';
  static const String apiUserProfile =
      '/users'; // Can be `/users/{id}` in the future
  static const String apiUpdateProfile =
      '/users/update/'; // Append `userId` to this endpoint
  static const String apiResetPassword = '/users/reset-password';
  static const String apiTransactions =
      '/transactions'; // Example endpoint for transactions
}
