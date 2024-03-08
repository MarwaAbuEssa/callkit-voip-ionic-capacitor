
import type {PluginListenerHandle} from "@capacitor/core";
export interface CallKitVOIPPlugin {
  register(): Promise<void>;
  //startCall (uuidString?:string, handleString:string, contactIdentifier:string, hasVideo :Boolean) : Promise<void>;
  startCall (options :{uuidString?:string, handleString:string, contactIdentifier:string, hasVideo :Boolean}) : Promise<{callDate: CallData}>//Promise<void>;
  //startCall (options :{uuidString?:string, handleString:string, contactIdentifier:string, hasVideo :Boolean}) : Promise<{ callDate: CallData }>;
  activateAudioSession() : Promise<{ value: string }>;
  connectCall (options :{uuidString:string}) : Promise<{ value: string }>;
  endCall (options :{uuidString:string}) : Promise<{ value: string }>;
  displayIncommingCall (options :{uuidString:string, handleString:string, contactIdentifier:string, hasVideo :Boolean}) : Promise<{callUUID: string}>;
  handleAnswer(options :{uuidString:string}) : Promise<{callUUID: string}>;
  testin (options :{uuidString?:string, handleString:string, contactIdentifier:string, hasVideo :Boolean}) : Promise<{callDate: CallData}>//Promise<void>;
  //notifyEvent(eventName:string,uuidString:string) : Promise<{ value: string }>;
  addListener(
    eventName: 'registration',
    listenerFunc: (token:Token)   => void
  ): Promise<PluginListenerHandle> & PluginListenerHandle;

  addListener(
    eventName: 'callAnswered',
    listenerFunc: (callDate: CallData)  => void
  ): Promise<PluginListenerHandle> & PluginListenerHandle;

  addListener(
    eventName: 'callStarted',
    listenerFunc: (callDate: CallData) => void
  ): Promise<PluginListenerHandle> & PluginListenerHandle;
  echo(options: { value: string }): Promise<{ value: string }>;
  echo2(options: { value: string }): Promise<{ value: string }>;
}


export declare interface Token{token: string}
export declare interface CallData{
  callId :string
  // connectionId  :   string
  // username      ?:  string
}
