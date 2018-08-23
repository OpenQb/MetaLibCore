import QbSql 1.0
import QtQuick 2.0

QbSql{
    id: objMetaStore

    function setup(){
        var vmap = objKeyValueStore.query("CREATE TABLE IF NOT EXISTS MetaStore("
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



}
