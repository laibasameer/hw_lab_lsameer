import SwiftUI
import FirebaseCore

// Configures Firebase when the application launches.
class AppDelegate: NSObject, UIApplicationDelegate {

    // Initializes Firebase before the app displays its main screen.
    func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions:
            [UIApplication.LaunchOptionsKey: Any]? = nil
    ) -> Bool {
        FirebaseApp.configure()
        return true
    }
}

@main
struct ArbeitApp: App {
    // Connects the app lifecycle to our Firebase AppDelegate.
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate

    // Displays the main application interface.
    var body: some Scene {
        WindowGroup {
            AppView()
        }
    }
}
