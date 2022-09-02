import QtQuick 2.11
import QtQuick.Controls 2.4

Item
{
    id: root
    width: rectangle.width
    height: rectangle.height

    property alias backgroundColor: rectangle.color
    property alias name: nickName.text
    property bool running: true

    Rectangle
    {
        id: rectangle
        visible: running
        anchors.fill: parent

        Column
        {
            anchors.centerIn: parent
            spacing: 40

            Label
            {
                id: description
                width: parent.width
                wrapMode: Label.WordWrap
                horizontalAlignment: Text.AlignHCenter
                font { family: "Consolas"; pointSize: 14 }
                text: "Charade is a word game in which our task is to guess a hidden five-letter word in six attempts. After each attempt, " +
                    "the letters we entered will be marked with the appropriate color:\n - green means that the letter is in the word " +
                    "exactly in the same place,\n- gold means that the letter is in the word but in a different place,\n- beige means that " +
                    "the letter is not in the word.\nThere are three charades left to guess, and you get penalty points for each one - " +
                    "each failed attempt is one penalty point. So the fewer points at the end the better! Good luck."
            }
            
            Row
            {
                spacing: 10

                Label
                {
                    anchors.verticalCenter: parent.verticalCenter
                    font { family: "Consolas"; pointSize: 14 }
                    text: "Enter your name: "
                }

                TextField
                {
                    id: nickName
                    font { family: "Consolas"; pointSize: 14 }
                    focus: true

                    background: Rectangle
                    {
                        implicitWidth: 240
                        implicitHeight: 30
                        border.width: 0
                        color: "white"
                        radius: 10
                    }
                }
            }

            Button
            {
                id: button
                anchors.horizontalCenter: parent.horizontalCenter

                contentItem: Text
                {
                    font { family: "Consolas"; pointSize: 14; bold: true; letterSpacing: 3 }
                    text: "START"
                    horizontalAlignment: Text.AlignHCenter
                    verticalAlignment: Text.AlignVCenter
                }

                background: Rectangle
                {
                    implicitWidth: 140
                    implicitHeight: 30
                    color: button.down ? "whitesmoke" : "white"
                    radius: 10
                }

                onClicked: {
                    root.running = !nickName.text
                }
            }
        }
    }
}