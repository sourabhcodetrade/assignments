import 'package:permission_handler/permission_handler.dart';
import 'package:untitled/custom_dialog.dart';
import 'package:untitled/permissions_exception.dart';

final class PermissionHandler {
  static final PermissionHandler instance = PermissionHandler._();

  factory PermissionHandler() => instance;

  PermissionHandler._();

  Future<bool> askPermissions(List<Permission> permissions) async {
    final Map<Permission, PermissionStatus> statusList =
        await permissions.request();
    try {
      for (final permission in permissions) {
        if (statusList[permission] == PermissionStatus.denied) {
          throw PermissionDeniedException('Permission Denied', permission);
        } else if (statusList[permission] ==
            PermissionStatus.permanentlyDenied) {
          throw PermissionPermanentlyDeniedException(
              'Permission Denied', permission);
        }
      }
    } on PermissionDeniedException catch (e) {
      await askPermissions(permissions);
    } on PermissionPermanentlyDeniedException catch (e) {
      if (CustomDialog.isDialogVisible) {
        CustomDialog.hideDialog();
        CustomDialog.isDialogVisible = false;
      } else {
        CustomDialog.isDialogVisible = true;
        CustomDialog.showDialog(e.permission.toString());
      }
      return false;
    }catch(e){
      return false;

    }
    return false;
  }
}
