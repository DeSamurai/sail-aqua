import QtQuick 2.0
import Sailfish.Silica 1.0
import "pages"
import "cover"

ApplicationWindow {
    id: app
    initialPage: Component {
        FirstPage {}
    }
    cover: Component {
        CoverPage {
            onAddUserWaterAmount: {
                app.activate()
                pageStack.replaceAbove(null, Qt.resolvedUrl("pages/FirstPage.qml"), null, PageStackAction.Immediate)
//                pageStack.pop(app.initialPage, PageStackAction.Immediate)
                pageStack.push(Qt.resolvedUrl("pages/AddAnotherWaterAmount.qml"))
            }
        }
    }
    allowedOrientations: Orientation.PortraitMask
}
