#import <Foundation/Foundation.h>
#import <Capacitor/Capacitor.h>

// Define the plugin using the CAP_PLUGIN Macro, and
// each method the plugin supports using the CAP_PLUGIN_METHOD macro.
CAP_PLUGIN(CallKitVOIPPlugin, "CallKitVOIP",
           CAP_PLUGIN_METHOD(echo, CAPPluginReturnPromise);
            CAP_PLUGIN_METHOD(register, CAPPluginReturnPromise);
            CAP_PLUGIN_METHOD(notifyEvent, CAPPluginReturnPromise);
            CAP_PLUGIN_METHOD(startCall, CAPPluginReturnPromise);
            CAP_PLUGIN_METHOD(connectCall, CAPPluginReturnPromise);
            CAP_PLUGIN_METHOD(activateAudioSession, CAPPluginReturnPromise);
            CAP_PLUGIN_METHOD(endCall, CAPPluginReturnPromise);
            CAP_PLUGIN_METHOD(displayIncommingCall, CAPPluginReturnPromise);
           CAP_PLUGIN_METHOD(handleAnswer, CAPPluginReturnPromise);
           
           
)
