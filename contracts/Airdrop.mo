import Principal "mo:base/Principal";
import HashMap "mo:base/HashMap";
import Whitelist "whitelist";
import User "User";

//la resta se hace desde el actor
class Airdrop(total_tokens : Nat){
    var local_tokens = total_tokens;
    //añade amount tokens a los usuarios en whithe list
       public func airDrop(amount : Nat, wl : HashMap.HashMap<Principal,User.User>): (?HashMap.HashMap<Principal,User.User>,Nat){
        for(user in wl.vals()) {
            if(amount > local_tokens)return (null, local_tokens);
            let _ =user.addBalance(amount);
            local_tokens:=local_tokens-amount;
        };
        return (?wl,total_tokens);
    };
}