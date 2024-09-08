export const idlFactory = ({ IDL }) => {
  return IDL.Service({
    'addOptionToPoll' : IDL.Func([IDL.Text], [IDL.Bool], []),
    'airDrop' : IDL.Func([IDL.Nat], [IDL.Bool], []),
    'register' : IDL.Func([], [IDL.Bool], []),
    'registerVote' : IDL.Func([IDL.Nat, IDL.Nat], [IDL.Bool], []),
    'removeUser' : IDL.Func([], [IDL.Bool], []),
  });
};
export const init = ({ IDL }) => { return []; };
