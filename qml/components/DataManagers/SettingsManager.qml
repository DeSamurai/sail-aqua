import QtQuick 2.0
import Nemo.Configuration 1.0

ConfigurationGroup {
    id: configManager
    path: "/apps/harbor-sail-aqua"

    property double weight
    property string userName
    property int buttonsAmount
    property int buttonsGapAmountPerCap
    property int coverAddButtonAmount
    property int notificationTimeInterval
}
