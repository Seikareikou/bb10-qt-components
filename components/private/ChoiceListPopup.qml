import QtQuick 1.0

MouseArea {
    id: popup

    // There is no global z-ordering that can stack this popup in front, so we
    // need to reparent it to the root item to fake it upon showing the popup.
    // In that case, the popup will also fill the whole window to allow the user to
    // close the popup by clicking anywhere in the window. Letting the popup act as the mouse
    // area for the button that 'owns' it is also nessesary to support drag'n'release behavior.

    anchors.fill: parent
    hoverEnabled: true
    state: "hidden"

    property bool popupVisible: false
    property string behavior: "MacOS"
    property bool desktopBehavior: (behavior == "MacOS" || behavior == "Windows" || behavior == "Linux")
    property int previousCurrentIndex: -1

    property alias model: listView.model
    property alias currentIndex: listView.currentIndex

    property Component listItem
    property Component listHighlight
    property Component popupFrame

    property Item originalParent: parent
    function reparentToTop() {
        if (originalParent != parent) {
            // Already reparented. Return early to
            // avoid changing originalParent:
            return
        }
        originalParent = parent;
        var p = parent;
        while (p.parent != undefined)
            p = p.parent
        parent = p;
    }

    onPopupVisibleChanged: {
        if (popupVisible) {
            var oldMouseX = mouseX
            reparentToTop()
            previousCurrentIndex = currentIndex;
            positionPopup();
            popupFrameLoader.item.opacity = 1;
            if (oldMouseX === mouseX){
                // Work around bug: mouseX and mouseY does not immidiatly
                // update after reparenting and resizing the mouse area:
                var pos = originalParent.mapToItem(parent, mouseX, mouseY)
                highlightItemAt(pos.x, pos.y);
            } else {
                highlightItemAt(mouseX, mouseY);
            }

            listView.forceActiveFocus();
            state = ""
        } else {
            // Reparent the popup back to normal. But we need to be careful not to do this
            // before the popup is hidden, otherwise you will see it jump to the new parent
            // on screen. So we make it a binding in case a transition is set on opacity:
            parent = function() { return popupFrameLoader.item.opacity == 0 ? originalParent : parent; }
            popupFrameLoader.item.opacity = 0;
            popup.hideHighlight();
            // Make sure we only enter the 'hidden' state when the popup is actually not
            // visible. Otherwise the user will be able do open the popup again by clicking
            // anywhere on screen while its being hidden (in case of a transition):
            state = function() { return popupFrameLoader.item.opacity == 0 ? "hidden" : ""; }
        }
    }

    function highlightItemAt(posX, posY)
    {
        var mappedPos = mapToItem(listView.contentItem, posX, posY);
        var indexAt = listView.indexAt(mappedPos.x, mappedPos.y);
        if (indexAt == listView.highlightedIndex)
            return;
        if (indexAt >= 0) {
            listView.highlightedIndex = indexAt;
        } else {
            if(posY > listView.y+listView.height && listView.highlightedIndex+1 < listView.count ) {
                listView.highlightedIndex++;
            } else if(posY < listView.y && listView.highlightedIndex > 0) {
                listView.highlightedIndex--;
            } else if(posX < popupFrameLoader.x || posX > popupFrameLoader.x+popupFrameLoader.width) {
                popup.hideHighlight();
            }
        }
    }

    function hideHighlight() {
        listView.highlightedIndex = -1;
        listView.highlightedItem = null; // will trigger positionHighlight() what will hide the highlight
    }

    function positionPopup() {
        switch(behavior) {
        case "MacOS":
            var mappedListPos = mapFromItem(choiceList, 0, 0);
            var itemHeight = Math.max(listView.contentHeight/listView.count, 0);
            var currentItemY = Math.max(currentIndex*itemHeight, 0);
            currentItemY += Math.floor(itemHeight/2 - choiceList.height/2);  // correct for choiceLists that are higher than items in the list

            listView.y = mappedListPos.y - currentItemY;
            listView.x = mappedListPos.x;

            listView.width = choiceList.width;
            listView.height = listView.contentHeight    //mm see QTBUG-16037

            if(listView.y < styling.topMargin) {
                var excess = Math.floor(currentItemY - mappedListPos.y);
                listView.y = styling.topMargin;
                listView.height += excess;
                listView.contentY = excess + styling.topMargin;

                if(listView.contentY != excess+styling.topMargin) //mm setting listView.height seems to make it worse
                    print("!!! ChoiceListPopup.qml: listView.contentY should be " + excess+styling.topMargin + " but is " + listView.contentY)
            }

            if(listView.height+listView.contentY > listView.contentHeight) {
                listView.height = listView.contentHeight-listView.contentY;
            }

            if(listView.y+listView.height+styling.bottomMargin > popup.height) {
                listView.height = popup.height-listView.y-styling.bottomMargin;
            }
            break;
        case "Windows":
            var point = popup.mapFromItem(choiceList, 0, listView.height);
            listView.y = point.y;
            listView.x = point.x;

            listView.width = choiceList.width;
            listView.height = 200;

            break;
        case "MeeGo":
            break;
        }
    }

    Loader {
        id: popupFrameLoader
        property alias styledItem: popup.originalParent
        anchors.fill: listView
        anchors.leftMargin: -item.anchors.leftMargin
        anchors.rightMargin: -item.anchors.rightMargin
        anchors.topMargin: -item.anchors.topMargin
        anchors.bottomMargin: -item.anchors.bottomMargin
        sourceComponent: popupFrame
        onItemChanged: item.opacity = 0
    }

    ListView {
        id: listView
        focus: true
        opacity: popupFrameLoader.item.opacity
        boundsBehavior: desktopBehavior ? ListView.StopAtBounds : ListView.DragOverBounds
        keyNavigationWraps: !desktopBehavior
        highlightFollowsCurrentItem: false  // explicitly handled below

        interactive: !desktopBehavior   // disable flicking. also disables key handling
        onCurrentItemChanged: {
            if(desktopBehavior) {
                positionViewAtIndex(currentIndex, ListView.Contain);
            }
        }

        property int highlightedIndex: -1
        onHighlightedIndexChanged: positionViewAtIndex(highlightedIndex, ListView.Contain)

        property variant highlightedItem: null
        onHighlightedItemChanged: {
            if(desktopBehavior) {
                positionHighlight();
            }
        }

        function positionHighlight() {
            if(!Qt.isQtObject(highlightItem))
                return;

            if(!Qt.isQtObject(highlightedItem)) {
                highlightItem.opacity = 0;  // hide when no item is highlighted
            } else {
                highlightItem.x = highlightedItem.x;
                highlightItem.y = highlightedItem.y;
                highlightItem.width = highlightedItem.width;
                highlightItem.height = highlightedItem.height;
                highlightItem.opacity = 1;  // show once positioned
            }
        }

        delegate: Item {
            id: itemDelegate
            width: delegateLoader.item.width
            height: delegateLoader.item.height
            property int theIndex: index    // for some reason the loader can't bind directly to the "index"

            Loader {
                id: delegateLoader
                property variant model: listView.model
                property alias index: itemDelegate.theIndex //mm Somehow the "model" gets through automagically, but not index
                property Item styledItem: choiceList
                property bool highlighted: theIndex == listView.highlightedIndex
                sourceComponent: listItem
            }

            states: State {
                name: "highlighted"
                when: index == listView.highlightedIndex
                StateChangeScript {
                    script: {
                        if(Qt.isQtObject(listView.highlightedItem)) {
                            listView.highlightedItem.yChanged.disconnect(listView.positionHighlight);
                        }
                        listView.highlightedItem = itemDelegate;
                        listView.highlightedItem.yChanged.connect(listView.positionHighlight);
                    }
                }

            }
        }

        function firstVisibleItem() { return indexAt(contentX+10,contentY+10); }
        function lastVisibleItem() { return indexAt(contentX+width-10,contentY+height-10); }
        function itemsPerPage() { return lastVisibleItem() - firstVisibleItem(); }

        Keys.onPressed: {
            // with the ListView !interactive (non-flicking) we have to handle arrow keys
            if (event.key == Qt.Key_Up) {
                if(!highlightedItem) highlightedIndex = lastVisibleItem();
                else if(highlightedIndex > 0) highlightedIndex--;
            } else if (event.key == Qt.Key_Down) {
                if(!highlightedItem) highlightedIndex = firstVisibleItem();
                else if(highlightedIndex+1 < model.count) highlightedIndex++;
            } else if (event.key == Qt.Key_PageUp) {
                if(!highlightedItem) highlightedIndex = lastVisibleItem();
                else highlightedIndex = Math.max(highlightedIndex-itemsPerPage(), 0);
            } else if (event.key == Qt.Key_PageDown) {
                if(!highlightedItem) highlightedIndex = firstVisibleItem();
                else highlightedIndex = Math.min(highlightedIndex+itemsPerPage(), model.count-1);
            } else if (event.key == Qt.Key_Home) {
                highlightedIndex = 0;
            } else if (event.key == Qt.Key_End) {
                highlightedIndex = model.count-1;
            } else if (event.key == Qt.Key_Enter || event.key == Qt.Key_Return) {
                if(highlightedIndex != -1) {
                    listView.currentIndex = highlightedIndex;
                } else {
                    listView.currentIndex = popup.previousCurrentIndex;
                }

                popup.popupVisible = false;
            } else if (event.key == Qt.Key_Escape) {
                listView.currentIndex = popup.previousCurrentIndex;
                popup.popupVisible = false;
            }
            event.accepted = true;  // consume all keys while popout has focus
        }

        highlight: popup.listHighlight
    }

    Timer {
        // This is the time-out value for when we consider the
        // user doing a press'n'release, and not just a click to
        // open the popup:
        id: pressedTimer
        interval: 400 // Todo: fetch value from style object
    }

    onPressed: {
        if (state == "hidden") {
            // Show the popup:
            pressedTimer.running = true
            popup.popupVisible = true
        }
    }

    onReleased: {
        if (pressedTimer.running === false) {
            // Either we have a 'new' click on the popup, or the user has
            // done a drag'n'release. In either case, the user has done a selection:
            var mappedPos = mapToItem(listView.contentItem, mouseX, mouseY);
            var indexAt = listView.indexAt(mappedPos.x, mappedPos.y);
            if(indexAt != -1)
                listView.currentIndex = indexAt;
            popup.popupVisible = false
        }
    }

    onPositionChanged: {
        if (state != "hidden")
            popup.highlightItemAt(mouseX, mouseY)
    }
}



