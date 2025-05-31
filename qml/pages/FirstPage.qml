import QtQuick 2.0
import Sailfish.Silica 1.0
import QtQuick.LocalStorage 2.0
import "../components/UI"
import "../components/DataManagers"
import "../utilities/config.js" as DB
import "../utilities/Utilities.js" as Util
import "../utilities/ComponentUtilities/FirstPageMethods.js" as Methods

Page {
    id: page
    property int choose

    SettingsManager {
        id: settingsManager
    }

    SilicaFlickable {
        anchors.fill: parent

        PullDownMenu {
            MenuItem {
                text: qsTr("About")
                onClicked: pageStack.push(Qt.resolvedUrl("About.qml"))
            }
            MenuItem {
                text: qsTr("Settings")
                onClicked: pageStack.push(Qt.resolvedUrl("Settings.qml"))
            }
            MenuItem {
                text: qsTr("History")
                onClicked: pageStack.push(Qt.resolvedUrl("History.qml"))
            }
        }

        contentHeight: column.height

        Column {
            id: column
            width: page.width
            spacing: Theme.paddingLarge

            PageHeader {
                title: qsTr("Sailaqua")
            }

            Label {
                id: today
                text: "?"
                anchors {
                    left: parent.left
                    right: parent.right
                    margins: Theme.paddingLarge
                }
            }

            Label {
                id: percentage
                text: "?"
                anchors {
                    left: parent.left
                    right: parent.right
                    margins: Theme.paddingLarge
                }
            }

            Label {
                id: target
                text: "?"
                anchors {
                    left: parent.left
                    right: parent.right
                    margins: Theme.paddingLarge
                }
            }

            Label {
                id: add
                text: "Add more"
                anchors {
                    left: parent.left
                    right: parent.right
                    margins: Theme.paddingLarge
                }
            }

            RemorsePopup {
                id: deleteRemorse
            }

            Column {
                spacing: Theme.paddingLarge
                anchors.horizontalCenter: parent.horizontalCenter

                Grid {
                    id: buttonsContainer
                    columns: 2
                    spacing: Theme.paddingLarge
                    anchors.horizontalCenter: parent.horizontalCenter

                    Repeater {
                        model: settingsManager.buttonsAmount
                        AddWaterButton {
                            waterAmount: 200 + index * settingsManager.buttonsGapAmountPerCap
                            onButtonClicked: {
                                deleteRemorse.execute("Cancel adding", function() {
                                    Methods.send(waterAmount)
                                }
                                )
                            }
                        }
                    }
                }

                Button {
                    text: "Add another amount"
                    onClicked: pageStack.push(Qt.resolvedUrl("AddAnotherAmount.qml"))
                    anchors {
                        left: parent.left
                        right: parent.right
                    }
                }
            }

            TextSwitch {
                id: yesterday
                text: "Yesterday"
                onCheckedChanged: {
                    checked ? choose = 1 : choose = 0
                }
            }
        }
    }

    onStatusChanged: Methods.onStatusChanged()
    Component.onCompleted: Methods.loadPageData()
}


