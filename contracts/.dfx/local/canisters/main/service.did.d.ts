import type { Principal } from '@dfinity/principal';
import type { ActorMethod } from '@dfinity/agent';
import type { IDL } from '@dfinity/candid';

export interface Option { 'id' : bigint, 'name' : string }
export interface SharedBuffer { 'count' : bigint, 'elems' : Array<SharedPoll> }
export interface SharedPoll {
  'id' : bigint,
  'status' : string,
  'votes' : Array<bigint>,
  'name' : string,
  'options' : Array<Option>,
}
export interface SharedUser {
  'id' : Principal,
  'status' : string,
  'balance' : bigint,
}
export interface SharedWhiteList {
  'shwhitelist' : Array<SharedUser>,
  'count' : bigint,
}
export interface _SERVICE {
  'addOptiontoPoll' : ActorMethod<[bigint, string], [] | [SharedPoll]>,
  'airDrop' : ActorMethod<[bigint], [] | [SharedWhiteList]>,
  'createPoll' : ActorMethod<[string, Array<string>], SharedPoll>,
  'getPollById' : ActorMethod<[bigint], SharedPoll>,
  'getPolls' : ActorMethod<[], SharedBuffer>,
  'getUserBy' : ActorMethod<[string], SharedUser>,
  'register' : ActorMethod<[string], SharedUser>,
  'registerVote' : ActorMethod<[bigint, bigint, bigint], SharedPoll>,
  'removeOptionToPoll' : ActorMethod<[bigint, bigint], [] | [SharedPoll]>,
  'removePoll' : ActorMethod<[bigint], [] | [SharedPoll]>,
  'removeUser' : ActorMethod<[], SharedUser>,
  'renamePoll' : ActorMethod<[bigint, string], [] | [SharedPoll]>,
  'say' : ActorMethod<[string], string>,
}
export declare const idlFactory: IDL.InterfaceFactory;
export declare const init: (args: { IDL: typeof IDL }) => IDL.Type[];
