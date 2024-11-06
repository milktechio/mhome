import type { Principal } from '@dfinity/principal';
import type { ActorMethod } from '@dfinity/agent';
import type { IDL } from '@dfinity/candid';

export interface _SERVICE {
  'addOptionToPoll' : ActorMethod<[string, Array<string>], boolean>,
  'airDrop' : ActorMethod<[bigint], boolean>,
  'getPolls' : ActorMethod<[], Array<string>>,
  'getUser' : ActorMethod<[], string>,
  'register' : ActorMethod<[string], boolean>,
  'registerVote' : ActorMethod<[bigint, bigint, bigint], boolean>,
  'removeUser' : ActorMethod<[], boolean>,
  'say' : ActorMethod<[string], string>,
}
export declare const idlFactory: IDL.InterfaceFactory;
export declare const init: (args: { IDL: typeof IDL }) => IDL.Type[];
