//El balance debe ser retornado para poder almacenarlo en un stable
//Cuando se actualiza obtinene el balance (st_balance) por stable
class User(id: Principal, st_balance : Nat){
    var balance : Nat = st_balance;
    public func addBalance(amount : Nat) : (){
        balance+=amount;
    };
    public func removeBalance(amount : Nat) : (){
        balance-=amount;
    };
    public func getBalance() : Nat{
        return balance;
    }
}
