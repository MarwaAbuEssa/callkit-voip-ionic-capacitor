/*
See LICENSE folder for this sample’s licensing information.

Abstract:
The CallKit provider delegate, which conforms to CXProviderDelegate protocol.
*/
import Capacitor
import Foundation
import UIKit
import CallKit

final class ProviderDelegate: NSObject {

    /// The app's provider configuration, representing its CallKit capabilities.
    static let providerConfiguration: CXProviderConfiguration = {
        let localizedName = NSLocalizedString("APPLICATION_NAME", comment: "Name of application")
        let providerConfiguration = CXProviderConfiguration(localizedName: localizedName)

        // Prevents multiple calls from being grouped.
        providerConfiguration.maximumCallsPerCallGroup = 1
        
        providerConfiguration.supportsVideo = true
        providerConfiguration.supportedHandleTypes = [.phoneNumber]
        providerConfiguration.ringtoneSound = "Ringtone.aif"

       // let iconMaskImage = #imageLiteral(resourceName: "IconMask")
       // providerConfiguration.iconTemplateImageData = iconMaskImage.pngData()

        return providerConfiguration
    }()

    let speakerboxCallManager: SpeakerboxCallManager
    public  let provider: CXProvider

    init(callManager: SpeakerboxCallManager) {
        self.speakerboxCallManager = callManager
      provider = CXProvider(configuration: type(of: self).providerConfiguration)

       super.init()
    //    return provider;
        //provider.setDelegate(self, queue: DispatchQueue.main)
        //return provider;
    }
    
    func get() -> CXProvider{
        return provider;
    }

    // MARK: - Handle Incoming Calls

    /// Use CXProvider to report the incoming call to the system.
    /// - Parameters:
    ///   - uuid: The unique identifier of the call.
    ///   - handle: The handle for the caller.
    ///   - hasVideo: If `true`, the call can include video.
    ///   - completion: A closure that is executed once the call is allowed or disallowed by the system.
  /*  func reportIncomingCall(uuid: UUID, handle: String, hasVideo: Bool = false, completion: ((Error?) -> Void)? = nil) {
        // Construct a CXCallUpdate describing the incoming call, including the caller.
        let update = CXCallUpdate()
        update.remoteHandle = CXHandle(type: .phoneNumber, value: handle)
        update.hasVideo = hasVideo

        // Report the incoming call to the system.
        provider.reportNewIncomingCall(with: uuid, update: update) { error in
            /*
             Only add an incoming call to an app's list of calls if it's allowed, i.e., there is no error.
             Calls may be denied for various legitimate reasons. See CXErrorCodeIncomingCallError.
             */
            if error == nil {
                let call = SpeakerboxCall(uuid: uuid)
                call.handle = handle

                self.callManager.addCall(call)
            }

            completion?(error)
        }
    }*/

    func handleCXAnswerCallAction(callUUID:UUID) {
        
        // Retrieve the SpeakerboxCall instance corresponding to the action's call UUID.
        guard let call = speakerboxCallManager.callWithUUID(uuid: callUUID) else {
           // action.fail()
            return
        }
        /*
         Configure the audio session but do not start call audio here.
         Call audio should not be started until the audio session is activated by the system,
         after having its priority elevated.
         */
        configureAudioSession()
       // startAudio()
        // Trigger the call to be answered via the underlying network service.
        call.answerSpeakerboxCall()

    }
    
    
    func handleCXAudioStart(callUUID:UUID) {
        startAudio()
    }
    
    
}

