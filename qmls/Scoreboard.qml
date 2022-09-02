import QtQuick 2.11

Item
{
    id: root
    width: 480
    height: 550

    property var color: "transparent"
    property var borderColor: "transparent"
    property var labelColor: "transparent"
    property var labelTextColor: "transparent"
    property var text: ""

    function update()
    {
        records.clear()
        for (var i = 0; i < 10; ++i) {
            records.append({ record: test.data[i] || "" })
        }
    }

    ListView
    {
        id: listView
        anchors.fill: parent
        anchors.margins: 35
        model: ListModel { id: records }
        delegate: delegate
        header: header
        footer: footer
        spacing: 10
        enabled: false
    }

    Component
    {
        id: delegate

        Rectangle
        {
            width: parent.width // problem is here
            height: 35
            border { width: 2; color: root.borderColor }
            color: root.color
            radius: 10

            Text
            {
                anchors.centerIn: parent
                font { family: "Consolas"; pointSize: 12; italic: true; letterSpacing: 5 }
                text: modelData
            }
        }
    }

    Component
    {
        id: header

        Rectangle
        {
            anchors.horizontalCenter: parent.horizontalCenter
            width: listView.width + 10
            height: 30
            color: root.labelColor
            radius: 10

            Text
            {
                anchors.centerIn: parent
                font { family: "Consolas"; pointSize: 12; bold: true; letterSpacing: 10 }
                color: labelTextColor
                text: "RESULTS"
            }
        }
    }

    Component
    {
        id: footer
        
        Rectangle
        {
            anchors.horizontalCenter: parent.horizontalCenter
            width: listView.width + 10
            height: 30
            color: root.labelColor
            radius: 10

            Text
            {
                anchors.centerIn: parent
                font { family: "Consolas"; pointSize: 12; italic: true; letterSpacing: 5 }
                color: labelTextColor
                text: root.text + " is your current result"
            }
        }
    }

    Component.onCompleted:
    {
        update()
    }
}