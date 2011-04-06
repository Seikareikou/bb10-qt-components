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

#ifndef SDECLARATIVESTYLEINTERNAL_H
#define SDECLARATIVESTYLEINTERNAL_H

#include <QtCore/qobject.h>
#include <QtCore/qvariant.h>
#include <QtCore/qscopedpointer.h>
#include <QtGui/qcolor.h>

class SDeclarativeStyleInternalPrivate;
class SStyleEngine;

class SDeclarativeStyleInternal : public QObject
{
    Q_OBJECT

    Q_PROPERTY(int statusBarHeight READ statusBarHeight NOTIFY layoutParametersChanged FINAL)
    Q_PROPERTY(int tabBarHeightPortrait READ tabBarHeightPortrait NOTIFY layoutParametersChanged FINAL)
    Q_PROPERTY(int tabBarHeightLandscape READ tabBarHeightLandscape NOTIFY layoutParametersChanged FINAL)
    Q_PROPERTY(int toolBarHeightPortrait READ toolBarHeightPortrait NOTIFY layoutParametersChanged FINAL)
    Q_PROPERTY(int toolBarHeightLandscape READ toolBarHeightLandscape NOTIFY layoutParametersChanged FINAL)
    Q_PROPERTY(int scrollBarThickness READ scrollBarThickness NOTIFY layoutParametersChanged FINAL)
    Q_PROPERTY(int sliderThickness READ sliderThickness NOTIFY layoutParametersChanged FINAL)
    Q_PROPERTY(int menuItemHeight READ menuItemHeight NOTIFY layoutParametersChanged FINAL)
    Q_PROPERTY(int textFieldHeight READ textFieldHeight NOTIFY layoutParametersChanged FINAL)
    Q_PROPERTY(int switchButtonHeight READ switchButtonHeight NOTIFY layoutParametersChanged FINAL)
    Q_PROPERTY(int dialogMinSize READ dialogMinSize NOTIFY layoutParametersChanged FINAL)
    Q_PROPERTY(int dialogMaxSize READ dialogMaxSize NOTIFY layoutParametersChanged FINAL)
    Q_PROPERTY(int ratingIndicatorImageWidth READ ratingIndicatorImageWidth NOTIFY layoutParametersChanged FINAL)
    Q_PROPERTY(int ratingIndicatorImageHeight READ ratingIndicatorImageHeight NOTIFY layoutParametersChanged FINAL)
    Q_PROPERTY(QColor listItemSeparatorColor READ listItemSeparatorColor NOTIFY colorParametersChanged FINAL)
    Q_PROPERTY(int tumblerHeightPortrait READ tumblerHeightPortrait NOTIFY layoutParametersChanged FINAL)
    Q_PROPERTY(int tumblerHeightLandscape READ tumblerHeightLandscape NOTIFY layoutParametersChanged FINAL)
    Q_PROPERTY(int tumblerWidth READ tumblerWidth NOTIFY layoutParametersChanged FINAL)

public:

    explicit SDeclarativeStyleInternal(SStyleEngine *engine, QObject *parent = 0);
    ~SDeclarativeStyleInternal();

    int statusBarHeight() const;
    int tabBarHeightPortrait() const;
    int tabBarHeightLandscape() const;
    int toolBarHeightPortrait() const;
    int toolBarHeightLandscape() const;
    int scrollBarThickness() const;
    int sliderThickness() const;
    int menuItemHeight() const;
    int textFieldHeight() const;
    int switchButtonHeight() const;
    int dialogMinSize() const;
    int dialogMaxSize() const;
    int ratingIndicatorImageWidth() const;
    int ratingIndicatorImageHeight() const;
    QColor listItemSeparatorColor() const;
    int tumblerHeightPortrait() const;
    int tumblerHeightLandscape() const;
    int tumblerWidth() const;

    Q_INVOKABLE void play(int effect);
    Q_INVOKABLE int textWidth(const QString &text, const QFont &font) const;
    Q_INVOKABLE int fontHeight(const QFont &font) const;
    Q_INVOKABLE QString imagePath(const QString &path) const;

Q_SIGNALS:
    void layoutParametersChanged();
    void colorParametersChanged();

protected:
    QScopedPointer<SDeclarativeStyleInternalPrivate> d_ptr;

private:
    Q_DISABLE_COPY(SDeclarativeStyleInternal)
    Q_DECLARE_PRIVATE(SDeclarativeStyleInternal)
};

#endif // SDECLARATIVESTYLEINTERNAL_H
