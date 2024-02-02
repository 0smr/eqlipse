import QtCore
import QtQuick
import QtQuick.Controls.Basic

import eqlipse

Page {
    id: root

    width: 260
    height: 500
    visible: true

    palette {
        button: "#4af"
        buttonText: "#cce"
        highlight: "#5cd46b"
        highlightedText: "#cec"

        base: "#050607"
        text: "#eee"
        window: '#050607'
        windowText: "#eee"
        placeholderText: '#eee'
    }

    component ButtonColor: Button {
        width: 20; height: width
        onClicked: {
            root.palette.button = palette.button
            root.palette.highlight = palette.button
            root.palette.highlightedText = palette.text
        }
    }

    component BackColor: Button {
        width: 20; height: width; text: '\u2022'
        onClicked: {
            root.palette.base = palette.button
            root.palette.buttonText = palette.text
            root.palette.text = palette.buttonText
            root.palette.window = palette.button
            root.palette.windowText = palette.text
            root.palette.placeholderText = palette.text
        }
    }

    component Title: Label {
        topPadding: 5
        horizontalAlignment: Qt.AlignHCenter
        width: parent.width
        color: palette.windowText
        opacity: 0.4

        Rectangle {
            x: 10
            width: parent.width - 20
            height: 0.5
            opacity: 0.5
        }
    }

    component HLine: Rectangle {
        color: palette.windowText
        width: parent && parent.width
        opacity: 0.3
    }

    component Debug: Rectangle {
        anchors.fill: parent
        border.width: 0.5
        border.color: 'red'
        color: 'transparent'
        opacity: 0.5
        radius: 5
    }

    Control {
        x: 5; y: root.height - height - 5; z: 3
        padding: 5
        contentItem: Row {
            spacing: 4
            ButtonColor { palette { button:'#48abff' }}
            ButtonColor { palette { button:'#edc9aa' }}
            ButtonColor { palette { button:'#4ce0b3' }}
            ButtonColor { palette { button:'#dd247f' }}
            // Item { width: 4; height: parent.height }
            // BackColor { palette { button: '#f5f6f7'; text:'#1d1c21' }}
            // BackColor { palette { button: '#1d1c21'; text:'#f5f6f7' }}
        }
    }

    Settings {
        id: settings
        location: 'config.conf'
        property alias cindex: swipview.currentIndex
    }

    PageIndicator {
        x: parent.width - width - 25
        y: parent.height - height - 5
        count: swipview.count
        currentIndex: swipview.currentIndex

        palette.dark: '#fff'
    }

    SwipeView {
        id: swipview
        padding: 5
        spacing: padding
        anchors.fill: parent

        Grid {
            columns: 1; rows: -1; spacing: 10
            horizontalItemAlignment: Qt.AlignHCenter

            Title { text: 'Buttons' }
            Flow {
                width: 180
                spacing: 5

                Repeater {
                    model: [
                        {w: 80, h: 45, t: 'Simple\nButton' },
                        {w: 80, h: 45, c: true, t: 'Checkable' },
                        {w: 45, h: 45, c: true, t: 'Check' },
                        {w: 115, h: 45, hh: true, t: 'Highlighted' },
                        {w: 80, h: 45, c: true, hh: true, t: 'Highlight\nCheckable' },
                    ]

                    Button {
                        required property int index
                        required property var modelData
                        width: modelData.w
                        height: modelData.h
                        checkable: modelData.c ?? false
                        highlighted: modelData.hh ?? false
                        text: modelData.t ?? 'btn ' + index
                    }
                }
            }

            Title { text: 'Slider' }
            Slider { width: parent.width }

            Title { text: 'Dial' }
            Dial {}
        }

        Grid {
            columns: 1; rows: -1; spacing: 10
            horizontalItemAlignment: Qt.AlignHCenter
        }
    }
}
