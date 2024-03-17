class Simulator {
  bool verifyLogin(String username, String password) {
    if (username == 'admin' && password == 'admin2004') {
      return true;
    }
    return false;
  }
}