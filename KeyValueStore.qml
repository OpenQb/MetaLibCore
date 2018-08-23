import QbSql 1.0
import QtQuick 2.0


QbSql {
    id: objKeyValueStore

    function setup(){
        var vmap = objKeyValueStore.query("CREATE TABLE IF NOT EXISTS KeyValueStore(kid INTEGER PRIMARY KEY AUTOINCREMENT, key VARCHAR(250) NOT NULL UNIQUE, value TEXT DEFAULT '')");
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
        if(key === undefined || key === null || key==="") return false;
        if(value === undefined || value === null) value = "";
        var vmap = objKeyValueStore.preparedQuery("INSERT INTO KeyValueStore(key,value) VALUES(:key,:value)",[[":key",key],[":value",value]]);
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

    function get(key,value){
        if(value === undefined || value === null) value = "";
        var vmap = objKeyValueStore.preparedQuery("SELECT * FROM KeyValueStore WHERE key=:key",[[":key",key]]);
        var dval = "";
        var isFound = false;
        try{
            if(vmap["status"] === "OK"){
                dval = vmap["data"][0]["value"];
            }
        }
        catch(e){
        }

        if(dval === "") return value;
        else return dval;
    }

    function update(key,value){
        if(key === undefined || key === null || key==="") return false;
        if(value === undefined || value === null) value = "";
        var vmap = objKeyValueStore.preparedQuery("UPDATE KeyValueStore SET value=:value WHERE key=:key",[[":key",key],[":value",value]]);
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

    function isKeyExists(key){
        var vmap = objKeyValueStore.preparedQuery("SELECT COUNT(*) FROM KeyValueStore WHERE key=:key",[[":key",key]]);
        //console.log(JSON.stringify(vmap));
        var isFound = false;
        try{
            if(vmap["status"] === "OK"){
                if(vmap["data"][0]["COUNT(*)"] === 1) isFound = true;
            }
        }
        catch(e){
        }

        return isFound;
    }
}
