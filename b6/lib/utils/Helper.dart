class Helper {
  static String replaceLocalHost(String url) {
    return url.replaceFirst("http://localhost", "http://10.0.2.2");
  }
}
