import Foundation
import Capacitor
import UIKit
import CallKit
import PushKit
import AVFoundation
import NotificationCenter

/**
 * Please read the Capacitor iOS Plugin Development Guide
 * here: https://capacitorjs.com/docs/plugins/ios
 */
@objc(CallKitVOIPPlugin)
public class CallKitVOIPPlugin: CAPPlugin {
    private let implementation = CallKitVOIP()
    private var provider: CXProvider?
  //8888888    public var  provider: CXProvider?
    private let voipRegistry    = PKPushRegistry(queue: nil)
  // private let voipRegistry    = PKPushRegistry(queue: DispatchQueue.main)
    //let voipRegistry = PKPushRegistry(queue: .main)
    private var connectionIdRegistry : [UUID: CallConfig] = [:]
    
    
    private let callKitVOIPController =  CXCallController ();

  // private  var callsController: SpeakerboxCallManager?;
     let  callManager = SpeakerboxCallManager();
   var  providerDelegate : ProviderDelegate?
    //= ProviderDelegate(callManager: callsController)
    
    @objc func echo(_ call: CAPPluginCall) {
        let value = call.getString("value") ?? ""
        call.resolve([
            "value": implementation.echo(value)
        ])
    }


  @objc func register(_ call: CAPPluginCall) {
      
   //   let voipRegistry = PKPushRegistry(queue: .main)
     // let callManager = SpeakerboxCallManager()
     // var providerDelegate: ProviderDelegate?
      
      // config PushKit
        voipRegistry.delegate = self
        voipRegistry.desiredPushTypes = [.voIP]

      providerDelegate = ProviderDelegate(callManager: callManager)
      // config PushKit
        //  voipRegistry.delegate = self
          //voipRegistry.desiredPushTypes = [.voIP]
          
          let config = CXProviderConfiguration(localizedName: "Better Call")
          config.supportsVideo = true
          config.supportedHandleTypes = [.emailAddress]
          
          provider = CXProvider(configuration: config)
          provider?.setDelegate(self, queue: DispatchQueue.main)
      
    //  provider = providerDelegate?.get();
      
      
     // provider = providerDelegate?.provider;
         // call.resolve()

     // provider.setDelegate(self, queue: nil)
      //providerDelegate?.setDelegate(self, queue: nil)

      /*
      // config PushKit
        voipRegistry.delegate = self
        voipRegistry.desiredPushTypes = [.voIP]
        
        let config = CXProviderConfiguration(localizedName: "ULTATEL HUB")
        config.supportsVideo = true
    config.supportedHandleTypes = [.phoneNumber]
    config.includesCallsInRecents=true
    config.maximumCallGroups=1
    config.maximumCallsPerCallGroup = 4
    
  //  UIImage iconData =UIImage(named: "logo")
 //   config.iconTemplateImageData = iconData;
    provider = CXProvider(configuration: config)
       provider = CXProvider(configuration: config)
    provider?.setDelegate(self, queue: DispatchQueue.main)
    //provider?.setDelegate(self, queue: nil)
    
    //provider?.setDelegate(self, queue: nil)
   // NotificationCenter.default.addObserver(self, selector: Recieve, name: ///<#T##NSNotification.Name?#>, object: <#T##Any?#>)
      
       */
      //providerDelegate?.provider.setDelegate(self, queue: DispatchQueue.main)
      notifyListeners("registration", data: ["token": "registereddddd"])
        call.resolve()
    }

