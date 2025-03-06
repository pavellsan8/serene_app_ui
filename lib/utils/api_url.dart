enum Environment { local, production }

class EnvConfig {
  static const Environment currentEnv = Environment.local;

  static String get baseUrl {
    switch (currentEnv) {
      case Environment.production:
        return "https://api.production.com"; // URL Production
      default:
        return "http://127.0.0.1:5001"; // URL Local
    }
  }
}
