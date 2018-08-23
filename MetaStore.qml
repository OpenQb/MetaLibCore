import QbSql 1.0
import QtQuick 2.0

QbSql{
    id: objMetaStore

    function setup(){
        var vmap = objMetaStore.query("CREATE TABLE IF NOT EXISTS MetaStore("
                                      +" mid INTEGER PRIMARY KEY AUTOINCREMENT,"
                                      +" title VARCHAR(250) NOT NULL DEFAULT '',"
                                      +" tags VARCHAR(1024) NOT NULL DEFAULT '',"
                                      +" author VARCHAR(100) NOT NULL DEFAULT '',"
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


    function add(title,tags,author){
        var vmap = objMetaStore.preparedQuery(
                    "INSERT INTO MetaStore(title,tags,author) VALUES(:title,:tags,:author)",
                    [[":title",title],[":tags",tags],[":author",author]]);
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

    function get(mid){
        var vmap = objMetaStore.preparedQuery(
                    "SELECT * FROM MetaStore WHERE mid=:mid",
                    [
                        {"name":":mid","data":mid,"type":"integer"}
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

    function update(mid,title,tags,author){
        var vmap = objMetaStore.preparedQuery(
                    "UPDATE MetaStore SET utimestamp=(strftime('%s', 'now')), title=:title, tags=:tags, author=:author WHERE mid=:mid",
                    [
                        {"name":":mid","data":mid,"type":"integer"},
                        {"name":":title","data":title,"type":"string"},
                        {"name":":tags","data":tags,"type":"string"},
                        {"name":":author","data":author,"type":"string"}
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

    function remove(mid){
        var vmap = objMetaStore.preparedQuery(
                    "DELETE FROM MetaStore WHERE mid=:mid",
                    [
                        {"name":":mid","data":mid,"type":"integer"}
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

    function isExists(mid){
        var vmap = objMetaStore.preparedQuery(
                    "SELECT COUNT(*) FROM MetaStore WHERE mid=:mid",
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
