// Copyright (C) 2024 smr.
// SPDX-License-Identifier: MIT
// https://0smr.github.io

import QtQuick
import QtQuick.Templates as T
import QtQuick.Controls.Basic

T.Button {
    id: control

    implicitWidth: Math.max(implicitBackgroundWidth + leftInset + rightInset,
                                implicitContentWidth + leftPadding + rightPadding)
    implicitHeight: Math.max(implicitBackgroundHeight + topInset + bottomInset,
                                implicitContentHeight + topPadding + bottomPadding)

    padding: 6
    spacing: 6

    icon.width: 24
    icon.height: 24
    icon.color: control.palette.buttonText

    display: AbstractButton.TextOnly

    contentItem: Item {
        Grid {
            x: (parent.width - width)/2
            y: (parent.height - height)/2

            spacing: control.display == AbstractButton.TextOnly ||
                     control.display == AbstractButton.IconOnly ? 0 : control.spacing

            rows: control.display == AbstractButton.TextUnderIcon ? 1 : -1
            columns: -rows

            layoutDirection: control.mirrored ? Qt.RightToLeft : Qt.LeftToRight

            opacity: control.down || control.checked ? 0.8 : 1.0

            Image {
                visible: control.display != AbstractButton.TextOnly
                source: control.icon.source
                width: control.icon.width
                height: control.icon.height
                cache: control.icon.cache
            }

            Text {
                visible: control.display != AbstractButton.IconOnly
                text: control.text
                font: control.font
                color: control.highlighted ? control.palette.highlightedText : control.palette.buttonText
                horizontalAlignment: Text.AlignHCenter
            }
        }
    }

    background: ShaderEffect {
        implicitWidth: 180
        implicitHeight: 15

        property color color: control.highlighted ? control.palette.highlight : control.palette.button

        property vector4d u_radius: Qt.vector4d(5,5,5,5)
        property color u_color: Eqlipse.blend(control.palette.window, this.color, control.checked * 0.05)
        property color u_border: Eqlipse.blend(this.color, control.palette.window, control.checkable)
        property color u_accent: Qt.alpha(this.color, !control.checkable && control.down ? 0.8 : 1)
        property real u_blend: control.down ? 0.5 : 0.2
        property real u_value: checked ? 0.25 : 0.75
        property real u_strokwidth: 0.5

        fragmentShader: "qrc:/eqlipse/shaders/button.frag.qsb"

        Behavior on u_value {NumberAnimation{ duration: 150 }}
        Behavior on u_blend {NumberAnimation{ duration: 100 }}
    }
}
