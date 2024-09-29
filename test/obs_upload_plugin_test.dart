import 'package:flutter_test/flutter_test.dart';
import 'package:obs_upload_plugin/obs_upload_plugin.dart';
import 'package:obs_upload_plugin/obs_upload_plugin_platform_interface.dart';
import 'package:obs_upload_plugin/obs_upload_plugin_method_channel.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

class MockObsUploadPluginPlatform
    with MockPlatformInterfaceMixin
    implements ObsUploadPluginPlatform {

  @override
  Future<String?> getPlatformVersion() => Future.value('42');
}

void main() {
  final ObsUploadPluginPlatform initialPlatform = ObsUploadPluginPlatform.instance;

  test('$MethodChannelObsUploadPlugin is the default instance', () {
    expect(initialPlatform, isInstanceOf<MethodChannelObsUploadPlugin>());
  });

  test('getPlatformVersion', () async {
    ObsUploadPlugin obsUploadPlugin = ObsUploadPlugin();
    MockObsUploadPluginPlatform fakePlatform = MockObsUploadPluginPlatform();
    ObsUploadPluginPlatform.instance = fakePlatform;

    expect(await obsUploadPlugin.getPlatformVersion(), '42');
  });
}
