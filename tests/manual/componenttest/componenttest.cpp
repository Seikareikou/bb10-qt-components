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

#if defined(Q_COMPONENTS_SYMBIAN) && !defined(Q_OS_SYMBIAN) && !defined(Q_WS_SIMULATOR)
#include "settingswindow.h"
#endif
#include "utils.h"
#include <QApplication>
#include <QDeclarativeView>
#include <QDeclarativeEngine>
#include <QDeclarativeItem>
#include <QDir>

int main(int argc, char **argv)
{
    QApplication app(argc, argv);
    qmlRegisterType<FileAccess>("FileAccess", 1, 0, "FileAccess");
    qmlRegisterType<Settings>("Settings", 1, 0, "Settings");

    QDeclarativeView view;
    view.engine()->addImportPath(Q_COMPONENTS_BUILD_TREE"/imports");

#ifndef Q_OS_SYMBIAN
    QDir::setCurrent(app.applicationDirPath());
#endif
    view.setSource(QUrl::fromLocalFile("main.qml"));
    view.show();

#if defined(Q_COMPONENTS_SYMBIAN) && !defined(Q_OS_SYMBIAN) && !defined(Q_WS_SIMULATOR)
    SettingsWindow settingsWindow(&view);
#endif
    return app.exec();
}
