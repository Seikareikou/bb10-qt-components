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

#include <QtTest/QtTest>
#include <QtTest/QSignalSpy>
#include <QtDeclarative/qdeclarativecontext.h>
#include <QtDeclarative/qdeclarativeview.h>

#include "tst_quickcomponentstest.h"

class tst_quickcomponentsradiobutton : public QObject

{
    Q_OBJECT
private slots:
    void initTestCase();
    void checked();
    void pressed();
    void clicked();

private:
    QStringList standard;
    QString qmlSource;

    QObject *componentObject;
};


void tst_quickcomponentsradiobutton::initTestCase()
{
    QString errors;
    componentObject = tst_quickcomponentstest::createComponentFromFile("tst_quickcomponentsradiobutton.qml", &errors);
    QVERIFY2(componentObject, qPrintable(errors));
}

void tst_quickcomponentsradiobutton::checked()
{
    componentObject->setProperty("checked",false);
    QCOMPARE(componentObject->property("checked").toBool(),false);
    componentObject->setProperty("checked",true);
    QCOMPARE(componentObject->property("checked").toBool(),true);
}

void tst_quickcomponentsradiobutton::pressed()
{
    componentObject->setProperty("pressed",false);
    QCOMPARE(componentObject->property("pressed").toBool(),false);
    componentObject->setProperty("pressed",true);
    QCOMPARE(componentObject->property("pressed").toBool(),true);
}

void tst_quickcomponentsradiobutton::clicked()
{
    QSignalSpy spy(componentObject, SIGNAL(clicked()));
    QMetaObject::invokeMethod(componentObject,"clicked",Qt::DirectConnection);
    QCOMPARE(spy.count(),1);
    QVERIFY(spy.isValid());
}

QTEST_MAIN(tst_quickcomponentsradiobutton)

#include "tst_quickcomponentsradiobutton.moc"
