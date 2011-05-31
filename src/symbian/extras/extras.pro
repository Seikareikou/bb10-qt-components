include (../../../qt-components.pri)

TARGETPATH = com/nokia/extras
TEMPLATE = lib
TARGET = $$qtLibraryTarget(symbianextrasplugin_1_0)
INCLUDEPATH += $$PWD

win32|mac:!wince*:!win32-msvc:!macx-xcode:CONFIG += debug_and_release build_all
CONFIG += qt plugin
QT += declarative

HEADERS += \
    sdatetime.h

SOURCES += \
    plugin.cpp \
    sdatetime.cpp

QML_FILES = \
    qmldir \
    Constants.js \
    DatePickerDialog.qml \
    InfoBanner.qml \
    RatingIndicator.qml \
    TimePickerDialog.qml \
    Tumbler.js \
    Tumbler.qml \
    TumblerColumn.qml \
    TumblerDialog.qml \
    TumblerIndexHelper.js \
    TumblerTemplate.qml

symbian {
    TARGET.EPOCALLOWDLLDATA = 1
    TARGET.CAPABILITY = ALL -TCB
    TARGET.UID3 = 0x2003A913
    MMP_RULES += EXPORTUNFROZEN
    MMP_RULES += SMPSAFE

    BLD_INF_RULES.prj_exports += "qtcomponentsextras_1_0.iby $$CORE_MW_LAYER_IBY_EXPORT_PATH(qtcomponentsextras_1_0.iby)"

    stubsis = \
        "START EXTENSION app-services.buildstubsis" \
        "OPTION SISNAME symbianextrasplugin_1_0_stub" \
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

    header = "$${LITERAL_HASH}{\"symbianextrasplugin_1_0\"},(0x2003A913),1,0,0,TYPE=SA,RU"
    package.pkg_prerules += vendor_info header
    DEPLOYMENT += package
}

include(../../../qml.pri)
