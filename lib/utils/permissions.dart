import 'package:permission_handler/permission_handler.dart';

import 'package:flutter/services.dart';

class Permissions {
  static Future<bool> cameraAndMicrophonePermissionsGranted() async {
    PermissionStatus status = await Permission.microphone.request();
    PermissionStatus cameraStatus = await Permission.camera.request();

    if (status == PermissionStatus.granted &&
        cameraStatus == PermissionStatus.granted) {
      return true;
    } else {
      _handleInvalidPermissions(
          cameraStatus, status);
      return false;
    }
  }

//  static Future<PermissionStatus> _getCameraPermission() async {
//    PermissionStatus permission =
//    await PermissionHandler().checkPermissionStatus(PermissionGroup.camera);
//    if (permission != PermissionStatus.granted &&
//        permission != PermissionStatus.disabled) {
//      Map<PermissionGroup, PermissionStatus> permissionStatus =
//      await PermissionHandler()
//          .requestPermissions([PermissionGroup.camera]);
//      return permissionStatus[PermissionGroup.camera] ??
//          PermissionStatus.unknown;
//    } else {
//      return permission;
//    }
//  }

//  static Future<PermissionStatus> _getMicrophonePermission() async {
//    PermissionStatus status = await Permission.microphone.request();
//    PermissionStatus cameraStatus = await Permission.camera.request();
//
//
//    if (status != PermissionStatus.granted &&
//        status != PermissionStatus.permanentlyDenied) {
//      Map<PermissionGroup, PermissionStatus> permissionStatus =
//      await PermissionHandler()
//          .requestPermissions([PermissionGroup.microphone]);
//      return permissionStatus[PermissionGroup.microphone] ??
//          PermissionStatus.unknown;
//    } else {
//      return permission;
//    }
//  }

  static void _handleInvalidPermissions(
      PermissionStatus cameraPermissionStatus,
      PermissionStatus microphonePermissionStatus,
      ) {
    if (cameraPermissionStatus == PermissionStatus.denied &&
        microphonePermissionStatus == PermissionStatus.denied) {
      throw new PlatformException(
          code: "PERMISSION_DENIED",
          message: "Access to camera and microphone denied",
          details: null);
    } else if (cameraPermissionStatus == PermissionStatus.permanentlyDenied &&
        microphonePermissionStatus == PermissionStatus.permanentlyDenied) {
      throw new PlatformException(
          code: "PERMISSION_DISABLED",
          message: "Location data is not available on device",
          details: null);
    }
  }
}