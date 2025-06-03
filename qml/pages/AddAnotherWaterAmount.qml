import QtQuick 2.0
import Sailfish.Silica 1.0
import QtQuick.LocalStorage 2.0
import "../utilities/config.js" as DB

Dialog {
    id: root

    Column {
        id: content
        anchors.fill: root

        DialogHeader {
            title: "Add another water amount"
            defaultAcceptText: "Add"
        }

        TextField {
            id: amountOfWater
            focus: true
            label: "Water amount(ml)"
            placeholderText: "Write water amount(ml)"
            inputMethodHints: Qt.ImhDigitsOnly
        }
    }

    onAccepted: function() {
        DB.addAmount(DB.today(), Number(amountOfWater.text))
    }
}