// MARK: - CXProviderDelegate
/*
//extension ProviderDelegate: CXProviderDelegate {
extension CallKitVOIPPlugin: CXProviderDelegate {
    
   public func providerDidReset(_ provider: CXProvider) {
        print("Provider did reset")

        stopAudio()

        /*
         End any ongoing calls if the provider resets, and remove them from the app's list of calls
         because they are no longer valid.
         */
        for call in callManager.calls {
            call.endSpeakerboxCall()
        }

        // Remove all calls from the app's list of calls.
        callManager.removeAllCalls()
    }

    public func provider(_ provider: CXProvider, perform action: CXStartCallAction) {
        // Create and configure an instance of SpeakerboxCall to represent the new outgoing call.
        let call = SpeakerboxCall(uuid: action.callUUID, isOutgoing: true)
        call.handle = action.handle.value

        /*
         Configure the audio session but do not start call audio here.
         Call audio should not be started until the audio session is activated by the system,
         after having its priority elevated.
         */
        configureAudioSession()

        /*
         Set callbacks for significant events in the call's lifecycle,
         so that the CXProvider can be updated to reflect the updated state.
         */
      /*  call.hasStartedConnectingDidChange = { [weak self] in
            self?.provider.reportOutgoingCall(with: call.uuid, startedConnectingAt: call.connectingDate)
        }
        call.hasConnectedDidChange = { [weak self] in
            self?.provider.reportOutgoingCall(with: call.uuid, connectedAt: call.connectDate)
        }*/

        // Trigger the call to be started via the underlying network service.
        call.startSpeakerboxCall { success in
            if success {
                // Signal to the system that the action was successfully performed.
                action.fulfill()

                // Add the new outgoing call to the app's list of calls.
                self.callManager.addCall(call)
            } else {
                // Signal to the system that the action was unable to be performed.
                action.fail()
            }
        }
    }

    public func provider(_ provider: CXProvider, perform action: CXAnswerCallAction) {
        // Retrieve the SpeakerboxCall instance corresponding to the action's call UUID.
        guard let call = callManager.callWithUUID(uuid: action.callUUID) else {
            action.fail()
            return
        }

        /*
         Configure the audio session but do not start call audio here.
         Call audio should not be started until the audio session is activated by the system,
         after having its priority elevated.
         */
        configureAudioSession()

        // Trigger the call to be answered via the underlying network service.
        call.answerSpeakerboxCall()
        
        let cc = CallKitVOIPPlugin()
        cc.notifyEvent(eventName: "callAnswered", uuid: action.callUUID)
        notifyEvent(eventName: "registration", uuid: action.callUUID)
        //self.notifyListeners(String, data: <#T##[String : Any]?#>)
        self.notifyListeners("registration", data: ["token": "selfff   ttttttttttt"])
        notifyListeners("registration", data: ["token": "ttttttttttt"])
        // Signal to the system that the action was successfully performed.
        action.fulfill()
    }

    public func provider(_ provider: CXProvider, perform action: CXEndCallAction) {
        // Retrieve the SpeakerboxCall instance corresponding to the action's call UUID
        guard let call = callManager.callWithUUID(uuid: action.callUUID) else {
            action.fail()
            return
        }

        // Stop call audio when ending a call.
        stopAudio()

        // Trigger the call to be ended via the underlying network service.
        call.endSpeakerboxCall()

        // Signal to the system that the action was successfully performed.
        action.fulfill()

        // Remove the ended call from the app's list of calls.
        callManager.removeCall(call)
    }

    public  func provider(_ provider: CXProvider, perform action: CXSetHeldCallAction) {
        // Retrieve the SpeakerboxCall instance corresponding to the action's call UUID
        guard let call = callManager.callWithUUID(uuid: action.callUUID) else {
            action.fail()
            return
        }

        // Update the SpeakerboxCall's underlying hold state.
        call.isOnHold = action.isOnHold

        // Stop or start audio in response to holding or unholding the call.
        if call.isOnHold {
            stopAudio()
        } else {
            startAudio()
        }

        // Signal to the system that the action has been successfully performed.
        action.fulfill()
    }

    public func provider(_ provider: CXProvider, timedOutPerforming action: CXAction) {
        print("Timed out", #function)

        // React to the action timeout if necessary, such as showing an error UI.
    }

    public func provider(_ provider: CXProvider, didActivate audioSession: AVAudioSession) {
        print("Received", #function)

        /*
         Start call audio media, now that the audio session is activated,
         after having its priority elevated.
         */
        startAudio()
    }

    public func provider(_ provider: CXProvider, didDeactivate audioSession: AVAudioSession) {
        print("Received", #function)

        /*
         Restart any non-call related audio now that the app's audio session is deactivated,
         after having its priority restored to normal.
         */
    }

}
 */
 