    public func notifyEvent(eventName: String, uuid: UUID){
        ///if let config = connectionIdRegistry[uuid] {
           // notifyListeners(eventName, data: [
               // "connectionId": config.connectionId,
                //"username"    : config.username
            //])
     // let uu = uuid.uuidString;
            notifyListeners(eventName, data: [
                "callId": uuid.uuidString
            ])
            connectionIdRegistry[uuid] = nil
        //}
    }

   
  
    
    @objc func startCall(_ call: CAPPluginCall) {
        let uuidString = call.getString("uuidString") ?? ""
        print("call3 call.start  \(uuidString)")
        let handleString = call.getString("handleString") ?? ""
      //  let contactIdentifier = call.getString("contactIdentifier") ?? ""
        let hasVideo = call.getBool("hasVideo") ?? false
        

    let uuid = callManager.startCall(handle: handleString, video: hasVideo)

        
        print("call3 call.start uuid  \(uuid.uuidString)")
        call.resolve([
            "value": uuid.uuidString
                //"callId": uuid.uuidString
        ])
    }
   // @objc func startCall(uuidString:String, handleString:String, //contactIdentifier:String, hasVideo :Bool) {
      /* @objc func startCall(_ call: CAPPluginCall) {
            let uuidString = call.getString("uuidString") ?? ""
            print("call3 call.start  \(uuidString)")
            let handleString = call.getString("handleString") ?? ""
            let contactIdentifier = call.getString("contactIdentifier") ?? ""
            let hasVideo = call.getBool("hasVideo") ?? false
        // Build call action
            let uuid = UUID(uuidString: uuidString)
            //let uuid = NSUUID.init(uuidString: uuidString)
           // NSUUID uuid = [[NSUUID alloc] initWithUUIDString:uuidString]
            //let uuid = UUID(uuidString: "261")
        //let uuid = NSUUID.init(uuidString: uuidString)
            let handle = CXHandle(type:.phoneNumber,value: handleString)

            
        let  startCallAction = CXStartCallAction(call: uuid ?? UUID(), handle: handle)
        //let  startCallAction = CXStartCallAction(call: new NSUuid (), handle: handle)
            startCallAction.isVideo = hasVideo;
           startCallAction.contactIdentifier = contactIdentifier;
        
      //  callUpdate.supportsDTMF = YES;
       // callUpdate.supportsHolding = YES;
       // callUpdate.supportsGrouping = YES;
       // callUpdate.supportsUngrouping = YES;
        // Create transaction
       let startTransaction = CXTransaction(action:startCallAction)
        // Inform system of call request
        SendTransactionRequest (transaction: startTransaction)
        //self.configureAudioSession()
        //let callUpdate = CXCallUpdate.init();
         //  callUpdate.hasVideo=false;
           // callUpdate.localizedCallerName = startCallAction.contactIdentifier
            //provider?.reportCall(with:startCallAction.callUUID, updated: callUpdate)
            
        //notifyEvent(eventName: "callStarted", uuid:uuid ?? UUID())
        print("call3 call.resolve uuidString \(uuidString)")
            print("call3 call.resolve uuid startCallAction.callUUID \(startCallAction.callUUID)")
            
            //print("call3 call.resolve uuid startCallAction.uuid \(startCallAction.uuid)")
        call.resolve([
            // "value": "done successfully"
                "callId": uuidString
        ])
            
            //call.resolve([
                    //"callId": uuidString
               // "callDate": {"callDate":uuidString}
            //])
    }
    */
    @objc func endCall(_ call: CAPPluginCall) {
      //  let uuidString = call.getString("uuidString") ?? ""
        // Build call action
       // let uuid = UUID(uuidString: uuidString)
       // let  endCallAction = CXEndCallAction(call: uuid ?? UUID())
       // let endTransaction = CXTransaction(action:endCallAction)
      //  SendTransactionRequest (transaction: endTransaction)
        print("Requested call.end ")
        call.resolve([
                "value": "call ended successfully"
        ])
    }
    
   // @objc func activateAudioSession(_ call: CAPPluginCall) {
       // print("call3 activate call")
       // self.configureAudioSession()
    //}
    
