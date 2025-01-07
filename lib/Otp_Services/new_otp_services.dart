// ignore_for_file: avoid_print, constant_identifier_names

import 'dart:async';
import 'dart:io';

import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

enum UserRole {
  SUPPORT(1),
  ADMIN(2),
  ADMIN_VENDOR_PROVIDER(3),
  VENDOR(4),
  CUSTOMER(5);

  final int value;
  const UserRole(this.value);
}

class OtpService {
  static const String baseUrl =
      'https://5075-2405-201-6023-985b-10e5-5cfc-67a-dc14.ngrok-free.app';

  // Method to send OTP for user login
  Future<Map<String, dynamic>> sendCustomerOtp(String mobileNumber) async {
    try {
      final requestBody = json.encode({'mobileNumber': mobileNumber});

      final response = await http.post(
        Uri.parse('$baseUrl/api/v1/otp/send-otp'),
        headers: {'Content-Type': 'application/json'},
        body: requestBody,
      );

      final responseBody = json.decode(response.body);
      print(responseBody);

      if (response.statusCode == 200) {
        return {
          'success': true,
          'message': responseBody['message'],
          'otp': responseBody['data']
        };
      } else {
        return {
          'success': false,
          'message': responseBody['message'] ?? 'Failed to send OTP'
        };
      }
    } catch (e) {
      print('Error sending OTP: $e');
      return {'success': false, 'message': 'Network error occurred'};
    }
  }

  // Method to verify OTP for login
  Future<Map<String, dynamic>> verifyOtp(
      {required String mobileNumber,
      required UserRole role,
      required String otpEntered}) async {
    try {
      final requestBody = json.encode({
        'mobileNumber': mobileNumber,
        'role': role.value,
        'otpEntered': otpEntered
      });

      final response = await http.post(
        Uri.parse('$baseUrl/api/v1/otp/verify-otp'),
        headers: {'Content-Type': 'application/json'},
        body: requestBody,
      );

      final responseBody = json.decode(response.body);
      print(responseBody);

      if (response.statusCode == 200) {
        // Save user token and details
        await _saveUserSession(
          token: responseBody['token'],
          userDetails: responseBody['data']?['userDetails'],
        );

        return {
          'success': true,
          'message': responseBody['message'],
          'userDetails': responseBody['data']?['userDetails'],
          'token': responseBody['token']
        };
      } else {
        return {
          'success': false,
          'message': responseBody['message'] ?? 'OTP verification failed'
        };
      }
    } catch (e) {
      print('Error verifying OTP: $e');
      return {'success': false, 'message': 'Network error occurred'};
    }
  }

  // Method for admin signup OTP
  Future<Map<String, dynamic>> sendAdminSignupOtp(String mobileNumber) async {
    try {
      final requestBody = json.encode(
          {'mobileNumber': mobileNumber, 'role': UserRole.SUPPORT.value});

      final response = await http.post(
        Uri.parse('$baseUrl/api/v1//otp/admin-signup'),
        headers: {'Content-Type': 'application/json'},
        body: requestBody,
      );

      final responseBody = json.decode(response.body);

      if (response.statusCode == 200) {
        return {
          'success': true,
          'message': responseBody['message'],
          'otp': responseBody['data']
        };
      } else {
        return {
          'success': false,
          'message':
              responseBody['message'] ?? 'Failed to send admin signup OTP'
        };
      }
    } catch (e) {
      print('Error sending admin signup OTP: $e');
      return {'success': false, 'message': 'Network error occurred'};
    }
  }

