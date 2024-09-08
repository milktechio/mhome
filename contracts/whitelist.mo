import Bool "mo:base/Bool";
import Principal "mo:base/Principal";
import HashMap "mo:base/HashMap";
import User "User";

/****modificaciones*****/
// Se sustituyo el contrato para almacentar solo el Principal
// de cada usuario, el privilegio de votar estara detercminado por su balance
//se convirtieron en clases las cuales tendran como contratoc entral main.mo
//Se añadieron funciones que modifican el balance

class Whitelist() {
    //HashMap para almacenar la whitelist
    var whitelist= HashMap.HashMap<Principal, User.User>(32,Principal.equal, Principal.hash); 

    //Funcion para añadir usuarios a la whitelist
    public func addUser(id: Principal) : Bool{
        let findUser = isWhitelisted(id);
        if(findUser == false){
            whitelist.put(id, User.User(id,0));
            return true;
        };
        return false;
    };

    //Funcion para obtener el usuario
    public func getUser(id : Principal) : ?User.User{
        return whitelist.get(id);
    };
 
    //Funcion para eliminar usuarios de la whitelist
    public func deleteUser(user :  Principal) : Bool {
        let findUser = isWhitelisted(user);
        if(findUser == true){
            whitelist.delete(user);
            return true;
        };
        return false;
    };

    public func getWhiteList() : HashMap.HashMap<Principal,User.User>{
        return whitelist;
    };

    public func hardSetwhitelist(new_hm : HashMap.HashMap<Principal,User.User>){
        whitelist := new_hm;
    };

    //Funcion para buscar usuarios
    private func isWhitelisted(user: Principal) : Bool {
        let isUser = whitelist.get(user);
        switch(isUser){
            case (?_){
                return true;
            };
            case (null){
                return false;
            };
        };
    };

   

    // DEBUG: Función para imprimir un hashmap completo
    public func printWhitelist() : Text {
        var result : Text = "";
        for ((user, _) in whitelist.entries()) {
            result := result # Principal.toText(user) # "\n";
        };
        return result;
    };

    /*/Discard
    //Funcion para eliminar privilegios de votacion
    public func rmVotingPr(user : Text) : async Bool {
        let findUser = await isWhitelisted(user);
        if(findUser == true){
            whitelist.put(user, false);
            return true;
        };
        return false;
    };
    */
};
