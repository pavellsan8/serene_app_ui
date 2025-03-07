enum Environment { local, production }

class EnvConfig {
  static const Environment currentEnv = Environment.production;

  static String get baseUrl {
    switch (currentEnv) {
      case Environment.production:
        return "https://serene-api.vercel.app"; // URL Production
      default:
        return "http://127.0.0.1:5001"; // URL Local
    }
  }
}
