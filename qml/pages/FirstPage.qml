import QtQuick 2.0
import Sailfish.Silica 1.0
import QtQuick.LocalStorage 2.0

import "../utilities/config.js" as DB
import "../utilities/ComponentUtilities/FirstPageMethods.js" as Methods
import "../utilities/Utilities.js" as Util

Page {
    id: page
    property int choose

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
            //            MenuItem {
            //                text: qsTr("Second")
            //                onClicked: pageStack.push(Qt.resolvedUrl("SecondPage.qml"))
            //            }
            //            MenuItem {
            //                text: qsTr("Edit mode")
            //                onClicked: pageStack.push(Qt.resolvedUrl("EditMode.qml"))
            //            }
            MenuItem {
                text: qsTr("Statistics")
                onClicked: pageStack.push(Qt.resolvedUrl("Stat.qml"))
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
                Component.onCompleted: Methods.textToday(Util.getAm)
            }

            Label {
                id: percentage
                text: "?"
                anchors {
                    left: parent.left
                    right: parent.right
                    margins: Theme.paddingLarge
                }
                Component.onCompleted: Methods.percent(Util.targetCount, Util.getAm)
            }

            Label {
                id: target
                text: "?"
                anchors {
                    left: parent.left
                    right: parent.right
                    margins: Theme.paddingLarge
                }
                Component.onCompleted: Methods.targetToday(Util.targetCount)
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
                onTriggered: Methods.send(DB.buttonsList(1), Util.getAm, Util.targetCount)
            }

            Button {
                id: button1
                text: "?"
                anchors.horizontalCenter: parent.horizontalCenter
                onClicked: {
                    deleteRemorse.execute("Cancel adding")
                }
                Component.onCompleted:button1.text = DB.buttonsList(1) + " ml"
            }

//            Button {
//                id: button2
//                text: "?"
//                anchors.horizontalCenter: parent.horizontalCenter
//                onClicked: {
//                    Methods.send(DB.buttonsList(2))
//                }
//                Component.onCompleted:button2.text = DB.buttonsList(2) + " ml"
//            }

//            Button {
//                id: button3
//                text: "?"
//                anchors.horizontalCenter: parent.horizontalCenter
//                onClicked: {
//                    Methods.send(DB.buttonsList(3))
//                }
//                Component.onCompleted:button3.text = DB.buttonsList(3) + " ml"
//            }

//            Button {
//                id: button4
//                text: "?"
//                anchors.horizontalCenter: parent.horizontalCenter
//                onClicked: {
//                    Methods.send(DB.buttonsList(4))
//                }
//                Component.onCompleted:button4.text = DB.buttonsList(4) + " ml"
//            }

//            Button {
//                id: button5
//                text: "?"
//                anchors.horizontalCenter: parent.horizontalCenter
//                onClicked: {
//                    Methods.send(DB.buttonsList(5))
//                }
//                Component.onCompleted:button5.text = DB.buttonsList(5) + " ml"
//            }

            TextSwitch {
                id: yesterday
                text: "Yesterday"
                onCheckedChanged: {
                    checked ? choose = 1 : choose = 0
                }
            }
        }
    }
}


