//Rewrite the code
import QtQuick 2.0
import Sailfish.Silica 1.0
import QtQuick.LocalStorage 2.0
import "../utilities/config.js" as DB

Page {
    id: page

    // To enable PullDownMenu, place our content in a SilicaFlickable
    SilicaFlickable {
        anchors.fill: parent

        // PullDownMenu and PushUpMenu must be declared in SilicaFlickable, SilicaListView or SilicaGridView

        // Tell SilicaFlickable the height of its content.
        contentHeight: column.height + header.height

        // Place our content in a Column.  The PageHeader is always placed at the top
        // of the page, followed by our content.

        PageHeader {
            id: header
            title: qsTr("Statistics")
        }
        SilicaListView {
            id: listview
            model: 20
            anchors.top: header.bottom
            Column {
                id: column
                width: page.width
                spacing: Theme.paddingLarge

                Text {
                    id: txt
                    text: "?"
                    color: "white"
                    anchors {
                        left: parent.left
                        right: parent.right
                        leftMargin: 30
                        rightMargin: 30
                    }
                    font.pixelSize: Theme.fontSizeSmall
                    Component.onCompleted: txt.text = DB.getStat()
                }

                VerticalScrollDecorator {}
            }
        }
    }
}
