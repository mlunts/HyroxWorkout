import Foundation
import WatchConnectivity

@Observable
final class SettingsSync: NSObject, WCSessionDelegate {
    var receivedDivision: Division?
    var receivedSplitStations: Bool?

    override init() {
        super.init()
        guard WCSession.isSupported() else { return }
        WCSession.default.delegate = self
        WCSession.default.activate()
    }

    func send(division: Division, splitStations: Bool) {
        guard WCSession.default.activationState == .activated else { return }
        let context: [String: Any] = [
            "division": division.rawValue,
            "splitStations": splitStations
        ]
        try? WCSession.default.updateApplicationContext(context)
    }

    // MARK: - WCSessionDelegate

    func session(_ session: WCSession, activationDidCompleteWith activationState: WCSessionActivationState, error: Error?) {}

    #if os(iOS)
    func sessionDidBecomeInactive(_ session: WCSession) {}
    func sessionDidDeactivate(_ session: WCSession) {
        WCSession.default.activate()
    }
    #endif

    func session(_ session: WCSession, didReceiveApplicationContext applicationContext: [String: Any]) {
        DispatchQueue.main.async {
            if let raw = applicationContext["division"] as? String,
               let division = Division(rawValue: raw) {
                self.receivedDivision = division
            }
            if let split = applicationContext["splitStations"] as? Bool {
                self.receivedSplitStations = split
            }
        }
    }
}
