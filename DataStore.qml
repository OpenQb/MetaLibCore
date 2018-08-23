import QbSql 1.0
import QtQuick 2.0

QbSql{
    id: objDataStore

    function setup(){
        var vmap = objDataStore.query("CREATE TABLE IF NOT EXISTS DataStore("
                                      +" did INTEGER PRIMARY KEY AUTOINCREMENT,"
                                      +" mid INT NOT NULL DEFAULT 0,"
                                      +" path TEXT NOT NULL UNIQUE,"
                                      +" data BLOB NOT NULL DEFAULT '',"
                                      +" utimestamp INT NOT NULL DEFAULT(strftime('%s', 'now')),"
                                      +" ctimestamp INT NOT NULL DEFAULT(strftime('%s', 'now'))"
                                      +")");
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


    function add(mid, path, data){
        var vmap = objDataStore.preparedQuery(
                    "INSERT INTO DataStore(mid,path,data) VALUES(:mid,:path,:data)",
                    [
                        {"name":":mid","data":mid,"type":"integer"},
                        {"name":":path","data":path,"type":"text"},
                        {"name":":data","data":data,"type":"binary"}
                    ]
                    );
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

    function get(did){
        var vmap = objDataStore.preparedQuery(
                    "SELECT * FROM DataStore WHERE did=:did",
                    [
                        {"name":":did","data":did,"type":"integer"}
                    ]
                    );
        try{
            if(vmap["status"] === "OK"){
                if(vmap["data"][0] === undefined) return {};
                return vmap["data"][0];
            }
        }
        catch(e){
        }

        return {};
    }

    function update(did,mid,path,data){
        var vmap = objDataStore.preparedQuery(
                    "UPDATE DataStore SET utimestamp=(strftime('%s', 'now')), mid=:mid, path=:path, data=:data WHERE did=:did",
                    [
                        {"name":":did", "data":did, "type":"integer"},
                        {"name":":mid","data":mid,"type":"integer"},
                        {"name":":path","data":path,"type":"text"},
                        {"name":":data","data":data,"type":"binary"}
                    ]
                    );
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

    function remove(did){
        var vmap = objDataStore.preparedQuery(
                    "DELETE FROM DataStore WHERE did=:did",
                    [
                        {"name":":did","data":did,"type":"integer"}
                    ]
                    );
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

    function isExists(did){
        var vmap = objDataStore.preparedQuery(
                    "SELECT COUNT(*) FROM DataStore WHERE did=:did",
                    [
                        {"name":":did","data":did,"type":"integer"}
                    ]
                    );
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

    function isMIDExists(mid){
        var vmap = objDataStore.preparedQuery(
                    "SELECT COUNT(*) FROM DataStore WHERE mid=:mid",
                    [
                        {"name":":mid","data":mid,"type":"integer"}
                    ]
                    );
        var isFound = false;
        try{
            if(vmap["status"] === "OK"){
                if(vmap["data"][0]["COUNT(*)"] > 0) isFound = true;
            }
        }
        catch(e){
        }

        return isFound;
    }

}