  // Method for vendor signup OTP
  Future<Map<String, dynamic>> sendVendorSignupOtp(String mobileNumber) async {
    try {
      // Validate mobile number before making API call
      if (mobileNumber.isEmpty ||
          !RegExp(r'^[0-9]{10}$').hasMatch(mobileNumber)) {
        return {'success': false, 'message': 'Invalid mobile number'};
      }
      // print(requestBody);
      final requestBody = json.encode({'mobileNumber': mobileNumber});

      final response = await http.post(
        Uri.parse('$baseUrl/api/v1/otp/vendor-signup'),
        headers: {'Content-Type': 'application/json'},
        body: requestBody,
      );

      final responseBody = json.decode(response.body);

      print(responseBody);
      // Handle 400 Bad Request specifically
      if (response.statusCode == 400) {
        return {
          'success': false,
          'message': responseBody['message'] ?? 'Invalid mobile number'
        };
      }

      if (response.statusCode == 200) {
        return {
          'success': true,
          'message': responseBody['message'],
          'otp': responseBody['data']
        };
      } else {
        return {
          'success': false,
          'message':
              responseBody['message'] ?? 'Failed to send vendor signup OTP'
        };
      }
    } catch (e) {
      print('Error sending vendor signup OTP: $e');
      return {'success': false, 'message': 'Network error occurred'};
    }
  }

  // Method for login with password
  Future<Map<String, dynamic>> loginWithPassword(
      {required String mobileNumber,
      required String password,
      required UserRole role}) async {
    try {
      final requestBody = json.encode({
        'mobileNumber': mobileNumber,
        'password': password,
        'role': role.value
      });

      final response = await http.post(
        Uri.parse('$baseUrl/api/v1/account/login-with-password'),
        headers: {'Content-Type': 'application/json'},
        body: requestBody,
      );

      final responseBody = json.decode(response.body);

      if (response.statusCode == 200) {
        // Save user token and details
        await _saveUserSession(
          token: responseBody['token'],
          userDetails: responseBody['data']?['userDetails'],
        );

        return {'success': true, 'message': responseBody['message']};
      } else {
        return {
          'success': false,
          'message': responseBody['message'] ?? 'Login failed'
        };
      }
    } catch (e) {
      print('Error logging in with password: $e');
      return {'success': false, 'message': 'Network error occurred'};
    }
  }

  // New method: Logout
  Future<Map<String, dynamic>> logout() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final token = prefs.getString('user_token');

      final response = await http.post(
        Uri.parse('$baseUrl/api/v1/customer/logout'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token'
        },
      );

