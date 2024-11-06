import Principal "mo:base/Principal";
import SHM "libs/FunctionalStableHashMap";
import SB "libs/StableBuffer";
import Text "mo:base/Text";
import Blob "mo:base/Blob";
import Poll "polls";
import Whitelist "whitelist";
import User "User";
import Airdrop "Airdrop";
actor Main {
   /*****TODO LO STABLE VA ACA*******/
   stable let whitelist = SHM.init<Principal,User.User>();
   stable let polls = SB.init<Poll.Poll>();
   stable var tokens_amount : Nat = 100000;

   let owner : Principal = Principal.fromText("otpyl-647cy-xr3ji-3bjmd-zs5h3-iu4so-jfu4b-cbjtl-bipcl-xdu7h-2ae");
  
   let whitelistOps = Whitelist.Whitelist(whitelist);
   let pollOps = Poll.PollOps(polls);
   let userOps = User.UserOps();
   let airdrop = Airdrop.Airdrop(userOps);

   public query func say(phrase : Text) : async Text {
      return phrase;
   };

   public query func getUser() : async Text {
      return whitelistOps.printWhitelist()
   };

   public query func getPolls() : async [Text]{
      return pollOps.getAllPollsName();
   };

   /**********************CALLER**************************/

   //esta funcion de de alta a quien la llame
   public func register(principal : Text) : async Bool {
      return whitelistOps.addUser(Principal.fromText(principal)); //false s ya existe
   };

   //esta funcion elimina a quien la llame
   public shared (msg) func removeUser() : async Bool {
      return whitelistOps.deleteUser(msg.caller);
   };

   //resgtra n votos por id opcion (el usuario no se guarda, voto sera anonimo)
   public shared (msg) func registerVote(idPoll : Nat, idOpt : Nat, amount : Nat) : async Bool {
      switch (whitelistOps.getUser(msg.caller)) {
         case (?user) {
            userOps.removeBalance(user,amount);
            return pollOps.addVoteFor(idPoll, idOpt, amount);
         };
         case (null) {
            return false;
         };
      };
   };

   /**********************OWNER****************************/
   // Agrega un conjunto de opciones a una votación
   public shared (msg) func addOptionToPoll(voteName : Text, optionNames : [Text]) : async Bool {
      if (msg.caller == owner) {
         return pollOps.addOptions(voteName, optionNames);
      };
      return false;
   };

   public shared (msg) func airDrop(amount : Nat) : async Bool {
      if (msg.caller == owner) {
         let (res_tokens, success) = airdrop.airDrop(tokens_amount, amount, whitelistOps.getWhiteList());
         tokens_amount := res_tokens;
         return success;
      };
      return false;
   };
   
};