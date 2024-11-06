export const idlFactory = ({ IDL }) => {
  return IDL.Service({
    'addOptionToPoll' : IDL.Func([IDL.Text, IDL.Vec(IDL.Text)], [IDL.Bool], []),
    'airDrop' : IDL.Func([IDL.Nat], [IDL.Bool], []),
    'getPolls' : IDL.Func([], [IDL.Vec(IDL.Text)], ['query']),
    'getUser' : IDL.Func([], [IDL.Text], ['query']),
    'register' : IDL.Func([IDL.Text], [IDL.Bool], []),
    'registerVote' : IDL.Func([IDL.Nat, IDL.Nat, IDL.Nat], [IDL.Bool], []),
    'removeUser' : IDL.Func([], [IDL.Bool], []),
    'say' : IDL.Func([IDL.Text], [IDL.Text], ['query']),
  });
};
export const init = ({ IDL }) => { return []; };