    @objc func connectCall(_ call: CAPPluginCall) {
       // callManager.connectCall()
        call.resolve([
                "value": "call connected successfully"
        ])
    }
    
    
    
    
    func reportIncomingCall(uuid: UUID, handle: String, hasVideo: Bool = false, completion: ((Error?) -> Void)? = nil) {
        // Construct a CXCallUpdate describing the incoming call, including the caller.
        let update = CXCallUpdate()
        update.remoteHandle = CXHandle(type: .phoneNumber, value: handle)
        update.hasVideo = hasVideo

        // Report the incoming call to the system.
       
        self.provider?.reportNewIncomingCall(with: uuid, update: update) { error in
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
    }
    
    @objc func handleAnswer(_ call: CAPPluginCall) {
        let uuidString = call.getString("uuidString") ?? ""
        let uuid = UUID(uuidString: uuidString) ?? UUID()
       providerDelegate?.handleCXAnswerCallAction(callUUID: uuid)
       // providerDelegate?.handleCXAudioStart(callUUID: uuid)
        call.resolve([
            "callUUID": uuid.uuidString
        ])
    }
    
    @objc func displayIncommingCall(_ call: CAPPluginCall) {
        let uuidString = call.getString("uuidString") ?? ""
        let handleString = call.getString("handleString") ?? ""
        let uuid = UUID(uuidString: uuidString) ?? UUID()
        print("call3 call.imcoming  \(uuidString)")
        //let contactIdentifier = call.getString("contactIdentifier") ?? ""
        let hasVideo = call.getBool("hasVideo") ?? false
        //notifyListeners("callAnswered", data: ["token": "sososoooo"])
    
        self.reportIncomingCall(uuid: uuid, handle: handleString, hasVideo: hasVideo, completion: { Error in
                if let Error = Error {
                        print("Error call3 reportNewIncomingCall : \(Error)")
                    }else{
                        print("Requested call3 reportNewIncomingCall Successfully")
                }
            })
        
        /*self.providerDelegate?.reportIncomingCall(uuid: uuid, handle: handleString, hasVideo: hasVideo, completion: { Error in
                if let Error = Error {
                        print("Error call3 reportNewIncomingCall : \(Error)")
                    }else{
                        print("Requested call3 reportNewIncomingCall Successfully")
                }
            })*/
        
       // providerDelegate?.reportIncomingCall(uuid: UUID(), handle: "261")
       
       // notifyListeners("callAnswered", data: ["token": "totaaaa"])
     //   notifyEvent(eventName: "callAnswered", uuid: UUID())
        call.resolve([
            "callUUID": uuid.uuidString
        ])
        /*
                let uuidString = call.getString("uuidString") ?? ""
                print("call3 call.imcoming  \(uuidString)")
                let handleString = call.getString("handleString") ?? ""
                let contactIdentifier = call.getString("contactIdentifier") ?? ""
                let hasVideo = call.getBool("hasVideo") ?? false
            //Build call update
            let update          = CXCallUpdate()
            update.remoteHandle = CXHandle(type: .phoneNumber, value: handleString)
            update.localizedCallerName = contactIdentifier
        update.hasVideo     = hasVideo
            
                let uuid = UUID(uuidString: uuidString)

          //  connectionIdRegistry[uuid] = .init(connectionId: connectionId, username: from)
            //self.provider?.reportNewIncomingCall(with: uuid, update: update, completion: { (_) in })
                self.provider?.reportNewIncomingCall(with: uuid ?? UUID(), update: update, completion: { Error in
                    if let Error = Error {
                            print("Error call3 reportNewIncomingCall : \(Error)")
                           
                        }else{
                            print("Requested call3 reportNewIncomingCall Successfully")
                        }
                })*/
       }
    
    
    
    
    /*
    @objc func connectCall(_ call: CAPPluginCall) {
        let notificationName  = Notification.Name(rawValue: "AVAudioSessionInterruptionNotification")
        //print("call3 connected")
        let uuidString = call.getString("uuidString") ?? ""
        let uuid = UUID(uuidString: uuidString)
        print("call3 call.connectCall  \(uuidString)")
       // provider?.reportOutgoingCall(with: uuid ?? UUID(), connectedAt: nil)
        provider?.reportOutgoingCall(with: uuid ?? UUID(), startedConnectingAt: nil)
    
         NotificationCenter.default.post(name: notificationName, object: nil, userInfo: [AVAudioSessionInterruptionTypeKey : AVAudioSession.InterruptionType.ended])
         NotificationCenter.default.post(name: notificationName, object: nil, userInfo: [AVAudioSessionInterruptionOptionKey : AVAudioSession.InterruptionOptions.shouldResume])
        
       // let update          = CXCallUpdate()
       // update.remoteHandle = CXHandle(type: .phoneNumber, value: "marwaaaaaaa")
        //provider?.reportCall(with: uuid ?? UUID(), updated: update)
        
     //   let  answerCallAction = CXAnswerCallAction(call: uuid ?? UUID())
      //  let answerTransaction = CXTransaction(action:answerCallAction)
       // SendTransactionRequest (transaction: answerTransaction)
        print("call3 call.answered  \(uuidString)")
        //let  audioSession:AVAudioSession = AVAudioSession.sharedInstance()
       // do{
            //try audioSession.setCategory(AVAudioSession.Category.playAndRecord)
            //
            //try audioSession.setCategory(AVAudioSession.Category.playAndRecord, options: AVAudioSession.CategoryOptions.allowBluetooth)
          
            //, options: AVAudioSession.CategoryOptions.allowBluetooth)
           // try audioSession.setCategory(AVAudioSession.Category.playback)
            //try audioSession.setCategory(AVAudioSession.Category.playback)
           // try audioSession.setMode(AVAudioSession.Mode.voiceChat)
            //try audioSession.setMode(AVAudioSession.Mode.videoChat)
            //try audioSession.setMode(AVAudioSession.Mode.default)
           // let sampleRate:Double = 44100.0
           // try audioSession.setPreferredSampleRate(sampleRate)
           // let bufferDuration:TimeInterval = 0.005
           // try audioSession.setPreferredIOBufferDuration(bufferDuration)
         //   try audioSession.setActive(true, options: AVAudioSession.SetActiveOptions)
            //try audioSession.setActive(true)
            
            
       // } catch(let error){//
         //   print("Error while configuring audio session: \(error)")
       // }
        
        
       // self.configureAudioSession()
    //    provider?.reportOutgoingCall(with: uuid, connectedAt: nil)
       // let  audioSession:AVAudioSession = AVAudioSession.sharedInstance()
        //do{
           // change audiosession category to playand record
          //  try audioSession.setCategory(AVAudioSession.Category.playAndRecord, options: AVAudioSession.CategoryOptions.allowBluetooth)
           // try audioSession.setMode(AVAudioSession.Mode.voiceChat)
           // let sampleRate:Double = 44100.0
            //try audioSession.setPreferredSampleRate(sampleRate)
           // let bufferDuration:TimeInterval = 0.005
            //try audioSession.setPreferredIOBufferDuration(bufferDuration)
         //   try audioSession.setActive(true, options: AVAudioSession.SetActiveOptions)
            //try audioSession.setActive(true)
            
        //} catch(let error){
           // print("Error while configuring audio session: \(error)")
        //}
       // self.configureAudioSession()
        //self.configureSIPAudioSession(active: true)
        self.configureAudioSession()
        call.resolve([
                "value": "call connected successfully"
        ])
    }
     
     */
    
    /*
    public func incommingCall(from: String, connectionId: String) {
        let update          = CXCallUpdate()
        update.remoteHandle = CXHandle(type: .generic, value: from)
        update.hasVideo     = true
        
        let uuid = UUID()
        connectionIdRegistry[uuid] = .init(connectionId: connectionId, username: from)
        self.provider?.reportNewIncomingCall(with: uuid, update: update, completion: { (_) in })
    }*/
   /*
    public func configureSIPAudioSession(active:Bool){
      //  let mm:RTCAudio
    
        let  audioSession:AVAudioSession = AVAudioSession.sharedInstance()
        do{
            try audioSession.setCategory(AVAudioSession.Category.playAndRecord, options: AVAudioSession.CategoryOptions.allowBluetooth)
            //try audioSession.setMode(AVAudioSession.Mode.voiceChat)
            try audioSession.setMode(AVAudioSession.Mode.videoRecording)
            try audioSession.overrideOutputAudioPort(AVAudioSession.PortOverride.none)
            
            
            //try audioSession.setMode(AVAudioSession.Mode.videoChat)
            //try audioSession.setMode(AVAudioSession.Mode.default)
            let sampleRate:Double = 44100.0
            try audioSession.setPreferredSampleRate(sampleRate)
            let bufferDuration:TimeInterval = 0.005
            try audioSession.setPreferredIOBufferDuration(bufferDuration)
         //   try audioSession.setActive(true, options: AVAudioSession.SetActiveOptions)
            try audioSession.setActive(active)
            
            
        } catch(let error){
            print("Error while configuring audio session: \(error)")
        }
    }
    
    public func configureAudioSession(){
        let  audioSession:AVAudioSession = AVAudioSession.sharedInstance()
        do{
            //try audioSession.setCategory(AVAudioSession.Category.playAndRecord)
            
            try audioSession.setCategory(AVAudioSession.Category.playAndRecord, options: AVAudioSession.CategoryOptions.allowBluetooth)
          
            //, options: AVAudioSession.CategoryOptions.allowBluetooth)
           // try audioSession.setCategory(AVAudioSession.Category.playback)
           // try audioSession.setCategory(AVAudioSession.Category.playback)
           try audioSession.setMode(AVAudioSession.Mode.voiceChat)
            //try audioSession.setMode(AVAudioSession.Mode.default)
            try audioSession.overrideOutputAudioPort(AVAudioSession.PortOverride.none)
            
            
            //try audioSession.setMode(AVAudioSession.Mode.videoChat)
            //try audioSession.setMode(AVAudioSession.Mode.default)
            let sampleRate:Double = 44100.0
            try audioSession.setPreferredSampleRate(sampleRate)
            let bufferDuration:TimeInterval = 0.005
            try audioSession.setPreferredIOBufferDuration(bufferDuration)
         //   try audioSession.setActive(true, options: AVAudioSession.SetActiveOptions)
            try audioSession.setActive(true)
            
            
        } catch(let error){
            print("Error while configuring audio session: \(error)")
        }
        // AVAudioSession audioSession = [AVAudioSession sharedInstance];
         //  [audioSession setCategory:AVAudioSessionCategoryPlayAndRecord //withOptions:AVAudioSessionCategoryOptionAllowBluetooth error:nil];

           //[audioSession setMode:AVAudioSessionModeVoiceChat error:nil];

          // double sampleRate = 44100.0;
          // [audioSession setPreferredSampleRate:sampleRate error:nil];

          // NSTimeInterval bufferDuration = .005;
          // [audioSession setPreferredIOBufferDuration:bufferDuration error:nil];
          // [audioSession setActive:TRUE error:nil];
        
    }
    */
    private func SendTransactionRequest (transaction:CXTransaction)
        {
               // Send request to call controller
            callKitVOIPController.request(transaction) { Error in
                if let Error = Error {
                    print("Error requesting transaction: \(Error)")
                    
                }else{
                    print("Requested transaction Successfully")
                }
            }
        }

    public func endCalllll(uuid: UUID) {
       // let controller = CXCallController()
        //let transaction = CXTransaction(action:
                                            //CXEndCallAction(call: //uuid));controller//.request(transaction,completion: { error //in })
    }



}




// MARK: CallKit events handler
 
extension CallKitVOIPPlugin: CXProviderDelegate {
    public func providerDidReset(_ provider: CXProvider) {
        print("call3 provider did reset")
    }
    
