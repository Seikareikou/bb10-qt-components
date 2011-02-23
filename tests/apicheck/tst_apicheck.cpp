/****************************************************************************
**
** Copyright (C) 2010 Nokia Corporation and/or its subsidiary(-ies).
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

#include <QtTest/QtTest>
#include <QtDeclarative/qdeclarativeview.h>
#include <QtDeclarative/qdeclarativeengine.h>

#include "slider/apicheck_slider.h"
#include "button/apicheck_button.h"
#include "checkbox/apicheck_checkbox.h"
#include "radiobutton/apicheck_radiobutton.h"
#include "textfield/apicheck_textfield.h"
#include "progressbar/apicheck_progressbar.h"
#include "textarea/apicheck_textarea.h"
#include "scrolldecorator/apicheck_scrolldecorator.h"
#include "choicelist/apicheck_choicelist.h"

#ifndef Q_COMPONENTS_SYMBIAN
#include "busyindicator/apicheck_busyindicator.h"
#include "buttoncolumn/apicheck_buttoncolumn.h"
#include "buttonrow/apicheck_buttonrow.h"
#endif

int main(int argc, char *argv[])
{
    QApplication app(argc, argv);
    QStringList args = app.arguments();

    QDeclarativeView view;
    QDeclarativeEngine *engine = view.engine();

    // check for module
    QString module("Qt.labs.components.native 1.0");
    int moduleIdx = args.indexOf("-module");

    if (moduleIdx != -1) {
        args.removeAt(moduleIdx);
        module = args.takeAt(moduleIdx++);
    }

    // check for import path
    QString importPath(Q_COMPONENTS_BUILD_TREE"/imports");
    int pathIdx = args.indexOf("-importpath");

    if (pathIdx != -1) {
        args.removeAt(pathIdx);
        importPath = args.takeAt(pathIdx++);
    }

    // setup engine's import path
    engine->addImportPath(QDir(importPath).canonicalPath());    //QTBUG-16885

    // create tests
    ApiCheckSlider slider(engine, module);
    ApiCheckButton button(engine, module);
    ApiCheckCheckBox checkbox(engine, module);
    ApiCheckTextField textField(engine, module);
    ApiCheckRadioButton radioButton(engine, module);
    ApiCheckProgressBar progressBar(engine, module);
    ApiCheckTextArea textArea(engine, module);
    ApiCheckScrollDecorator scrollDecorator(engine, module);
    ApiCheckChoiceList choiceList(engine, module);

#ifndef Q_COMPONENTS_SYMBIAN
    ApiCheckBusyIndicator busyIndicator(engine, module);
    ApiCheckButtonColumn buttonColumn(engine, module);
    ApiCheckButtonRow buttonRow(engine, module);
#endif

    int ret = 0;
    ret |= QTest::qExec(&slider, args);
    ret |= QTest::qExec(&button, args);
    ret |= QTest::qExec(&checkbox, args);
    ret |= QTest::qExec(&textField, args);
    ret |= QTest::qExec(&radioButton, args);
    ret |= QTest::qExec(&progressBar, args);
    ret |= QTest::qExec(&textArea, args);
    ret |= QTest::qExec(&scrollDecorator, args);
    ret |= QTest::qExec(&choiceList, args);

#ifndef Q_COMPONENTS_SYMBIAN
    ret |= QTest::qExec(&busyIndicator, args);
    ret |= QTest::qExec(&buttonColumn, args);
    ret |= QTest::qExec(&buttonRow, args);
#endif

    return ret;
}