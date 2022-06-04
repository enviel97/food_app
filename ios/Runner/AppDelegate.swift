import UIKit
import Flutter
import GoogleMaps

@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
    // if let APIKEY = KeyManager().getValue(key: "GMapApiKey") as? String {
      
    // }
    GMSServices.provideAPIKey("AIzaSyDFbLWmuEKglqdMaL4TEk6khRJ7z0lO_gE")
    GeneratedPluginRegistrant.register(with: self)
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
}
