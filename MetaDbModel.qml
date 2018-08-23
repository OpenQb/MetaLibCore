import QtQuick 2.0

Item {
    id: objMetaDbModel

    property string dbPath;


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
        console.log("dbPath:",objMetaDbModel.dbPath)
    }
}
