import 'package:flutter_dotenv/flutter_dotenv.dart';

enum Environment { local, production }

class EnvConfig {
  static const Environment currentEnv =
      Environment.production; // Ganti sesuai environment aktif

  static String get baseUrl {
    switch (currentEnv) {
      case Environment.production:
        return _getEnvVar('BASE_URL_PRODUCTION');
      case Environment.local:
        return _getEnvVar('BASE_URL_LOCAL');
    }
  }

  static String _getEnvVar(String key) {
    final value = dotenv.env[key];
    if (value == null || value.isEmpty) {
      throw Exception("Environment variable '$key' is missing or empty.");
    }
    return value;
  }
}
