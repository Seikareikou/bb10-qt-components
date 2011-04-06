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

#ifndef APICHECKBASE_H
#define APICHECKBASE_H

#include <QtTest/QtTest>
#include <QtCore/QObject>
#include <QtCore/QVariant>


class QDeclarativeEngine;

class ApiCheckBase : public QObject
{
    Q_OBJECT

public:
    ApiCheckBase(QDeclarativeEngine *engine, const QString &module);
    virtual ~ApiCheckBase();

protected:
    void init(const QString &name, const QString &body = QString());
    void initContextProperty(const QString &name);
    void validateProperty(const QString &propertyName, const QString &typeName) const;
    void validateProperty(const QString &propertyName, QVariant::Type propertyType,
                          const QVariant &value = QVariant()) const;
    void validateDeclarativeProperty(const QString &name, const QString &typeName) const;
    void validateEnumProperty(const QString &propertyName, const QVariant &value = QVariant()) const;
    void validateFlagProperty(const QString &propertyName, const QVariant &value = QVariant()) const;
    void validateSignal(const char *signalName) const;
    void validateMethod(const char *methodName) const;

private:
    QMetaProperty metaProperty(const QString &name) const;

    QString m_name;
    QString m_module;
    QObject *m_object;
    QDeclarativeEngine *m_engine;
};

#endif
