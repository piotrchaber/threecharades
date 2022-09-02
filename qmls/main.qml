import QtQuick 2.11
import QtQuick.Window 2.11
import QtQuick.Controls 2.4

Window
{
    id: root
    visible: true
    width: 480
    height: 660
    title: qsTr("Three Charade");

    function score()
    {
        var result = 0
        for (var i = 0; i < repeater.count; ++i) {
            result += repeater.itemAt(i).item.children[0].score
        }
        return result
    }

    function finished()
    {
        var result = repeater.count ? true : false
        for (var i = 0; i < repeater.count; ++i) {
            result &= repeater.itemAt(i).item.children[0].finished
        }
        return result
    }

    readonly property bool gameOver: finished()

    onGameOverChanged: {
        if (gameOver) {
            //results.insert(score() + " " + startPage.name + " " + Qt.formatDateTime(new Date(), "dd.MM.yyyy"))
            //results.write()
            //scoreboard.update()
            test.insert(score(), startPage.name)
            test.write()
            scoreboard.update()
        }
    }

    StartPage
    {
        id: startPage
        anchors.fill: parent
        backgroundColor: "teal"
    }

    SwipeView
    {
        id: swipeView
        visible: !startPage.running
        anchors.fill: parent
        currentIndex: 1

        Repeater
        {
            id: repeater
            model: 3
            Loader
            {
                active: true
                sourceComponent: Rectangle
                {
                    color: "mintcream"
                    FewWords
                    {
                        id: fewWords
                        anchors.centerIn: parent
                        blockSize: 70
                        blockColor: "beige"
                        keyWidth: 35
                        keyHeight: 55
                        keyColor: "steelblue"
                        keyPushColor: "lightblue"
                        existColor: "gold"
                        matchColor: "forestgreen"
                    }
                }
            }
        }

        Rectangle
        {
            color: "aquamarine"
                
            Scoreboard
            {
                id: scoreboard
                anchors.centerIn: parent
                color: "beige"
                borderColor: "red"
                labelColor: "yellow"
                labelTextColor: "darkblue"
                text: score()
            }
        }
    }

    PageIndicator
    {
        visible: !startPage.running
        count: swipeView.count
        currentIndex: swipeView.currentIndex
        anchors.bottom: swipeView.bottom
        anchors.horizontalCenter: parent.horizontalCenter
    }
}

// todo: configure_file in cmake to copy input folder (except scoreboard.txt i think)
// idea: introduce result struct with score nick and date as a variables
// idea: make ResultFile class derived from DataFile class
