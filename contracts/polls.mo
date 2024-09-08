import Array "mo:base/Array";
import Nat "mo:base/Nat";
import Iter "mo:base/Iter";
import Principal "mo:base/Principal";
import Option "mo:base/Option";
import Debug "mo:base/Debug";
import Buffer "mo:base/Buffer";
import Whitelist "whitelist";

type Option = {
        id : Nat;
        name : Text;
        var votes : Nat;
};

class Poll(){
    var poll = Buffer.Buffer<Option>(32);
    
    public func addOption(name: Text) : Bool{
            let new_option : Option = {id = poll.size();name = name; var votes = 0};
            poll.add(new_option);
            return true;
        return false;
    };

    public func addVoteFor(idOption: Nat, amountVotes : Nat) : Bool{
        let testOption = poll.getOpt(idOption);
        switch(testOption){
            case (?option){
                option.votes+=amountVotes;
                return true;
            };
            case (null){
                return false;
            }
        }
    };

    public func getOptions() : [Option]{
        return Buffer.toArray(poll);
    }
};
