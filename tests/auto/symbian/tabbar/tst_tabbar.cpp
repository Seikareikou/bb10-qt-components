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

#include "tst_quickcomponentstest.h"
#include <QTest>
#include <QGraphicsObject>
#include <QDeclarativeItem>

class tst_tabbar : public QObject
{
    Q_OBJECT

private slots:
    void initTestCase();
    void defaultPropertyValues();

private:
    QScopedPointer<QObject> componentObject;
};

void tst_tabbar::initTestCase()
{
    QString errors;
    componentObject.reset(tst_quickcomponentstest::createComponentFromFile("tst_tabbar.qml", &errors));
    QVERIFY2(componentObject, qPrintable(errors));
}

void tst_tabbar::defaultPropertyValues()
{
    QGraphicsObject *testLayout = componentObject->findChild<QGraphicsObject*>("testTabBar");
    QVERIFY(testLayout);
    QVERIFY(testLayout->property("width").value<qreal>() > 0);
    QVERIFY(testLayout->property("height").value<qreal>() > 0);
}

QTEST_MAIN(tst_tabbar)
#include "tst_tabbar.moc"
