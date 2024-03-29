// Copyright (C) 2024 smr.
// SPDX-License-Identifier: MIT
// https://0smr.github.io

pragma Singleton
import QtQuick

QtObject {
    function blend(color1: color, color2: color, value: real): color {
        return Qt.tint(color1, Qt.alpha(color2, value));
    }
}
