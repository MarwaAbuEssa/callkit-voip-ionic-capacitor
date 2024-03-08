# callkit-voip-capacitor

Integrate CallKit

## Install

```bash
npm install callkit-voip-capacitor
npx cap sync
```

## API

<docgen-index>

* [`register()`](#register)
* [`startCall(...)`](#startcall)
* [`activateAudioSession()`](#activateaudiosession)
* [`connectCall(...)`](#connectcall)
* [`endCall(...)`](#endcall)
* [`displayIncommingCall(...)`](#displayincommingcall)
* [`handleAnswer(...)`](#handleanswer)
* [`testin(...)`](#testin)
* [`addListener(...)`](#addlistener)
* [`addListener(...)`](#addlistener)
* [`addListener(...)`](#addlistener)
* [`echo(...)`](#echo)
* [`echo2(...)`](#echo2)
* [Interfaces](#interfaces)

</docgen-index>

<docgen-api>
<!--Update the source file JSDoc comments and rerun docgen to update the docs below-->

### register()

```typescript
register() => any
```

**Returns:** <code>any</code>

--------------------


### startCall(...)

```typescript
startCall(options: { uuidString?: string; handleString: string; contactIdentifier: string; hasVideo: Boolean; }) => any
```

| Param         | Type                                                                                                  |
| ------------- | ----------------------------------------------------------------------------------------------------- |
| **`options`** | <code>{ uuidString?: string; handleString: string; contactIdentifier: string; hasVideo: any; }</code> |

**Returns:** <code>any</code>

--------------------


### activateAudioSession()

```typescript
activateAudioSession() => any
```

**Returns:** <code>any</code>

--------------------


### connectCall(...)

```typescript
connectCall(options: { uuidString: string; }) => any
```

| Param         | Type                                 |
| ------------- | ------------------------------------ |
| **`options`** | <code>{ uuidString: string; }</code> |

**Returns:** <code>any</code>

--------------------


### endCall(...)

```typescript
endCall(options: { uuidString: string; }) => any
```

| Param         | Type                                 |
| ------------- | ------------------------------------ |
| **`options`** | <code>{ uuidString: string; }</code> |

**Returns:** <code>any</code>

--------------------


### displayIncommingCall(...)

```typescript
displayIncommingCall(options: { uuidString: string; handleString: string; contactIdentifier: string; hasVideo: Boolean; }) => any
```

| Param         | Type                                                                                                 |
| ------------- | ---------------------------------------------------------------------------------------------------- |
| **`options`** | <code>{ uuidString: string; handleString: string; contactIdentifier: string; hasVideo: any; }</code> |

**Returns:** <code>any</code>

--------------------


### handleAnswer(...)

```typescript
handleAnswer(options: { uuidString: string; }) => any
```

| Param         | Type                                 |
| ------------- | ------------------------------------ |
| **`options`** | <code>{ uuidString: string; }</code> |

**Returns:** <code>any</code>

--------------------


### testin(...)

```typescript
testin(options: { uuidString?: string; handleString: string; contactIdentifier: string; hasVideo: Boolean; }) => any
```

| Param         | Type                                                                                                  |
| ------------- | ----------------------------------------------------------------------------------------------------- |
| **`options`** | <code>{ uuidString?: string; handleString: string; contactIdentifier: string; hasVideo: any; }</code> |

**Returns:** <code>any</code>

--------------------


### addListener(...)

```typescript
addListener(eventName: 'registration', listenerFunc: (token: Token) => void) => Promise<PluginListenerHandle> & PluginListenerHandle
```

| Param              | Type                                                        |
| ------------------ | ----------------------------------------------------------- |
| **`eventName`**    | <code>"registration"</code>                                 |
| **`listenerFunc`** | <code>(token: <a href="#token">Token</a>) =&gt; void</code> |

**Returns:** <code>any</code>

--------------------


### addListener(...)

```typescript
addListener(eventName: 'callAnswered', listenerFunc: (callDate: CallData) => void) => Promise<PluginListenerHandle> & PluginListenerHandle
```

| Param              | Type                                                                 |
| ------------------ | -------------------------------------------------------------------- |
| **`eventName`**    | <code>"callAnswered"</code>                                          |
| **`listenerFunc`** | <code>(callDate: <a href="#calldata">CallData</a>) =&gt; void</code> |

**Returns:** <code>any</code>

--------------------


### addListener(...)

```typescript
addListener(eventName: 'callStarted', listenerFunc: (callDate: CallData) => void) => Promise<PluginListenerHandle> & PluginListenerHandle
```

| Param              | Type                                                                 |
| ------------------ | -------------------------------------------------------------------- |
| **`eventName`**    | <code>"callStarted"</code>                                           |
| **`listenerFunc`** | <code>(callDate: <a href="#calldata">CallData</a>) =&gt; void</code> |

**Returns:** <code>any</code>

--------------------


### echo(...)

```typescript
echo(options: { value: string; }) => any
```

| Param         | Type                            |
| ------------- | ------------------------------- |
| **`options`** | <code>{ value: string; }</code> |

**Returns:** <code>any</code>

--------------------


### echo2(...)

```typescript
echo2(options: { value: string; }) => any
```

| Param         | Type                            |
| ------------- | ------------------------------- |
| **`options`** | <code>{ value: string; }</code> |

**Returns:** <code>any</code>

--------------------


### Interfaces


#### CallData

| Prop         | Type                |
| ------------ | ------------------- |
| **`callId`** | <code>string</code> |


#### Token

| Prop        | Type                |
| ----------- | ------------------- |
| **`token`** | <code>string</code> |


#### PluginListenerHandle

| Prop         | Type                      |
| ------------ | ------------------------- |
| **`remove`** | <code>() =&gt; any</code> |

</docgen-api>
