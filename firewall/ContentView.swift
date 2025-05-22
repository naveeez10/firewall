import SwiftUI
import NetworkExtension
import UserNotifications

struct ContentView: View {
    var body: some View {
        VStack {
            Button{
                askPermission()
            }label:{
                Text("Ask Permission")
            }
        }
        .padding()
        .onAppear{
            // MARK: Load NetworkExtension
            NEFilterManager.shared().loadFromPreferences{error in
                if let  saveError = error {
                    print("Failed to save the filter configuration: \(saveError)")
                }
            }
        }
    }
   
    

    func askPermission(){
        // MARK: Configure Provider
        if NEFilterManager.shared().providerConfiguration == nil {
            let newConfiguration = NEFilterProviderConfiguration()
            newConfiguration.organization = "firewall"
            newConfiguration.filterBrowsers = true
            newConfiguration.filterSockets = true
            NEFilterManager.shared().providerConfiguration = newConfiguration
        }
        NEFilterManager.shared().isEnabled = true
        NEFilterManager.shared().saveToPreferences { error in
            if let  saveError = error {
                print("Failed to save the filter configuration: \(saveError)")
            }
        }
    }
}
