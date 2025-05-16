import QtQuick 2.0
import Sailfish.Silica 1.0
import QtQuick.LocalStorage 2.0
import "../components/DataManagers"
import "../utilities/config.js" as DB
import "../utilities/Utilities.js" as Util

CoverBackground {
    SettingsManager {
        id: settingsManager
    }

    Column {
        spacing: 30
        anchors {
            top: parent.top
            left: parent.left
            right: parent.right
            bottom: coverActionArea.top
            leftMargin: 30
            rightMargin: 30
            topMargin: 30
        }

        Label {
            id: consumedLabel
            text: "?"
            color: "white"
            verticalAlignment: Text.AlignTop
            width: parent.width / 1.5
            wrapMode: Text.WordWrap
            font.pixelSize: Theme.fontSizeLarge
        }

        Label {
            id: consumedPercentLabel
            text: "?"
            verticalAlignment: Text.AlignTop
            width: parent.width / 1.5
            wrapMode: Text.WordWrap
            font.pixelSize: Theme.fontSizeMedium
        }

    }

    CoverActionList {
        id: coverAction

        CoverAction {
            iconSource: "image://theme/icon-cover-next"
        }
    }

    onStatusChanged: function() {
        if (status === Cover.Active) {
            loadCoverData()
        }
    }

    Component.onCompleted: loadCoverData()

    function loadCoverData() {
        consumedLabel.text = "Today: \n" + Util.getAm() + " ml."

        var numb = Util.getAm() / Util.targetCount() * 100
        numb = numb.toFixed(0)
        if (numb >= 0) {
            return consumedPercentLabel.text = "That's: \n "+ numb + " % of your target."
        } else {
            return consumedPercentLabel.text = "You must add your weight in settings."
        }
    }
}
