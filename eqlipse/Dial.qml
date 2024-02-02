// Copyright (C) 2024 smr.
// SPDX-License-Identifier: MIT
// https://0smr.github.io

import QtQuick
import QtQuick.Templates as T

T.Dial {
    id: control
    // property alias dashRing: dashRing

    implicitWidth: Math.max(implicitBackgroundWidth + leftInset + rightInset,
                            implicitContentWidth + leftPadding + rightPadding)
    implicitHeight: Math.max(implicitBackgroundHeight + topInset + bottomInset,
                             implicitContentHeight + topPadding + bottomPadding)

    handle: Item {
        width: control.width
        height: control.height
        rotation: control.angle

        Rectangle {
            x: (parent.width - width)/2
            y: width + (control.pressed ? 3 : 13)

            implicitWidth: 15
            implicitHeight: 15

            radius: 15
            border.width: control.pressed ? 2 : 1
            border.color: control.pressed ? control.palette.button : Qt.alpha(control.palette.mid, 0.7)
            color: 'transparent'

            Behavior on y { NumberAnimation { duration: 150 } }
        }
    }

    background: ShaderEffect {
        implicitWidth: 180
        implicitHeight: 180

        property real u_en: control.pressed
        property real u_value: -control.angle/(control.startAngle - control.endAngle) + 0.5
        property color u_color: Qt.alpha(control.palette.mid, 0.7)
        property color u_accent: control.palette.button

        fragmentShader: "qrc:/eqlipse/shaders/dial.frag.qsb"

        Behavior on u_en { NumberAnimation { duration: 150 } }
    }
}
