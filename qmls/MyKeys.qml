import QtQuick 2.11
import QtQuick.Controls 2.4
import QtQuick.Layouts 1.9

Item
{
    id: root
    width: gridLayout.implicitWidth
    height: gridLayout.implicitHeight

    signal inputSend(string text)

    function find(letter, color)
    {
        for (var i = 0; i < items.count; ++i) {
            var item = items.get(i)
            if (item.text === letter && (item.color != keyMatchColor)) {
                if (item.color != keyExistColor || color != keyNonExistColor) {
                    item.color = color
                }
                break
            }
        }
    }

    property int keyHeight: 0
    property int keyWidth: 0
    property var keyColor: "transparent"
    property var keyExistColor: "transparent"
    property var keyMatchColor: "transparent"
    property var keyNonExistColor: "transparent"
    property var keyPushColor: keyFirstColor
    property int spacing: 0

    GridLayout
    {
        id: gridLayout
        columnSpacing: spacing
        rowSpacing: spacing
        columns: 10

        Repeater
        {
            id: repeater
            model: ListModel { id: items }
            delegate: Button
            {
                id: button
                width: keyWidth
                height: keyHeight
                Layout.fillWidth: true
                Layout.fillHeight: true
                Layout.columnSpan: text === "BACK" || text === "SEND" ? 2 : 1
                font { family: "Consolas"; pointSize: 14; italic: true }
                text: model.text

                background: Rectangle
                {
                    color: button.down ? keyPushColor : model.color
                    border.width: 1
                    radius: 4
                }

                onClicked:
                {
                    inputSend(model.text)
                }
            }
        }
    }

    Component.onCompleted:
    {
        var keys = ["Q","W","E","R","T","Y","U","I","O","P","A","S","D","F","G","H","J","K","L","Z","SEND","X","C","V","B","N","M","BACK","Ą","Ć","Ę","Ł","Ó","Ś","Ń","Ż","Ź"]
        keys.forEach(function(value) {
            items.append({ text: value, color: keyColor })
        })
    }
}