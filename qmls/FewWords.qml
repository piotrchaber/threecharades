import QtQuick 2.11

Item
{
    id: root
    width: myKeys.width > blockSize * letters ? myKeys.width : blockSize * letters
    height: blockSize * words + filler.height + myKeys.height

    property var blockColor: "transparent"
    property int blockSize: 0
    property var existColor: "transparent"
    property var keyColor: "transparent"
    property int keyHeight: 0
    property var keyPushColor: keyColor
    property int keyWidth: 0
    property var matchColor: "transparent"
    readonly property int letters: 5
    readonly property int score: repeater.currentRow
    readonly property int words: 6

    readonly property bool finished: repeater.finished

    Column
    {
        id: column

        readonly property string password: "KUTAS" // passwords.line

        Repeater
        {
            id: repeater
            model: words

            property int currentRow
            property bool finished: false

            OneWord
            {
                id: oneWord
                anchors.horizontalCenter: parent.horizontalCenter
                blockSize: root.blockSize
                blockColor: root.blockColor
                blockMatchColor: root.matchColor
                blockExistColor: root.existColor
                borderWidth: 1
                letters: root.letters

                onWordSend:
                {
                    for (var i = 0; i < letters; ++i) {
                        myKeys.find(text[i], colors[i])
                    }
                }
            }
        }

        Rectangle
        {
            id: filler
            width: parent.width
            height: 20
            color: "transparent"
        }

        MyKeys
        {
            id: myKeys
            anchors.horizontalCenter: parent.horizontalCenter
            spacing: 4
            keyWidth: root.keyWidth
            keyHeight: root.keyHeight
            keyExistColor: root.existColor
            keyMatchColor: root.matchColor
            keyNonExistColor: root.blockColor
            keyColor: root.keyColor
            keyPushColor: root.keyPushColor

            onInputSend:
            {
                if (repeater.finished == true) { return }
                if (text === "SEND" && repeater.itemAt(repeater.currentRow).full && repeater.itemAt(repeater.currentRow).contains()) {
                    repeater.itemAt(repeater.currentRow).compare(column.password)
                    repeater.finished = repeater.itemAt(repeater.currentRow).won(column.password) || ++repeater.currentRow == words
                    return
                }
                if (text !== "SEND") {
                    repeater.itemAt(repeater.currentRow).letterSend(text)
                }
            }
        }
    }

    Component.onCompleted:
    {
        console.log(column.password)
        passwords.remove(column.password)
    }
}