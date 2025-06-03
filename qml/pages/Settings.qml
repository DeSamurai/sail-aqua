import QtQuick 2.0
import Sailfish.Silica 1.0
import QtQuick.LocalStorage 2.0
import "../components/DataManagers"

Page {
    SettingsManager {
        id: settingsManager
    }

    SilicaFlickable {
        id: root
        anchors.fill: parent
        contentHeight: column.height

        property alias userName: userName
        property alias weight: weight
        property alias buttonsAmount: buttonsAmount
        property alias buttonsGapAmountPerCap: buttonsGapAmountPerCap
//        property alias coverAddButtonAmount: coverAddButtonAmount
        property alias notificationTimeInterval: notificationTimeInterval

        PushUpMenu {
            MenuItem {
                text: "Set Default Values"
                onClicked: remorse.execute("Setting default values", setDefaultValues)
            }
        }

        PullDownMenu {
            MenuItem {
                text: "Save settings"
                onClicked: remorse.execute("Saving settings", saveSettings)
            }
        }

        Column {
            id: column
            width: page.width
            spacing: Theme.paddingLarge

            PageHeader {
                title: qsTr("Settings")
            }

            SectionHeader {
                text: "Personal information"
            }

            TextField {
                id: userName
                label: "Name"
                placeholderText: "Your name"
                width: page.width
                focus: true
                text: "?"
            }

            TextField {
                id: weight
                label: "Weight (kg)"
                placeholderText: "Your weight (kg)"
                width: page.width
                inputMethodHints: Qt.ImhDigitsOnly
                focus: true
                text: "?"
                validator: RegExpValidator { regExp: /^[0-9]+$/ }
            }

            SectionHeader {
                text: "Water cups buttons"
            }

            TextField {
                id: buttonsAmount
                label: "Cup buttons amount"
                placeholderText: "Cup buttons amount"
                width: page.width
                inputMethodHints: Qt.ImhDigitsOnly
                focus: true
                text: "?"
                validator: RegExpValidator { regExp: /^[2-6]{1}$/ }
            }

            TextField {
                id: buttonsGapAmountPerCap
                label: "Water amount per cup (ml)"
                placeholderText: "Water amount per cup (ml)"
                width: page.width
                inputMethodHints: Qt.ImhDigitsOnly
                focus: true
                text: "?"
                validator: RegExpValidator { regExp: /^\d+$/ }
            }

            SectionHeader {
                text: "Notifications"
            }

//            TextField {
//                id: coverAddButtonAmount
//                label: "Cover add button water amount (ml)"
//                placeholderText: "Cover add button water amount (ml)"
//                width: page.width
//                inputMethodHints: Qt.ImhDigitsOnly
//                focus: true
//                text: "?"
//                validator: RegExpValidator { regExp: /^\d+$/ }
//            }

            TextField {
                id: notificationTimeInterval
                label: "Notification time interval (min)"
                placeholderText: "Notification time interval (min)"
                width: page.width
                inputMethodHints: Qt.ImhDigitsOnly
                focus: true
                text: "?"
                validator: RegExpValidator { regExp: /^\d+$/ }
            }
        }

        RemorsePopup {
            id: remorse
        }
    }

    Component.onCompleted: {
        for (var key in properties) {
            var value = settingsManager[key]

            if (value === undefined) {
                var defaultValue = properties[key]
                settingsManager.setValue(key, defaultValue.default)

                value = settingsManager[key]
            }

            root[key].text = value
        }
    }

    //JS
    property var properties: ({
                                  "weight": {
                                      type: "double",
                                      default: 0.0
                                  },
                                  "buttonsAmount": {
                                      type: "int",
                                      default: 5
                                  },
                                  "userName": {
                                      type: "string",
                                      default: "defaultUser"
                                  },
                                  "buttonsGapAmountPerCap": {
                                      type: "int",
                                      default: 50
                                  },
//                                  "coverAddButtonAmount": {
//                                      type: "int",
//                                      default: 200
//                                  },
                                  "notificationTimeInterval": {
                                      type: "int",
                                      default: 30
                                  }
                              })

    function setDefaultValues() {
        for (var key in properties) {
            var value = properties[key]
            settingsManager.setValue(key, value.default)

            root[key].text = settingsManager[key]
        }

        pageStack.navigateBack(PageStackAction.Animated)
    }

    function saveSettings() {
        for (var property in properties) {
            saveProperty(property, properties[property].type)
        }

        pageStack.navigateBack(PageStackAction.Animated)
    }

    function saveProperty(property, type) {
        var value

        switch (type) {
        case "int":
            value = parseInt(root[property].text)
            break
        case "double":
            value = parseFloat(root[property].text)
            break
        default:
            value = root[property].text
            break
        }

        settingsManager.setValue(property, value)
    }
}


