import { registerPlugin } from '@capacitor/core';

import type { CallKitVOIPPlugin } from './definitions';

// const CallKitVOIP = registerPlugin<CallKitVOIPPlugin>('CallKitVOIP', {
//   web: () => import('./web').then(m => new m.CallKitVOIPWeb()),
// });
const CallKitVOIP = registerPlugin<CallKitVOIPPlugin>('CallKitVOIP');
//, {
//  web: () => import('./web').then(m => new m.CallKitVOIPWeb()),
//});
export * from './definitions';
export { CallKitVOIP };
