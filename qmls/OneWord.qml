import QtQuick 2.11

Item
{
    id: root
    width: blockSize * letters
    height: blockSize
    
    signal letterSend(string text)
    signal wordSend(string text, var colors)

    onLetterSend:
    {
        if (text === "BACK" && repeater.currentIndex) {
            var previousItem = repeater.itemAt(repeater.currentIndex - 1)
            previousItem.children[0].text = ""
            repeater.word = repeater.word.substring(0, repeater.word.length - 1)
            --repeater.currentIndex
        }
        if (text !== "BACK" && repeater.currentIndex < letters) {
            var currentItem = repeater.itemAt(repeater.currentIndex)
            currentItem.children[0].text = text
            repeater.word += text
            ++repeater.currentIndex
        }
    }

    function compare(password)
    {
        var colors = [blockColor, blockColor, blockColor, blockColor, blockColor]
        for (var i = 0, j = 0; i < letters; ++i, ++j) {
            if (password[j] == repeater.word[i]) {
                colors[i] = blockMatchColor
                password = password.replace(password[j], "")
                --j
            }
        }
        for (var i = 0; i < letters; ++i) {
            var index = password.indexOf(repeater.word[i])
            if (index >= 0 && colors[i] != blockMatchColor) {
                colors[i] = blockExistColor
                password = password.replace(password[index], "")
            }
            repeater.itemAt(i).color = colors[i]
        }
        wordSend(repeater.word, colors)
    }

    function contains()
    {
        return dictionary.find(repeater.word)
    }

    function won(password)
    {
        return repeater.word == password
    }

    property int blockSize: 0
    property var blockColor: "transparent"
    property var blockExistColor: "transparent"
    property var blockMatchColor: "transparent"
    property var borderColor: "black"
    property int borderWidth: 0
    property int letters: 0
    readonly property var full: repeater.currentIndex === letters

    Row
    {
        Repeater
        {
            id: repeater
            model: letters

            property int currentIndex
            property string word: ""

            Rectangle
            {
                id: block
                width: blockSize
                height: blockSize
                color: blockColor
                border { width: borderWidth; color: borderColor }

                TextInput
                {
                    id: blockText
                    anchors.centerIn: parent
                    font { family: "Consolas"; pointSize: 20; bold: true }
                    readOnly: true
                }
            }
        }
    }
}