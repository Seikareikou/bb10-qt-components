/****************************************************************************
**
** Copyright (C) 2011 Nokia Corporation and/or its subsidiary(-ies).
** All rights reserved.
** Contact: Nokia Corporation (qt-info@nokia.com)
**
** This file is part of the Qt Components project on Qt Labs.
**
** No Commercial Usage
** This file contains pre-release code and may not be distributed.
** You may use this file in accordance with the terms and conditions contained
** in the Technology Preview License Agreement accompanying this package.
**
** GNU Lesser General Public License Usage
** Alternatively, this file may be used under the terms of the GNU Lesser
** General Public License version 2.1 as published by the Free Software
** Foundation and appearing in the file LICENSE.LGPL included in the
** packaging of this file.  Please review the following information to
** ensure the GNU Lesser General Public License version 2.1 requirements
** will be met: http://www.gnu.org/licenses/old-licenses/lgpl-2.1.html.
**
** If you have questions regarding the use of this file, please contact
** Nokia at qt-info@nokia.com.
**
****************************************************************************/

import Qt 4.7
import "." 1.0

ImplicitSizeItem {
    id: root

    property Flickable flickableItem: null
    property int orientation: Qt.Vertical
    property bool interactive: true
    property int policy: Symbian.ScrollBarWhenScrolling

    //implicit values for qml designer when no Flickable is present
    implicitHeight: privateStyle.scrollBarThickness * (orientation == Qt.Vertical ? 3 : 1)
    implicitWidth: privateStyle.scrollBarThickness * (orientation == Qt.Horizontal ? 3 : 1)
    height: {
        if (flickableItem && orientation == Qt.Vertical)
            return Math.floor(Math.round(flickableItem.height) - anchors.topMargin - anchors.bottomMargin)
        return undefined
    }
    width: {
        if (flickableItem && orientation == Qt.Horizontal)
            return Math.floor(Math.round(flickableItem.width) - anchors.leftMargin - anchors.rightMargin)
        return undefined
    }
    opacity: 0

    //For showing explicitly a ScrollBar if policy is Symbian.ScrollBarWhenScrolling
    function flash(type) {
        if (policy == Symbian.ScrollBarWhenScrolling && internal.scrollBarNeeded) {
            flashEffect.type = (type == undefined) ? Symbian.FadeOut : type
            flashEffect.play()
        }
    }

    Connections {
        target: screen
        onCurrentOrientationChanged: flash()
    }

    QtObject {
        id: internal
        property int hideTimeout: root.interactive ? 2000 : 500
        property int pageStepY: flickableItem ? Math.floor(flickableItem.visibleArea.heightRatio * flickableItem.contentHeight) : NaN
        property int pageStepX: flickableItem ? Math.floor(flickableItem.visibleArea.widthRatio * flickableItem.contentWidth) : NaN
        property int handleY: flickableItem ? Math.floor(handle.y / flickableItem.height * flickableItem.contentHeight) : NaN
        property int handleX: flickableItem ? Math.floor(handle.x / flickableItem.width * flickableItem.contentWidth) : NaN
        property int maximumY: flickableItem ? Math.floor(Math.min(flickableItem.contentHeight - root.height, flickableItem.contentY)) : NaN
        property int maximumX: flickableItem ? Math.floor(Math.min(flickableItem.contentWidth - root.width, flickableItem.contentX)) : NaN
        property bool scrollBarNeeded: hasScrollableContent()
        /**
         * Special handler for idle state ""
         * - in case if no flicking (flickableItem.moving) has occured
         * - but there is a need (contents of Flickable have changed) indicate scrollable content
         *
         * See also other transition/action pairs in StateGroup below
         */
        onScrollBarNeededChanged: {
            if (stateGroup.state != "")
                return
            if (scrollBarNeeded)
                stateGroup.state = "Indicate"
            else
                idleEffect.restart()
        }
        /**
         * Checks whether ScrollBar is needed or not
         * based on Flickable visibleArea height and width ratios
         */
        function hasScrollableContent() {
            //TODO: Remove this commented logging code snippet
            //console.log("flickableItem = "+flickableItem)
            //console.log("flickableItem.visibleArea.heightRatio = "+flickableItem.visibleArea.heightRatio)
            //console.log("flickableItem.visibleArea.widthRatio = "+flickableItem.visibleArea.widthRatio)
            if (!flickableItem)
                return false
            var _ratio = orientation == Qt.Vertical ? flickableItem.visibleArea.heightRatio : flickableItem.visibleArea.widthRatio
            return _ratio < 1.0 && _ratio > 0
        }
        /**
         * Does Page by Page movement of flickableItem
         * when ScrollBar Track is being clicked/pressed
         *
         * @see #moveToLongTapPosition
         */
        function doPageStep() {
            if (orientation == Qt.Vertical) {
                if (trackMouseArea.mouseY > (handle.height / 2 + handle.y)) {
                    flickableItem.contentY += pageStepY
                    flickableItem.contentY = maximumY
                }
                else if (trackMouseArea.mouseY < (handle.height / 2 + handle.y)) {
                    flickableItem.contentY -= pageStepY
                    flickableItem.contentY = Math.max(0, flickableItem.contentY)
                }
            } else {
                if (trackMouseArea.mouseX > (handle.width / 2 + handle.x)) {
                    flickableItem.contentX += pageStepX
                    flickableItem.contentX = maximumX
                }
                else if (trackMouseArea.mouseX < (handle.width / 2 + handle.x)) {
                    flickableItem.contentX -= pageStepX
                    flickableItem.contentX = Math.max(0, flickableItem.contentX)
                }
            }
        }
        /**
         * Does movement of flickableItem
         * when ScrollBar Handle is being dragged
         */
        function moveToHandlePosition() {
            if (orientation == Qt.Vertical)
                flickableItem.contentY = handleY
            else
                flickableItem.contentX = handleX
        }
        /**
         * Moves flickableItem's content according to given mouseArea movement
         * when mouseArea is pressed long
         * Tries to position the handle and content in center of mouse position enough
         *
         * @see #doPageStep
         */
        function moveToLongTapPosition(mouseArea) {
            if (orientation == Qt.Vertical) {
                if (Math.abs(mouseArea.mouseY - (handle.height / 2 + handle.y)) < privateStyle.scrollBarThickness)
                    return //if change is not remarkable enough, do nothing otherwise it would cause annoying flickering effect
                if (mouseArea.mouseY > (handle.height / 2 + handle.y)) {
                    flickableItem.contentY += Math.floor(privateStyle.scrollBarThickness)
                    flickableItem.contentY = maximumY
                }
                else if (mouseArea.mouseY < (handle.height / 2 + handle.y)) {
                    flickableItem.contentY -= Math.floor(privateStyle.scrollBarThickness)
                    flickableItem.contentY = Math.floor(Math.max(0, flickableItem.contentY))
                }
            } else {
                if (Math.abs(mouseArea.mouseX - (handle.width / 2 + handle.x)) < privateStyle.scrollBarThickness)
                    return //if change is not remarkable enough, do nothing otherwise it would cause annoying flickering effect
                if (mouseArea.mouseX > (handle.width / 2 + handle.x)) {
                    flickableItem.contentX += Math.floor(privateStyle.scrollBarThickness)
                    flickableItem.contentX = maximumX
                }
                else if (mouseArea.mouseX < (handle.width / 2 + handle.x)) {
                    flickableItem.contentX -= Math.floor(privateStyle.scrollBarThickness)
                    flickableItem.contentX = Math.floor(Math.max(0, flickableItem.contentX))
                }
            }
        }
    }

    BorderImage {
        id: track
        objectName: "track"
        source: privateStyle.imagePath(orientation == Qt.Vertical ? "qtg_fr_scrollbar_v_track_normal" : "qtg_fr_scrollbar_h_track_normal")
        visible: interactive
        anchors.fill: parent
        border.right: orientation == Qt.Horizontal ? 7 : 0
        border.left: orientation == Qt.Horizontal ? 7 : 0
        border.top: orientation == Qt.Vertical ? 7 : 0
        border.bottom: orientation == Qt.Vertical ? 7 : 0
        onVisibleChanged: { idleEffect.complete(); flashEffect.complete() }
    }
    // MouseArea for the move content "page by page" by tapping and scroll to press-and-hold position
    MouseArea {
        id: trackMouseArea
        objectName: "trackMouseArea"
        property bool longPressed: false
        enabled: interactive
        anchors.fill: flickableItem ? track : undefined
        onPressAndHold: longPressed = true
        onReleased: longPressed = false
    }
    Timer {
        id: pressAndHoldTimer
        running: trackMouseArea.longPressed
        interval: 50
        repeat: true
        onTriggered: { internal.moveToLongTapPosition(trackMouseArea); privateStyle.play(Symbian.SensitiveSlider) }
    }

    BorderImage {
        id: handle
        objectName: "handle"
        source: privateStyle.imagePath(handleFileName())
        x: orientation == Qt.Horizontal ? sizer.position : (!flickableItem ? NaN : flickableItem.x)
        y: orientation == Qt.Vertical ? sizer.position : (!flickableItem ? NaN : flickableItem.y)
        height: orientation == Qt.Vertical ? sizer.size : root.height
        width: orientation == Qt.Horizontal ? sizer.size : root.width
        border.right: orientation == Qt.Horizontal ? 7 : 0
        border.left: orientation == Qt.Horizontal ? 7 : 0
        border.top: orientation == Qt.Vertical ? 7 : 0
        border.bottom: orientation == Qt.Vertical ? 7 : 0

        function handleFileName() {
            var fileName = (orientation == Qt.Vertical ? "qtg_fr_scrollbar_v_handle_" :
                            "qtg_fr_scrollbar_h_handle_")
            if (!interactive)
                fileName += "indicative"
            else if (handleMouseArea.pressed)
                fileName += "pressed"
            else
                fileName += "normal"
            return fileName
        }
    }
    ScrollBarSizer {
        id: sizer
        minSize: 3 * Math.floor(privateStyle.scrollBarThickness)
        maxSize: !flickableItem ? NaN : (orientation == Qt.Vertical ? root.height : root.width)
        positionRatio: !flickableItem ? NaN : (orientation == Qt.Vertical && flickableItem ? flickableItem.visibleArea.yPosition : flickableItem.visibleArea.xPosition)
        sizeRatio: !flickableItem ? NaN : (orientation == Qt.Vertical ? flickableItem.visibleArea.heightRatio : flickableItem.visibleArea.widthRatio)
    }
    MouseArea {
        id: handleMouseArea
        objectName: "handleMouseArea"
        property real maxDragY: flickableItem ? flickableItem.height - handle.height - root.anchors.topMargin - root.anchors.bottomMargin : NaN
        property real maxDragX: flickableItem ? flickableItem.width - handle.width - root.anchors.leftMargin - root.anchors.rightMargin : NaN
        enabled: interactive
        width: orientation == Qt.Vertical ? 3 * privateStyle.scrollBarThickness : handle.width
        height: orientation == Qt.Horizontal ? 3 * privateStyle.scrollBarThickness : handle.height
        anchors {
            verticalCenter: flickableItem ? handle.verticalCenter : undefined
            horizontalCenter: flickableItem ? handle.horizontalCenter : undefined
        }
        drag {
            target: handle
            axis: orientation == Qt.Vertical ? Drag.YAxis : Drag.XAxis
            minimumY: 0
            maximumY: maxDragY
            minimumX: 0
            maximumX: maxDragX
        }
        onPositionChanged: internal.moveToHandlePosition()
    }

    PropertyAnimation {
        id: indicateEffect

        function play() {
            flashEffect.stop()
            idleEffect.stop()
            restart()
        }

        target: root
        property: "opacity"
        to: 1
        duration: 0
    }
    PropertyAnimation {
        id: idleEffect

        function play() {
            indicateEffect.stop()
            if (internal.scrollBarNeeded && root.policy == Symbian.ScrollBarWhenScrolling) {
                // To always properly clean up the track graphic from the screen when switching
                // between interactive=true/false while the animation is ongoing it's required that
                // track.visible=false happens before the animation completes. Duration is assigned
                // to make sure it doesn't change to a smaller value and complete the animation too
                // soon. See QTCOMPONENTS-703.
                duration = internal.hideTimeout
                restart()
            }
        }

        target: root
        property: "opacity"
        to: 0
    }
    SequentialAnimation {
        id: flashEffect
        property int type: Symbian.FadeOut

        function play() {
            // See the comments in idleEffect.play()
            fadeIn.duration = (flashEffect.type == Symbian.FadeInFadeOut) ? internal.hideTimeout : 0
            fadeOut.duration = internal.hideTimeout
            restart()
        }

        PropertyAnimation {
            id: fadeIn
            target: root
            property: "opacity"
            to: 1
        }
        PropertyAnimation {
            id: fadeOut
            target: root
            property: "opacity"
            to: 0
        }
    }
    StateGroup {
        id: stateGroup
        states: [
            State {
                name: "Move"
                when: handleMouseArea.pressed
            },
            State {
                name: "Stepping"
                when: trackMouseArea.longPressed
            },
            State {
                name: "Step"
                when: trackMouseArea.pressed && !trackMouseArea.longPressed
            },
            State {
                name: "Indicate"
                when: internal.scrollBarNeeded && flickableItem.moving
            },
            State {
                name: ""
            }
        ]
        transitions: [
            Transition {
                to: "Move"
                ScriptAction { script: privateStyle.play(Symbian.BasicSlider) }
                ScriptAction { script: indicateEffect.play() }
            },
            Transition {
                to: "Step"
                ScriptAction { script: internal.doPageStep() }
                ScriptAction { script: privateStyle.play(Symbian.BasicSlider) }
                ScriptAction { script: indicateEffect.play() }
            },
            Transition {
                from: "Step"
                to: "Stepping"
                ScriptAction { script: indicateEffect.play() }
            },
            Transition {
                from: "Move"
                to: "Indicate"
                ScriptAction { script: privateStyle.play(Symbian.BasicSlider) }
                ScriptAction { script: indicateEffect.play() }
            },
            Transition {
                to: "Indicate"
                ScriptAction { script: indicateEffect.play() }
            },
            Transition {
                from: "Move"
                to: ""
                ScriptAction { script: privateStyle.play(Symbian.BasicSlider) }
                ScriptAction { script: idleEffect.play() }
            },
            Transition {
                to: ""
                ScriptAction { script: idleEffect.play() }
            }
        ]
    }
}