    public func provider(_ provider: CXProvider, perform action: CXStartCallAction) {
        //print("call3 starteddddddd") startCallAction.callUUID
        //print("call3 starteddddddd  action.uuidString \(action.callUUID.uuidString)")
        //print("call3 starteddddddd  action.uuid \(action.callUUID.uuid)")
        print("call3 starteddddddd  action.callUUID \(action.callUUID)")
      /// self.configureAudioSession()
        //**********  self.configureSIPAudioSession(active: false)
    
        //notifyListeners("callStarted", data: [
               //   "token": "mizooooooooo"
             // ])
        
        //do this first, audio sessions are flakey
        // [self configureAudioSession];
        
        //do this first, audio sessions are flakey
        // Create & configure an instance of CDVCall, the app's model class representing the new outgoing call.
        /*
         
                 Configure the audio session, but do not start call audio here, since it must be done once
                 the audio session has been activated by the system after having its priority elevated.
          */
      
        
           //tell the JS to actually make the call
          // [self sendEventWithNameWrapper:RNCallKeepDidReceiveStartCallAction body:@{ //@"callUUID": [action.callUUID.UUIDString lowercaseString], @"handle": //action.handle.value }];
           //[action fulfill];
       
       // self.provider?.reportOutgoingCall(with: action.callUUID, startedConnectingAt: nil)
        
        notifyEvent(eventName: "callStarted", uuid: action.callUUID)
        //print("call3 call.connectCall  \(action.callUUID)")
    //    provider.reportOutgoingCall(with: action.callUUID, startedConnectingAt: nil)
        
       // provider?.reportOutgoingCall(with: action.callUUID, started: nil)
      //  self.configureAudioSession()
         action.fulfill()
       // self.configureAudioSession()
    }
    public func provider(_ provider: CXProvider, perform action: CXAnswerCallAction) {
       // self.configureAudioSession()
        //**********   self.configureSIPAudioSession(active: true)
        print("call3 answered")
     //   notifyListeners("registration", data: ["token": "youuuuusss"])
      ///////  endCall(uuid: action.callUUID)
       // handleCXAnswerCallAction
        
      //  providerDelegate?.handleCXAnswerCallAction(callUUID: action.callUUID)
        
        notifyEvent(eventName: "callAnswered", uuid: action.callUUID)
        action.fulfill()
    }
    
