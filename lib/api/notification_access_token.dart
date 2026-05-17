import 'dart:developer';
import 'package:googleapis_auth/auth_io.dart';

class NotificationAccessToken {
  static String? _token;

  // Generates token only once per app session
  Future<String?> get getToken async => _token ?? await _getAccessToken();

  static Future<String?> _getAccessToken() async {
    try {
      const fMessagingScope =
          'https://www.googleapis.com/auth/firebase.messaging';

      // ⚠️ STEP 1: Go to Firebase Console > Project Settings > Service Accounts.
      // ⚠️ STEP 2: Click 'Generate new private key' to download your JSON file.
      // ⚠️ STEP 3: Replace the dummy map below with your actual JSON file content.
      final client = await clientViaServiceAccount(
        ServiceAccountCredentials.fromJson({
          "type": "service_account",
          "project_id": "YOUR_PROJECT_ID_HERE",
          "private_key_id": "YOUR_PRIVATE_KEY_ID_HERE",
          "private_key":
              "-----BEGIN PRIVATE KEY-----\nYOUR_PRIVATE_KEY_HERE\n-----END PRIVATE KEY-----\n",
          "client_email":
              "YOUR_SERVICE_ACCOUNT_EMAIL@YOUR_PROJECT.iam.gserviceaccount.com",
          "client_id": "YOUR_CLIENT_ID_HERE",
          "auth_uri": "https://accounts.google.com/o/oauth2/auth",
          "token_uri": "https://oauth2.googleapis.com/token",
          "auth_provider_x509_cert_url":
              "https://www.googleapis.com/oauth2/v1/certs",
          "client_x509_cert_url":
              "https://www.googleapis.com/robot/v1/metadata/x509/YOUR_ESCAPE_ENCODED_SERVICE_ACCOUNT_EMAIL",
          "universe_domain": "googleapis.com"
        }),
        [fMessagingScope],
      );

      _token = client.credentials.accessToken.data;
      return _token;
    } catch (e) {
      log('Error fetching access token: $e');
      return null;
    }
  }
}
