import QtQuick 2.0

Item {
    id: objMetaDbModel

    property string dbPath;
    property bool isReady:false;

    property alias model: objMainModel

    property int itemPerPage: 100;
    property int itemHeight: 50; // used when in listView

    property int thumbnailWidth: 100; // used when in gridView
    property int thumbnailHeight: 100; // used when in gridView
    property int maxGridPerRow: 5; // used when in gridView
    property int gridSizeStyle: 0; // #0 - adaptive grid, #1 - fixed grid // used when in gridView

    property int itemViewStyle: 0; // #0 - listView; #1 - gridView


    property int currentPageNum: 0;
    property int totalPage: 0;

    signal error(string errorText);


    ListModel{
        id: objMainModel
    }

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

    Component.onDestruction: {
        objMetaDbModel.close();
    }

    // ## All Important Methods ## //
    function setup(){
        objMetaDbModel.isReady = false;

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

    function open(){
        setup();
        if(objMetaDbModel.isReady) restoreSettings();
    }

    function close(){
        if(objMetaDbModel.isReady) saveSettings();
    }

    function createDb(){
        setup();
        if(objMetaDbModel.isReady) saveSettings();
    }

    function saveSettings(){
        var settings = {};
        settings["itemPerPage"] = objMetaDbModel.itemPerPage;
        settings["itemHeight"] = objMetaDbModel.itemHeight;
        settings["thumbnailWidth"] = objMetaDbModel.thumbnailWidth;
        settings["thumbnailHeight"] = objMetaDbModel.thumbnailHeight;
        settings["maxGridPerRow"] = objMetaDbModel.maxGridPerRow;
        settings["gridSizeStyle"] = objMetaDbModel.gridSizeStyle;
        settings["itemViewStyle"] = objMetaDbModel.itemViewStyle;
        objKVS.forcedSet("metaDbSettings", JSON.stringify(settings));
    }

    function restoreSettings(){
        var settings = objKVS.get("metaDbSettings",{});
        try{
            objMetaDbModel.itemPerPage = settings["itemPerPage"];
            objMetaDbModel.itemHeight = settings["itemHeight"];
            objMetaDbModel.thumbnailWidth = settings["thumbnailWidth"];
            objMetaDbModel.thumbnailHeight = settings["thumbnailHeight"];
            objMetaDbModel.maxGridPerRow = settings["maxGridPerRow"];
            objMetaDbModel.gridSizeStyle = settings["gridSizeStyle"];
            objMetaDbModel.itemViewStyle = settings["itemViewStyle"];
        }
        catch(e){
        }
    }

    function reload(){
    }

    function nextPage(){
    }
    function hasNextPage(){
    }

    function previousPage(){
    }
    function hasPreviousPage(){
    }


    function gotoPage(num){
    }


}
