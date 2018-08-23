import QbSql 1.0
import QtQuick 2.0


QbSql {
    id: objKeyValueStore

    function setup(){
        var vmap = objKeyValueStore.query("CREATE TABLE IF NOT EXISTS KeyValueStore(kid INTEGER PRIMARY KEY AUTOINCREMENT, key VARCHAR(250) NOT NULL, value TEXT DEFAULT '')");
        var isOK = false;
        try{
            if(vmap["status"] === "OK"){
                isOK = true;
            }
        }
        catch(e){
        }
        return isOK;
    }

    function set(key,value){
    }

    function get(key,value){
    }

    function isKeyExists(key){
    }
}
