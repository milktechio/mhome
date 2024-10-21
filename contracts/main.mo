import Principal "mo:base/Principal";
import HashMap "mo:base/HashMap";
import Text "mo:base/Text";
import Polls "polls";
import Whitelist "whitelist";
import User "User";
import Airdrop "Airdrop";
actor Main {
   let owner : Principal = Principal.fromText("otpyl-647cy-xr3ji-3bjmd-zs5h3-iu4so-jfu4b-cbjtl-bipcl-xdu7h-2ae");
   stable var tokens_amount : Nat = 10000;
   let whitelist = Whitelist.Whitelist();
   let poll = Polls.Poll();
   let airdrop = Airdrop.Airdrop(tokens_amount);

   public query func say(phrase : Text) : async Text {
      return phrase;
   };

   public query func getUser() : async Text {
      return whitelist.printWhitelist()
   };

   /**********************CALLER**************************/

   //esta funcion de de alta a quien la llame
   public shared (msg) func register() : async Bool {
      return whitelist.addUser(msg.caller); //false s ya existe
   };

   //esta funcion elimina a quien la llame
   public shared (msg) func removeUser() : async Bool {
      return whitelist.deleteUser(msg.caller);
   };

   //resgtra n votos por id opcion (el usuario no se guarda, voto sera anonimo)
   public shared (msg) func registerVote(id : Nat, amount : Nat) : async Bool {
      switch (whitelist.getUser(msg.caller)) {
         case (?user) {
            user.removeBalance(amount);
            return poll.addVoteFor(id, amount);
         };
         case (null) {
            return false;
         };
      };
   };

   /**********************OWNER****************************/
   public shared (msg) func addOptionToPoll(name : Text) : async Bool {
      if (msg.caller == owner) {
         return poll.addOption(name);
      };
      return false;
   };

   public shared (msg) func airDrop(amount : Nat) : async Bool {
      if (msg.caller == owner) {
         let (after, res_tokens) = airdrop.airDrop(amount, whitelist.getWhiteList());
         switch (after) {
            case (?after) {
               whitelist.hardSetwhitelist(after);
               tokens_amount := res_tokens;
               return true;
            };
            case (null) {
               return false;
            };
         };
      };
      return true;
   };
};