      if (response.statusCode == 200) {
        // Clear local storage
        await _clearUserSession();
        return {'success': true, 'message': 'Logged out successfully'};
      } else {
        return {
          'success': false,
          'message': json.decode(response.body)['message'] ?? 'Logout failed'
        };
      }
    } catch (e) {
      print('Error logging out: $e');
      return {'success': false, 'message': 'Network error occurred'};
    }
  }

  // New method: Send Password Reset OTP
  Future<Map<String, dynamic>> sendPasswordResetOtp(
      {required String mobileNumber, required UserRole role}) async {
    try {
      final requestBody =
          json.encode({'mobileNumber': mobileNumber, 'role': role.value});

      final response = await http.post(
        Uri.parse('$baseUrl/api/v1/otp/password-reset'),
        headers: {'Content-Type': 'application/json'},
        body: requestBody,
      );

      final responseBody = json.decode(response.body);

      if (response.statusCode == 200) {
        return {
          'success': true,
          'message': responseBody['message'],
          'otp': responseBody['data']
        };
      } else {
        return {
          'success': false,
          'message':
              responseBody['message'] ?? 'Failed to send password reset OTP'
        };
      }
    } catch (e) {
      print('Error sending password reset OTP: $e');
      return {'success': false, 'message': 'Network error occurred'};
    }
  }

  // New method: Verify Password Reset OTP
  Future<Map<String, dynamic>> verifyPasswordResetOtp({
    required String mobileNumber,
    required UserRole role,
    required String otpEntered,
    required String newPassword,
  }) async {
    try {
      final requestBody = json.encode({
        'mobileNumber': mobileNumber,
        'role': role.value,
        'otpEntered': otpEntered,
        'newPassword': newPassword
      });

      final response = await http.post(
        Uri.parse('$baseUrl/api/v1/otp/verify-password-reset'),
        headers: {'Content-Type': 'application/json'},
        body: requestBody,
      );

      final responseBody = json.decode(response.body);

      if (response.statusCode == 200) {
        return {'success': true, 'message': responseBody['message']};
      } else {
        return {
          'success': false,
          'message': responseBody['message'] ?? 'Password reset failed'
        };
      }
    } catch (e) {
      print('Error verifying password reset OTP: $e');
      return {'success': false, 'message': 'Network error occurred'};
    }
  }

  // Utility method to save user session
  Future<void> _saveUserSession({
    required String token,
    required Map<String, dynamic>? userDetails,
    String? serviceProviderId,
  }) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('user_token', token);
    print(token);
    if (serviceProviderId != null) {
      await prefs.setString('service_provider_id', serviceProviderId);

      print(serviceProviderId);
    }
    if (userDetails != null) {
      await prefs.setString('user_details', json.encode(userDetails));
    }
  }

  Future<String?> getUserToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('user_token');
  }

  Future<String?> getServiceProviderId() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('serviceId');
  }

  Future<Map<String, dynamic>?> getUserDetails() async {
    final prefs = await SharedPreferences.getInstance();
    final userDetailsString = prefs.getString('user_details');
    if (userDetailsString != null) {
      return json.decode(userDetailsString);
    }
    return null;
  }

  Future<Map<String, dynamic>> submitVendorProfile({
    required String name,
    required String email,
    required String planName,
    required Map<String, String> socialMediaUrls,
    required String token,
  }) async {
    try {
      final token = await getUserToken();
      final serviceProviderId = await getServiceProviderId();

      if (token == null) {
        return {'success': false, 'message': 'Authentication token not found'};
      }

      if (serviceProviderId == null) {
        return {'success': false, 'message': 'Service provider ID not found'};
      }

      print('Token: $token');
      print('Service Provider ID: $serviceProviderId');

      final requestBody = json.encode({
        'name': name,
        'email': email,
        'planName': planName,
        'socialMediaUrls': socialMediaUrls,
      });

      final response = await http.post(
        Uri.parse(
            '$baseUrl/api/v1/vendor-submission/submit/$serviceProviderId'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
        body: requestBody,
      );

      final responseBody = json.decode(response.body);
      print(responseBody);

      if (response.statusCode == HttpStatus.ok) {
        // Update stored user details
        final userDetails = await getUserDetails();
        if (userDetails != null) {
          print(userDetails);
          userDetails['name'] = name;
          userDetails['email'] = email;
          userDetails['planName'] = planName;
          await _saveUserSession(
            token: token,
            userDetails: userDetails,
            serviceProviderId: serviceProviderId,
          );
        }

        return {
          'success': true,
          'message': responseBody['message'] ?? 'Profile submitted successfully'
        };
      } else {
        return {
          'success': false,
          'message': responseBody['message'] ?? 'Failed to submit profile'
        };
      }
    } catch (e) {
      print('Error submitting vendor profile: $e');
      return {'success': false, 'message': 'Network error occurred'};
    }
  }

  // Utility method to clear user session
  Future<void> _clearUserSession() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('user_token');
    await prefs.remove('user_details');
  }

  // Utility method to show error dialog
  void showErrorDialog(BuildContext context, String message) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Error'),
        content: Text(message),
        actions: <Widget>[
          TextButton(
            child: const Text('Okay'),
            onPressed: () {
              Navigator.of(ctx).pop();
            },
          )
        ],
      ),
    );
  }

  // New method: Refresh Token
  Future<Map<String, dynamic>> refreshToken() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final token = prefs.getString('user_token');

      final response = await http.post(
        Uri.parse('$baseUrl/api/v1/account/refresh-token'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token'
        },
      );

      final responseBody = json.decode(response.body);

      if (response.statusCode == 200) {
        // Save new token
        await _saveUserSession(
          token: responseBody['token'],
          userDetails: null, // No need to update user details
        );

        return {
          'success': true,
          'message': 'Token refreshed successfully',
          'token': responseBody['token']
        };
      } else {
        return {
          'success': false,
          'message': responseBody['message'] ?? 'Token refresh failed'
        };
      }
    } catch (e) {
      print('Error refreshing token: $e');
      return {'success': false, 'message': 'Network error occurred'};
    }
  }
}