    public func provider(_ provider: CXProvider, perform action: CXEndCallAction) {
       // print("call3 endeded")
      //  print("call3 endeded action.uuid.uuidString \(action.uuid.uuidString)")
      //  print("call3 endeded action.uuid \(action.uuid)")
        print("call3 endeded action.callUUID \(action.callUUID)")
        let  audioSession:AVAudioSession = AVAudioSession.sharedInstance()
        do{
           // deactivate audiosession after call ended
            
            try audioSession.setActive(false)
            
        } catch(let error){
            print("Error while configuring audio session: \(error)")
        }
        action.fulfill()
    }
    
    
    public func provider(_ provider: CXProvider, didActivate audioSession: AVAudioSession) {
        print("call3 session activiated")
       // NotificationCenter.default.post(name: AVAudioSessionInterruptionTypeKey, //object: {})
       //let notificationName  = Notification.Name(rawValue: "AVAudioSessionInterruptionNotification")
       // NotificationCenter.default.post(name: notificationName, object: nil, userInfo: [AVAudioSessionInterruptionTypeKey : AVAudioSession.InterruptionType.ended])
       // NotificationCenter.default.post(name: notificationName, object: nil, userInfo: [AVAudioSessionInterruptionOptionKey : AVAudioSession.InterruptionOptions.shouldResume])
        
        
        // Ensure we will be notified of interruptions ending.
            // This is necessary for the AudioSOurce to resume raising frames when the CXSetHeldCallAction
            // ends for a CallKit Call that was on hold.
      //  NotificationCenter.default.post(name: Notification.Name.AVAudioSession.interruptionNotificationAVAudioSession.interruptionNotificationAVAudioSession.interruptionNotificationAVAudioSession.interruptionNotificationAVAudioSession.interruptionNotification, object: nil, userInfo:[AVAudioSessionInterruptionTypeKey : NSNumber.init(value: AVAudioSession.InterruptionType.ended.rawValue)]);
         
        // Ensure we will be notified of interruptions ending.
            // This is necessary for the AudioSOurce to resume raising frames when the CXSetHeldCallAction
            // ends for a CallKit Call that was on hold.
      //  NotificationCenter.default.post(name: //Notification.Name.AVCaptureSessionInterruptionEnded, object: nil, //userInfo:[AVAudioSessionInterruptionTypeKey : NSNumber.init(value: //AVAudioSession.InterruptionType.ended.rawValue)]);
        
        
     //   NotificationCenter.default.post(name: notificationName, object: nil, userInfo:[AVAudioSessionInterruptionTypeKey : NSNumber.init(value: AVAudioSession.InterruptionType.ended.rawValue)]);
        
        
        //NotificationCenter.default.post(name: notificationName, object: nil, userInfo:[AVAudioSessionInterruptionTypeKey : NSNumber.init(value: AVAudioSession.InterruptionOptions.shouldResume.rawValue)]);
        
            //self.configureSIPAudioSession(active: true)
       //********** self.configureAudioSession()
        //notifyEvent(eventName: "callStarted", uuid: action.callUUID)
       //self.configureAudioSession()
      //  notifyEvent(eventName: "callActivateAudioSession", uuid: didActivate.callUUID)
        //let  audioSession:AVAudioSession = AVAudioSession.sharedInstance()
       // do{
           // audioSession.setCategory(AVAudioSession.Category.playAndRecord, mode: //<#T##AVAudioSession.Mode#>, options: <#T##AVAudioSession.CategoryOptions#>)
            
            //try audioSession.setCategory(AVAudioSession.Category.playAndRecord, options: AVAudioSession.CategoryOptions.allowBluetooth)
            //try audioSession.setActive(true)//, options: <#T##AVAudioSession.SetActiveOptions#>)
            
       // } catch(let error){
       //     print("Error while configuring audio session: \(error)")
       // }
        
      //  NotificationCenter.default.post(name: NSNotification.Name(rawValue: AVAudioSessionInterruptionTypeKey) ?? <#default value#>, object: nil, userInfo: [AVAudioSessionInterruptionTypeKey : avaudiosessioni]?)
//NotificationCenter.default.post(name: type(of: self).AudioNotification, object: //"startAudio)
     }

