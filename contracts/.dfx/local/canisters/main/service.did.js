export const idlFactory = ({ IDL }) => {
  const Option = IDL.Record({ 'id' : IDL.Nat, 'name' : IDL.Text });
  const SharedPoll = IDL.Record({
    'id' : IDL.Nat,
    'status' : IDL.Text,
    'votes' : IDL.Vec(IDL.Nat),
    'name' : IDL.Text,
    'options' : IDL.Vec(Option),
  });
  const SharedUser = IDL.Record({
    'id' : IDL.Principal,
    'status' : IDL.Text,
    'balance' : IDL.Nat,
  });
  const SharedWhiteList = IDL.Record({
    'shwhitelist' : IDL.Vec(SharedUser),
    'count' : IDL.Nat,
  });
  const SharedBuffer = IDL.Record({
    'count' : IDL.Nat,
    'elems' : IDL.Vec(SharedPoll),
  });
  return IDL.Service({
    'addOptiontoPoll' : IDL.Func(
        [IDL.Nat, IDL.Text],
        [IDL.Opt(SharedPoll)],
        [],
      ),
    'airDrop' : IDL.Func([IDL.Nat], [IDL.Opt(SharedWhiteList)], []),
    'createPoll' : IDL.Func([IDL.Text, IDL.Vec(IDL.Text)], [SharedPoll], []),
    'getPollById' : IDL.Func([IDL.Nat], [SharedPoll], ['query']),
    'getPolls' : IDL.Func([], [SharedBuffer], ['query']),
    'getUserBy' : IDL.Func([IDL.Text], [SharedUser], ['query']),
    'register' : IDL.Func([IDL.Text], [SharedUser], []),
    'registerVote' : IDL.Func([IDL.Nat, IDL.Nat, IDL.Nat], [SharedPoll], []),
    'removeOptionToPoll' : IDL.Func(
        [IDL.Nat, IDL.Nat],
        [IDL.Opt(SharedPoll)],
        [],
      ),
    'removePoll' : IDL.Func([IDL.Nat], [IDL.Opt(SharedPoll)], []),
    'removeUser' : IDL.Func([], [SharedUser], []),
    'renamePoll' : IDL.Func([IDL.Nat, IDL.Text], [IDL.Opt(SharedPoll)], []),
    'say' : IDL.Func([IDL.Text], [IDL.Text], ['query']),
  });
};
export const init = ({ IDL }) => { return []; };
