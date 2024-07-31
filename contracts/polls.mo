import Array "mo:base/Array";
import Nat "mo:base/Nat";
import Iter "mo:base/Iter";
import Principal "mo:base/Principal";
import Option "mo:base/Option";
import Debug "mo:base/Debug";
actor votacion {
    //tipos
    type User = {
        id : Principal;
        var paint_thumb : Bool;
        var added_option : Bool;
    };
    type Option = {
        name: Text;
        var votes: Nat;
    };

    //contenedores
    stable var users : [User] = [];
    stable var options : [Option] = [];

    public shared(msg) func addOption(option_name: Text) : async (Bool,Text){
        let user : User = get_user(msg.caller);
        if(user.added_option)return (false,"Ya añadiste una opcion");
        options := Array.append<Option>(options,[{name=option_name; var votes=0}]);
        user.added_option := true;
        return (true,"Opcion:"  # option_name # " registrada");
    };

    public shared(msg) func register_vote(option_name : Text) : async (Bool, Text){
        let user : User = get_user(msg.caller);
        let id_option = find_id_option_by_name(option_name);
        switch(id_option){
            case(?id_option){
                if(user.paint_thumb)return (false,"Err: Ya votaste");
                options[id_option].votes+=1;
                user.paint_thumb:=true;
                return (true,"Voto registrado para: " # options[id_option].name);
            };
            case(null){
                return (false,"Err: Opcion: "# option_name #" no registrada");
            };
        };
        return (false,"Err: Ocurrio algun error inesperado");
    };

    //para mantener la mutabilidad dentro del contrato se retorna una tupla
    public query func get_results() : async [(Text,Nat)] {
        var results : [(Text, Nat)] = [];
        for(j in Iter.range(0,Array.size<Option>(options)-1)){
            results := Array.append<(Text,Nat)>(results,[(options[j].name,options[j].votes)]);
        };
        return results;
    };
    //para mantener la mutabilidad dentro del contrato se retorna una tupla
    public query func get_options() : async [Text] {
        var results : [Text] = [];
        for(j in Iter.range(0,Array.size<Option>(options)-1)){
            results := Array.append<Text>(results,[(options[j].name)]);
        };
        return results;
    };
 
    private func get_user(id: Principal) : User{
        let id_user : ?Nat = Array.indexOf<User>({ id = id; var paint_thumb = false; var added_option = false }, users, func(x, i) { x.id == i.id});
        switch(id_user){
            case(?id_user){
                return users[id_user];
            };
            case(null){
                let new_user = create_new_user(id);
                users := Array.append<User>(users,[new_user]);
                return new_user;
            }
        }
    };

    private func create_new_user(id: Principal) : User{
        let new_user : User = {
            id = id;
            var paint_thumb = false;
            var added_option = false;
        };
        return new_user;
    };
  
    private func find_id_option_by_name(name: Text):?Nat{
        let index_option : ?Nat = Array.indexOf<Option>({name =name;var votes=0}, options, func(x, element) { x.name == element.name });
        return index_option;
    };
};