  public  func provider(_ provider: CXProvider, didDeactivate audioSession: AVAudioSession) {
    print("call3 session didDeactivate")
          //  lc.activateAudioSession(actived: false)
     }
    
   // public func provider(_ provider: CXProvider, perform action: CXStartCallAction) {
        //do this first, audio sessions are flakey
        // Create & configure an instance of CDVCall, the app's model class representing the new outgoing call.
        /*
         
                 Configure the audio session, but do not start call audio here, since it must be done once
                 the audio session has been activated by the system after having its priority elevated.
          */
      //  self.configureAudioSession()
       // NotificationCenter.addObserver(<#T##self: NotificationCenter##NotificationCenter#>)
        
        //NotificationCenter.default.post(name: type(of: self).AudioNotification, //object: "mm")
       // print("call starteddddddd")
        // notify VOIP App to actually make call
        //notifyEvent(eventName: "callStarted", uuid: action.callUUID)
        //action.fulfill()
   // }
}










// MARK: PushKit events handler
/*
extension CallKitVOIPPlugin: PKPushRegistryDelegate {
    
    public func pushRegistry(_ registry: PKPushRegistry, didUpdate pushCredentials: PKPushCredentials, for type: PKPushType) {
        let parts = pushCredentials.token.map { String(format: "%02.2hhx", $0) }
        let token = parts.joined()
        notifyListeners("registration", data: ["token": token])
    }
    
    public func pushRegistry(_ registry: PKPushRegistry, didReceiveIncomingPushWith payload: PKPushPayload, for type: PKPushType, completion: @escaping () -> Void) {
        
        guard let connectionId = payload.dictionaryPayload["ConnectionId"] as? String else {
            return
        }
        
        let username        = (payload.dictionaryPayload["Username"] as? String) ?? "Anonymus"
        
        
       //// self.incommingCall(from: username, connectionId: connectionId)
    }
}*/


extension CallKitVOIPPlugin: PKPushRegistryDelegate {
    
