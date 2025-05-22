import NetworkExtension
import UserNotifications
import OSLog

class FilterDataProvider: NEFilterDataProvider {
    private let log = Logger(subsystem: "com.naviz.firewall",
                             category: "Filter")
    
    /// Handle a new flow of data.
    override func handleNewFlow(_ flow: NEFilterFlow) -> NEFilterNewFlowVerdict {
        guard let socketFlow = flow as? NEFilterSocketFlow else {
            return .allow()
        }
        
        guard let host: String = socketFlow.remoteHostname?.lowercased() else {
            return .allow()
        }
        
        let blockedDomains = ["voom-obs.line-scdn.net", "im.c.yimg.jp",
                              "a.line.me",
                              "obs.line-scdn.net",
                              "gw.line.naver.jp",
                              "ad.line-scdn.net",
                              "scdn.line-apps.com",
                              "linevoom.line.me",
                              "voom-assets.line-scdn.net",
                              "voom-obs.line-scdn.net",
                              "square-api.line.me"]
        for domain in blockedDomains {
            if host.contains(domain) {
                log.error("⛔ Dropped flow to \(host, privacy: .public)")
                return .drop()
            }
            log.error("⛔ Allowed flow to \(host, privacy: .public)")
        }
        return .allow()
    }
    
    /// Filter an inbound chunk of data.
    override func handleInboundData(from flow: NEFilterFlow, readBytesStartOffset offset: Int, readBytes: Data) -> NEFilterDataVerdict {
        var result = NEFilterDataVerdict.allow()
        result = NEFilterDataVerdict.needRules()
        return result
    }
    
    /// Handle the event where all of the inbound data for a flow has been filtered.
    override func handleInboundDataComplete(for flow: NEFilterFlow) -> NEFilterDataVerdict {
        var result = NEFilterDataVerdict.allow()
        result = NEFilterDataVerdict.needRules()
        //result = NEFilterDataVerdict.drop()
        return result
    }
    
    /// Filter an outbound chunk of data.
    override func handleOutboundData(from flow: NEFilterFlow, readBytesStartOffset offset: Int, readBytes: Data) -> NEFilterDataVerdict {
        
        var result = NEFilterDataVerdict.allow()
        result = NEFilterDataVerdict.needRules()
        //result = NEFilterDataVerdict.drop()
        return result
    }
    
    /// Handle the event where all of the outbound data for a flow has been filtered.
    override func handleOutboundDataComplete(for flow: NEFilterFlow) -> NEFilterDataVerdict {
        var result = NEFilterDataVerdict.allow()
        result = NEFilterDataVerdict.needRules()
        //result = NEFilterDataVerdict.drop()
        return result
    }
    
    /// Handle the user tapping on the "Request Access" link in the block page.
    override func handleRemediation(for flow: NEFilterFlow) -> NEFilterRemediationVerdict {

        return .allow()
    }
}
