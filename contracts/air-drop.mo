import Principal "mo:base/Principal";
import Array "mo:base/Array";


//sin testear
actor airdrop{
   // let owner = Principal.fromText("_____OWNER______");
    type Balance ={
        id: Principal;
        var tokens: Nat;
    };

    stable var balances_users : [Balance] = [];
    stable var total_tokens = 100000;


    public shared(msg) func airDrop(targets : [(Principal, Nat)]):async(){
       // assert(msg.caller == owner);
        for((user_id, amount) in targets.vals()) {
            let user_balance = get_balance(msg.caller);
            user_balance.tokens += amount;
            total_tokens-=amount;
        };

    };

    public query func getBalanceOf(id: Principal): async Nat{
        let balance = get_balance(id);
        return balance.tokens;
    };
    
    public shared(msg) func getBalance(): async Nat{
        let balance = get_balance(msg.caller);
        return balance.tokens;
    };

    private func get_balance(id: Principal) : Balance{
        let id_balance: ?Nat = Array.indexOf<Balance>({ id = id; var tokens = 0 }, balances_users, func(x, i) { x.id == i.id});
        switch(id_balance){
            case(?id_user){
                return balances_users[id_user];
            };
            case(null){
                let new_user_balance = create_new_user_balance(id);
                balances_users := Array.append<Balance>(balances_users,[new_user_balance]);
                return new_user_balance;
            }
        }
    };

    private func create_new_user_balance(id: Principal) : Balance{
        let new_user_balance : Balance = {
            id = id;
            var tokens= 0;
        };
        return new_user_balance;
    }; 

}