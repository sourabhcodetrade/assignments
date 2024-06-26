import 'package:permission_handler/permission_handler.dart';

final class PermissionPermanentlyDeniedException implements Exception {
  final String message;
  final Permission permission;


  PermissionPermanentlyDeniedException(this.message, this.permission);

  @override
  String toString() => message;
}

final class PermissionDeniedException implements Exception {
  final String message;
  final Permission permission;

  PermissionDeniedException(this.message, this.permission);

  @override
  String toString() => message;
}
