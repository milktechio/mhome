import Text "mo:base/Text";
import HashMap "mo:base/HashMap";
import Bool "mo:base/Bool";

actor class Whitelist (user : Text){

    type User = Text;

    //HashMap para almacenar la whitelist
    var whitelist = HashMap.HashMap<User, Bool>(10, Text.equal, Text.hash);

    //Funcion para añadir usuarios a la whitelist
    public func addUser(user : User) : async Bool{
        let findUser = await isWhitelisted(user);
        if(findUser == false){
            whitelist.put(user, true);
            return true;
        };
        return false;
    };

    //Funcion para buscar usuarios
    public query func isWhitelisted(user: User) : async Bool {
        let isUser = whitelist.get(user);
        if (isUser != null){
            return true;
        };
        return false;
    };

    //Funcion para eliminar usuarios de la whitelist
    public func deleteUser(user : Text) : async Bool {
        let findUser = await isWhitelisted(user);
        if(findUser == true){
            whitelist.delete(user);
            return true;
        };
        return false;
    };

    // Función para imprimir un hashmap completo
    public query func printWhitelist() : async Text {
        var result : Text = "";
        for ((user, _) in whitelist.entries()) {
            result := result # user # "\n";
        };
        return result;
    };

    //Funcion para eliminar privilegios de votacion
    public func rmVotingPr(user : Text) : async Bool {
        let findUser = await isWhitelisted(user);
        if(findUser == true){
            whitelist.put(user, false);
            return true;
        };
        return false;
    };
};