include (../../qt-components.pri)

TARGETPATH = com/nokia/symbian
TEMPLATE = lib
TARGET = $$qtLibraryTarget(symbianplugin)
INCLUDEPATH += $$PWD $$PWD/indicators

win32|mac:!wince*:!win32-msvc:!macx-xcode:CONFIG += debug_and_release build_all
CONFIG += qt plugin copy_native install_native
QT += declarative svg
mobility {
    MOBILITY += feedback systeminfo
    QT += network
}

SOURCES += \
    plugin.cpp \
    sbatteryinfo.cpp \
    sdeclarative.cpp \
    sdeclarativefocusscopeitem.cpp \
    sdeclarativeicon.cpp \
    sdeclarativeimageprovider.cpp \
    sdeclarativeimplicitsizeitem.cpp \
    sdeclarativemaskedimage.cpp \
    sdeclarativescreen.cpp \
    sdeclarativestyle.cpp \
    sdeclarativestyleinternal.cpp \
    siconpool.cpp \
    snetworkinfo.cpp \
    spopupmanager.cpp \
    sstyleengine.cpp \
    sstylefactory.cpp \
    sstylewrapper.cpp \
    sstylewrapper_p.cpp \
    indicators/sdeclarativeindicatorcontainer.cpp

symbian:symbian_internal {
    SOURCES += \
        indicators/sdeclarativeindicator.cpp \
        indicators/sdeclarativeindicatordata.cpp \
        indicators/sdeclarativeindicatordatahandler.cpp \
        indicators/sdeclarativestatuspanedatasubscriber.cpp
}

HEADERS += \
    sbatteryinfo.h \
    sdeclarative.h \
    sdeclarativefocusscopeitem.h \
    sdeclarativeicon.h \
    sdeclarativeimageprovider.h \
    sdeclarativeimplicitsizeitem.h \
    sdeclarativemaskedimage.h \
    sdeclarativemaskedimage_p.h \
    sdeclarativescreen.h \
    sdeclarativescreen_p.h \
    sdeclarativestyle.h \
    sdeclarativestyleinternal.h \
    siconpool.h \
    snetworkinfo.h \
    spopupmanager.h \
    sstyleengine.h \
    sstylefactory.h \
    sstylewrapper.h \
    sstylewrapper_p.h \
    indicators/sdeclarativeindicatorcontainer.h

symbian:symbian_internal {
    HEADERS +=  \
        indicators/sdeclarativeindicator.h \
        indicators/sdeclarativeindicatordata.h \
        indicators/sdeclarativeindicatordatahandler.h \
        indicators/sdeclarativestatuspanedatasubscriber.h
}

RESOURCES += \
    symbian.qrc

QML_FILES = \
    qmldir \
    ApplicationWindow.qml \
    AppManager.js \
    Button.qml \
    ButtonColumn.qml \
    ButtonGroup.js \
    ButtonRow.qml \
    BusyIndicator.qml \
    CheckBox.qml \
    ChoiceList.qml \
    CommonDialog.qml \
    ContextMenu.qml \
    Dialog.qml \
    Fader.qml \
    ListHeading.qml \
    ListItem.qml \
    ListItemText.qml \
    Menu.qml \
    MenuContent.qml \
    MenuItem.qml \
    MenuLayout.qml \
    Page.qml \
    PageStack.js \
    PageStack.qml \
    Popup.qml \
    ProgressBar.qml \
    QueryDialog.qml \
    RadioButton.qml \
    ScrollBar.qml \
    ScrollBarSizer.qml \
    ScrollDecorator.qml \
    SectionScroller.js \
    SectionScroller.qml \
    SectionScrollerLabel.qml \
    SelectionDialog.qml \
    SelectionListItem.qml \
    Slider.qml \
    StatusBar.qml \
    Switch.qml \
    TabBar.qml \
    TabBarLayout.qml \
    TabButton.qml \
    TabGroup.js \
    TabGroup.qml \
    TextArea.qml \
    TextField.qml \
    ToolBar.qml \
    ToolBarLayout.qml \
    ToolButton.qml \
    ToolTip.qml \
    Window.qml

symbian {
    TARGET.EPOCALLOWDLLDATA = 1
    TARGET.CAPABILITY = ALL -TCB
    TARGET.UID3 = 0x200346DD
    MMP_RULES += EXPORTUNFROZEN
    MMP_RULES += SMPSAFE

    LIBS += -lws32 // For CWsScreenDevice
    LIBS += -lcone // For EikonEnv / CoeEnv
    LIBS += -leikcore // For EikonEnv
    LIBS += -leikcoctl // For CEikStatusPane
    LIBS += -lavkon // For AknAppui SetOrientationL
    LIBS += -lhal   // For calculating DPI values

    symbian_internal {
        LIBS += -laknicon // For AknIconUtils
        LIBS += -laknnotify // For CAknSmallIndicator
        LIBS += -laknskins // For AknsUtils
        LIBS += -lbafl // For TResourceReader
        LIBS += -lfbscli // For CFbsBitmap
    }

    BLD_INF_RULES.prj_exports += "qtcomponents.iby $$CORE_MW_LAYER_IBY_EXPORT_PATH(qtcomponents.iby)"

    stubsis = \
        "START EXTENSION app-services.buildstubsis" \
        "OPTION SISNAME symbianplugin_stub" \
        "OPTION SRCDIR ."\
        "END"
    BLD_INF_RULES.prj_extensions = stubsis

    vendor_info = \
            " " \
            "; Localised Vendor name" \
            "%{\"Nokia\"}" \
            " " \
            "; Unique Vendor name" \
            ":\"Nokia, Qt\"" \
            " "

    header = "$${LITERAL_HASH}{\"symbianplugin\"},(0x200346DD),1,0,0,TYPE=SA,RU"
    package.pkg_prerules += vendor_info header
    DEPLOYMENT += package
}

win32: LIBS += -lpsapi # for allocated memory info

include(../../qml.pri)
