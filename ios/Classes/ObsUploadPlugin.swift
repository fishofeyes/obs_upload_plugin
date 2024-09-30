import Flutter
import UIKit
import OBS

public class ObsUploadPlugin: NSObject, FlutterPlugin, FlutterStreamHandler {
    var config: OBSServiceConfiguration?
    private var eventSink: FlutterEventSink?
    
  public static func register(with registrar: FlutterPluginRegistrar) {
    let channel = FlutterMethodChannel(name: "obs_upload_plugin", binaryMessenger: registrar.messenger())
    let instance = ObsUploadPlugin()
    registrar.addMethodCallDelegate(instance, channel: channel)
      
      let streamChannel = FlutterEventChannel(name: "obs_upload_plugin/upload", binaryMessenger: registrar.messenger())
      streamChannel.setStreamHandler(instance)
  }

  public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
    switch call.method {
    case "getPlatformVersion":
      result("iOS " + UIDevice.current.systemVersion)
    case "init":
        let arg = call.arguments as! [String: String]
        let ak = arg["ak"]!
        let sk = arg["sk"]!
        let endPoint = arg["endPoint"]!
        let provider = OBSStaticCredentialProvider.init(accessKey: ak, secretKey: sk)
        config = OBSServiceConfiguration.init(url: URL(string: endPoint)!, credentialProvider: provider)
       
    default:
      result(FlutterMethodNotImplemented)
    }
  }
    
    func uploadFile(path: String?, etag: String? = nil) {
        if let config = config {
            let client = OBSClient.init(configuration: config)
            // upload setting
            client!.configuration.maxConcurrentUploadRequestCount = 5;
            client!.configuration.uploadSessionConfiguration.httpMaximumConnectionsPerHost = 10
            let request = OBSUploadFileRequest.init(bucketName: "bucketName", objectKey: "objcetname", uploadFilePath: path)
            request?.partSize = NSNumber(integerLiteral: 5 * 1024 * 1024)
            request?.enableCheckpoint = true
//            request?.checkpointFilePath = "";
            request?.uploadProgressBlock = {sent, total, totalBytesExpectedToSend in
                print("sent = \(sent), total = \(total), totalBytesExpectedToSend = \(totalBytesExpectedToSend)")
            }
            let task = client?.uploadFile(request, completionHandler: { response, err in
                if (err != nil) {
                    print("ios upload err: \(err), etag: \(response?.etag)")
                    response?.etag
                }
            })
            // 取消上传
//                request?.cancel();
            
        }
    }
    
    public func onListen(withArguments arguments: Any?, eventSink events: @escaping FlutterEventSink) -> FlutterError? {
        self.eventSink = events;
        if let arg = arguments as? [String: Any] {
            let path = arg["path"] as? String
            uploadFile(path: path)
        }
        return nil;
    }
    
    public func onCancel(withArguments arguments: Any?) -> FlutterError? {
        self.eventSink = nil
        return nil;
    }
}
