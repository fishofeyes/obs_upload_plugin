import 'obs_upload_plugin_platform_interface.dart';

class ObsUploadPlugin {
  Future<String?> getPlatformVersion() {
    return ObsUploadPluginPlatform.instance.getPlatformVersion();
  }

  Future<void> init(String ak, String sk, String endPoint) {
    return ObsUploadPluginPlatform.instance.init(ak, sk, endPoint);
  }

  Stream<Map<String, dynamic>> upload(String path) {
    return ObsUploadPluginPlatform.instance.upload(path);
  }
}
