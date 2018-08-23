import QtQuick 2.0

Item {
    id: objMetaDbModel

    property string dbPath;
    property bool isReady:false;

    signal error(string errorText);


    MetaStore{
        id: objMS
    }
    JsonStore{
        id: objJS
    }
    DataStore{
        id: objDS
    }
    KeyValueStore{
        id: objKVS
    }

    Component.onCompleted: {
        if(objMetaDbModel.dbPath === "" || objMetaDbModel.dbPath===null || objMetaDbModel.dbPath===undefined) return;

        // database setup
        objMS.setDbPath(objMetaDbModel.dbPath);
        objJS.setDbPath(objMetaDbModel.dbPath);
        objDS.setDbPath(objMetaDbModel.dbPath);
        objKVS.setDbPath(objMetaDbModel.dbPath);

        // table setup
        if(!objMS.setup())
        {
            objMetaDbModel.error("Failed to setup MetaStore database.");
            return;
        }
        if(!objJS.setup())
        {
            objMetaDbModel.error("Failed to setup JsonStore database.");
            return;
        }
        if(!objDS.setup())
        {
            objMetaDbModel.error("Failed to setup DataStore database.");
            return;
        }
        if(!objKVS.setup())
        {
            objMetaDbModel.error("Failed to setup KeyValueStore database.");
            return;
        }



        objMetaDbModel.isReady = true;
    }
}
