import QtQuick 2.0
import Sailfish.Silica 1.0
import QtQuick.LocalStorage 2.0
import "../utilities/config.js" as DB

Button {
    signal buttonClicked
    property int delegateIndex: index

    id: button
    text: "?"
//    anchors.horizontalCenter: parent.horizontalCenter
    onClicked: {
        buttonClicked()
    }
    Component.onCompleted: button.text = DB.buttonsList(delegateIndex + 1) + " ml"
}
