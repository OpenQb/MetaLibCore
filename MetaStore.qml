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
                                          +" udate INT NOT NULL DEFAULT(strftime('%s', 'now')),"
                                          +" cdate INT NOT NULL DEFAULT(strftime('%s', 'now'))"
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

    function update(mid,title,tags,author){
        var vmap = objMetaStore.preparedQuery(
                    "UPDATE MetaStore SET udate=(strftime('%s', 'now')),title=:title,tags=:tags,author=:author WHERE mid=:mid)",
                    [[":title",title],[":tags",tags],[":author",author],[":mid",mid]]);
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
                    "DELETE FROM MetaStore WHERE mid=:mid)",
                    [[":mid",mid]]);
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



}
