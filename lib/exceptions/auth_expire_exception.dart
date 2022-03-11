import 'dart:io';

class AuthExpireException implements IOException {
  final String message;
  final Uri? uri;

  const AuthExpireException(this.message, {this.uri});

  @override
  String toString() {
    var b = StringBuffer()
      ..write('AuthExpireException: ')
      ..write(message);
    var uri = this.uri;
    if (uri != null) {
      b.write(', uri = $uri');
    }
    return b.toString();
  }
}
