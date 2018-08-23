import QbSql 1.0
import QtQuick 2.0

QbSql{
    id: objJsonStore

    function setup(){
        var vmap = objJsonStore.query("CREATE TABLE IF NOT EXISTS JsonStore("
                                      +" jid INTEGER PRIMARY KEY AUTOINCREMENT,"
                                      +" mid INT NOT NULL DEFAULT 0,"
                                      +" json TEXT NOT NULL DEFAULT '',"
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


    function add(mid,json){
        var vmap = objJsonStore.preparedQuery(
                    "INSERT INTO JsonStore(mid,json) VALUES(:mid,:json)",
                    [
                        {"name":":mid","data":mid,"type":"integer"},
                        {"name":":json","data":json,"type":"text"}
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

    function get(jid){
        var vmap = objJsonStore.preparedQuery(
                    "SELECT * FROM JsonStore WHERE jid=:jid",
                    [
                        {"name":":jid","data":jid,"type":"integer"}
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

    function update(jid,mid,json){
        var vmap = objJsonStore.preparedQuery(
                    "UPDATE JsonStore SET utimestamp=(strftime('%s', 'now')), mid=:mid, json=:json WHERE jid=:jid",
                    [
                        {"name":":jid", "data":jid, "type":"integer"},
                        {"name":":mid", "data":mid, "type":"integer"},
                        {"name":":json", "data":json, "type":"text"}
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

    function remove(jid){
        var vmap = objJsonStore.preparedQuery(
                    "DELETE FROM JsonStore WHERE jid=:jid",
                    [
                        {"name":":jid","data":jid,"type":"integer"}
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

    function isExists(jid){
        var vmap = objJsonStore.preparedQuery(
                    "SELECT COUNT(*) FROM JsonStore WHERE jid=:jid",
                    [
                        {"name":":jid","data":jid,"type":"integer"}
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
        var vmap = objJsonStore.preparedQuery(
                    "SELECT COUNT(*) FROM JsonStore WHERE mid=:mid",
                    [
                        {"name":":mid","data":mid,"type":"integer"}
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

}