    public func pushRegistry(_ registry: PKPushRegistry, didUpdate pushCredentials: PKPushCredentials, for type: PKPushType) {
        let parts = pushCredentials.token.map { String(format: "%02.2hhx", $0) }
        let token = parts.joined()
        notifyListeners("registration", data: ["token": token])
    }
    
    public func pushRegistry(_ registry: PKPushRegistry, didReceiveIncomingPushWith payload: PKPushPayload, for type: PKPushType, completion: @escaping () -> Void) {
        defer {
            completion()
        }
        guard let connectionId = payload.dictionaryPayload["ConnectionId"] as? String else {
            return
        }
        
        let username        = (payload.dictionaryPayload["Username"] as? String) ?? "Anonymus"
        
        guard type == .voIP,
            let uuidString = payload.dictionaryPayload["UUID"] as? String,
            let handle = payload.dictionaryPayload["handle"] as? String,
            let hasVideo = payload.dictionaryPayload["hasVideo"] as? Bool,
            let uuid = UUID(uuidString: uuidString)
            else {
                return
        }

        displayIncomingCall(uuidString: uuidString, handle: handle, hasVideo: hasVideo)
       //// self.incommingCall(from: username, connectionId: connectionId)
    }
    
    /// Display the incoming call to the user.
    public func displayIncomingCall(uuidString: String, handle: String, hasVideo: Bool = false, completion: ((Error?) -> Void)? = nil) {
        //self.providerDelegate?.reportIncomingCall(uuid: uuid, handle: handle, hasVideo: hasVideo, completion: completion)
        let uuid = UUID(uuidString: uuidString) ?? UUID()
        self.reportIncomingCall(uuid: uuid, handle: handle, hasVideo: hasVideo, completion: completion)
    }
    
  //  public func incommingCall(from: String, connectionId: String) {
        //   let update          = CXCallUpdate()
        //   update.remoteHandle = CXHandle(type: .generic, value: from)
          // update.hasVideo     = true
           
          // let uuid = UUID()
          // connectionIdRegistry[uuid] = .init(connectionId: connectionId, username: /from)
          // self.provider?.reportNewIncomingCall(with: uuid, update: update, completion: { (_) in })
      // }
    
    
    
}




extension CallKitVOIPPlugin {
    struct CallConfig {
        let connectionId: String
        let username    : String
    }
}

