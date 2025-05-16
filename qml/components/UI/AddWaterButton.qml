import QtQuick 2.0
import Sailfish.Silica 1.0
import QtQuick.LocalStorage 2.0

Button {
    signal buttonClicked
    property int delegateIndex: index
    property int waterAmount: 200

    id: button
    text: waterAmount + " ml"
//    anchors.horizontalCenter: parent.horizontalCenter
    onClicked: {
        buttonClicked()
    }
    onWaterAmountChanged: button.text = waterAmount + " ml"
}
