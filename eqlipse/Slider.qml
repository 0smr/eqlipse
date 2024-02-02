// Copyright (C) 2024 smr.
// SPDX-License-Identifier: MIT
// https://0smr.github.io

import QtQuick
import QtQuick.Templates as T

T.Slider {
    id: control

    implicitWidth: Math.max(implicitBackgroundWidth + leftInset + rightInset,
                            implicitHandleWidth + leftPadding + rightPadding)
    implicitHeight: Math.max(implicitBackgroundHeight + topInset + bottomInset,
                             implicitHandleHeight + topPadding + bottomPadding)
    bottomInset: 20
    rightInset: 10
    leftInset: 10

    Behavior on bottomInset {SmoothedAnimation{}}

    handle: T.Control {
        property real offset: 7 * control.pressed

        x: control.leftPadding + control.visualPosition * (control.availableWidth - width)
        y: control.availableHeight - height - offset

        implicitWidth: 15
        implicitHeight: 15

        contentItem: Rectangle {
            radius: 15
            border.width: control.pressed ? 2 : 1
            border.color: control.pressed ? control.palette.button : Qt.alpha(control.palette.mid, 0.7)
            color: 'transparent'
        }

        Behavior on offset {NumberAnimation{ duration: 150 }}
    }

    background: ShaderEffect {
        implicitWidth: 180
        implicitHeight: 15

        property real u_en: control.pressed
        property real u_value: control.visualPosition
        property color u_color: Qt.alpha(control.palette.mid, 0.3)
        property color u_accent: control.palette.button

        fragmentShader: "qrc:/eqlipse/shaders/slider.frag.qsb"

        Behavior on u_en {NumberAnimation{ duration: 150 }}
    }
}
