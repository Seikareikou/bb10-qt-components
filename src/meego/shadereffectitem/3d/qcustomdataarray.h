/****************************************************************************
**
** Copyright (C) 2011 Nokia Corporation and/or its subsidiary(-ies).
** All rights reserved.
** Contact: Nokia Corporation (qt-info@nokia.com)
**
** This file is part of the Qt Components project.
**
** $QT_BEGIN_LICENSE:BSD$
** You may use this file under the terms of the BSD license as follows:
**
** "Redistribution and use in source and binary forms, with or without
** modification, are permitted provided that the following conditions are
** met:
**   * Redistributions of source code must retain the above copyright
**     notice, this list of conditions and the following disclaimer.
**   * Redistributions in binary form must reproduce the above copyright
**     notice, this list of conditions and the following disclaimer in
**     the documentation and/or other materials provided with the
**     distribution.
**   * Neither the name of Nokia Corporation and its Subsidiary(-ies) nor
**     the names of its contributors may be used to endorse or promote
**     products derived from this software without specific prior written
**     permission.
**
** THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS
** "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT
** LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR
** A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT
** OWNER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL,
** SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT
** LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE,
** DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY
** THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
** (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE
** OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE."
** $QT_END_LICENSE$
**
****************************************************************************/

#ifndef QCUSTOMDATAARRAY_H
#define QCUSTOMDATAARRAY_H

#include "qarray.h"
#include "qcolor4ub.h"
#include <QtCore/qvariant.h>
#include <QtGui/qvector2d.h>
#include <QtGui/qvector3d.h>
#include <QtGui/qvector4d.h>

QT_BEGIN_HEADER

QT_BEGIN_NAMESPACE

class QGLVertexBufferCustomAttribute;
class QGeometryData;

class Q_QT3D_EXPORT QCustomDataArray
{
public:
    enum ElementType
    {
        Float,
        Vector2D,
        Vector3D,
        Vector4D,
        Color
    };

    QCustomDataArray();
    explicit QCustomDataArray(QCustomDataArray::ElementType type);
    QCustomDataArray(QCustomDataArray::ElementType type, int size);
    QCustomDataArray(const QCustomDataArray& other);
    QCustomDataArray(const QArray<float>& other);
    QCustomDataArray(const QArray<QVector2D>& other);
    QCustomDataArray(const QArray<QVector3D>& other);
    QCustomDataArray(const QArray<QVector4D>& other);
    QCustomDataArray(const QArray<QColor4ub>& other);
    ~QCustomDataArray();

    QCustomDataArray& operator=(const QCustomDataArray& other);

    QCustomDataArray::ElementType elementType() const;
    void setElementType(QCustomDataArray::ElementType type);

    int size() const;
    int count() const;

    int capacity() const;
    bool isEmpty() const;

    int elementSize() const;

    void clear();
    void reserve(int size);
    void resize(int size);
    void squeeze();

    QVariant at(int index) const;
    void setAt(int index, const QVariant& value);

    void setAt(int index, qreal x);
    void setAt(int index, qreal x, qreal y);
    void setAt(int index, qreal x, qreal y, qreal z);
    void setAt(int index, qreal x, qreal y, qreal z, qreal w);
    void setAt(int index, const QVector2D& value);
    void setAt(int index, const QVector3D& value);
    void setAt(int index, const QVector4D& value);
    void setAt(int index, const QColor4ub& value);
    void setAt(int index, Qt::GlobalColor value);

    qreal floatAt(int index) const;
    QVector2D vector2DAt(int index) const;
    QVector3D vector3DAt(int index) const;
    QVector4D vector4DAt(int index) const;
    QColor4ub colorAt(int index) const;

    void append(qreal x);
    void append(qreal x, qreal y);
    void append(qreal x, qreal y, qreal z);
    void append(qreal x, qreal y, qreal z, qreal w);
    void append(const QVector2D& value);
    void append(const QVector3D& value);
    void append(const QVector4D& value);
    void append(const QColor4ub& value);
    void append(const QVariant& value);
    void append(Qt::GlobalColor value);
    void append(const QCustomDataArray &array);

    QArray<float> toFloatArray() const;
    QArray<QVector2D> toVector2DArray() const;
    QArray<QVector3D> toVector3DArray() const;
    QArray<QVector4D> toVector4DArray() const;
    QArray<QColor4ub> toColorArray() const;

    const void *data() const;

private:
    QArray<float> m_array;
    QCustomDataArray::ElementType m_elementType;
    int m_elementComponents;

    friend class QGLVertexBufferCustomAttribute;
    friend class QGeometryData;
};

inline QCustomDataArray::QCustomDataArray()
    : m_elementType(QCustomDataArray::Float),
      m_elementComponents(1)
{
}

inline QCustomDataArray::QCustomDataArray(const QCustomDataArray& other)
    : m_array(other.m_array),
      m_elementType(other.m_elementType),
      m_elementComponents(other.m_elementComponents)
{
}

inline QCustomDataArray::~QCustomDataArray() {}

inline QCustomDataArray& QCustomDataArray::operator=(const QCustomDataArray& other)
{
    if (this != &other) {
        m_array = other.m_array;
        m_elementType = other.m_elementType;
        m_elementComponents = other.m_elementComponents;
    }
    return *this;
}

inline QCustomDataArray::ElementType QCustomDataArray::elementType() const
{
    return m_elementType;
}

inline int QCustomDataArray::size() const
{
    return m_array.size() / m_elementComponents;
}

inline int QCustomDataArray::count() const
{
    return m_array.size() / m_elementComponents;
}

inline int QCustomDataArray::capacity() const
{
    return m_array.capacity() / m_elementComponents;
}

inline bool QCustomDataArray::isEmpty() const
{
    return m_array.isEmpty();
}

inline int QCustomDataArray::elementSize() const
{
    return m_elementComponents * sizeof(float);
}

inline void QCustomDataArray::clear()
{
    m_array.clear();
}

inline void QCustomDataArray::reserve(int size)
{
    m_array.reserve(size * m_elementComponents);
}

inline void QCustomDataArray::resize(int size)
{
    m_array.resize(size * m_elementComponents);
}

inline void QCustomDataArray::squeeze()
{
    m_array.squeeze();
}

inline void QCustomDataArray::setAt(int index, qreal x)
{
    Q_ASSERT(m_elementType == QCustomDataArray::Float);
    Q_ASSERT(index >= 0 && index < size());
    m_array[index] = float(x);
}

inline void QCustomDataArray::setAt(int index, qreal x, qreal y)
{
    Q_ASSERT(m_elementType == QCustomDataArray::Vector2D);
    Q_ASSERT(index >= 0 && index < size());
    float *data = m_array.data() + index * 2;
    data[0] = float(x);
    data[1] = float(y);
}

inline void QCustomDataArray::setAt(int index, qreal x, qreal y, qreal z)
{
    Q_ASSERT(m_elementType == QCustomDataArray::Vector3D);
    Q_ASSERT(index >= 0 && index < size());
    float *data = m_array.data() + index * 3;
    data[0] = float(x);
    data[1] = float(y);
    data[2] = float(z);
}

inline void QCustomDataArray::setAt(int index, qreal x, qreal y, qreal z, qreal w)
{
    Q_ASSERT(m_elementType == QCustomDataArray::Vector4D);
    Q_ASSERT(index >= 0 && index < size());
    float *data = m_array.data() + index * 4;
    data[0] = float(x);
    data[1] = float(y);
    data[2] = float(z);
    data[3] = float(w);
}

inline void QCustomDataArray::setAt(int index, const QVector2D& value)
{
    Q_ASSERT(m_elementType == QCustomDataArray::Vector2D);
    Q_ASSERT(index >= 0 && index < size());
    float *data = m_array.data() + index * 2;
    data[0] = float(value.x());
    data[1] = float(value.y());
}

inline void QCustomDataArray::setAt(int index, const QVector3D& value)
{
    Q_ASSERT(m_elementType == QCustomDataArray::Vector3D);
    Q_ASSERT(index >= 0 && index < size());
    float *data = m_array.data() + index * 3;
    data[0] = float(value.x());
    data[1] = float(value.y());
    data[2] = float(value.z());
}

inline void QCustomDataArray::setAt(int index, const QVector4D& value)
{
    Q_ASSERT(m_elementType == QCustomDataArray::Vector4D);
    Q_ASSERT(index >= 0 && index < size());
    float *data = m_array.data() + index * 4;
    data[0] = float(value.x());
    data[1] = float(value.y());
    data[2] = float(value.z());
    data[3] = float(value.w());
}

inline void QCustomDataArray::setAt(int index, const QColor4ub& value)
{
    Q_ASSERT(m_elementType == QCustomDataArray::Color);
    Q_ASSERT(index >= 0 && index < size());
    *(reinterpret_cast<QColor4ub *>(m_array.data() + index)) = value;
}

inline void QCustomDataArray::setAt(int index, Qt::GlobalColor value)
{
    Q_ASSERT(m_elementType == QCustomDataArray::Color);
    Q_ASSERT(index >= 0 && index < size());
    *(reinterpret_cast<QColor4ub *>(m_array.data() + index)) = QColor4ub(value);
}

inline qreal QCustomDataArray::floatAt(int index) const
{
    Q_ASSERT(m_elementType == QCustomDataArray::Float);
    Q_ASSERT(index >= 0 && index < size());
    return m_array.at(index);
}

inline QVector2D QCustomDataArray::vector2DAt(int index) const
{
    Q_ASSERT(m_elementType == QCustomDataArray::Vector2D);
    Q_ASSERT(index >= 0 && index < size());
    const float *data = m_array.constData() + index * 2;
    return QVector2D(data[0], data[1]);
}

inline QVector3D QCustomDataArray::vector3DAt(int index) const
{
    Q_ASSERT(m_elementType == QCustomDataArray::Vector3D);
    Q_ASSERT(index >= 0 && index < size());
    const float *data = m_array.constData() + index * 3;
    return QVector3D(data[0], data[1], data[2]);
}

inline QVector4D QCustomDataArray::vector4DAt(int index) const
{
    Q_ASSERT(m_elementType == QCustomDataArray::Vector4D);
    Q_ASSERT(index >= 0 && index < size());
    const float *data = m_array.constData() + index * 4;
    return QVector4D(data[0], data[1], data[2], data[3]);
}

inline QColor4ub QCustomDataArray::colorAt(int index) const
{
    Q_ASSERT(m_elementType == QCustomDataArray::Color);
    Q_ASSERT(index >= 0 && index < size());
    return *(reinterpret_cast<const QColor4ub *>(m_array.constData() + index));
}

inline void QCustomDataArray::append(qreal x)
{
    Q_ASSERT(m_elementType == QCustomDataArray::Float);
    m_array.append(float(x));
}

inline void QCustomDataArray::append(qreal x, qreal y)
{
    Q_ASSERT(m_elementType == QCustomDataArray::Vector2D);
    m_array.append(float(x), float(y));
}

inline void QCustomDataArray::append(qreal x, qreal y, qreal z)
{
    Q_ASSERT(m_elementType == QCustomDataArray::Vector3D);
    m_array.append(float(x), float(y), float(z));
}

inline void QCustomDataArray::append(qreal x, qreal y, qreal z, qreal w)
{
    Q_ASSERT(m_elementType == QCustomDataArray::Vector4D);
    m_array.append(float(x), float(y), float(z), float(w));
}

inline void QCustomDataArray::append(const QVector2D& value)
{
    Q_ASSERT(m_elementType == QCustomDataArray::Vector2D);
    m_array.append(float(value.x()), float(value.y()));
}

inline void QCustomDataArray::append(const QVector3D& value)
{
    Q_ASSERT(m_elementType == QCustomDataArray::Vector3D);
    m_array.append(float(value.x()), float(value.y()), float(value.z()));
}

inline void QCustomDataArray::append(const QVector4D& value)
{
    Q_ASSERT(m_elementType == QCustomDataArray::Vector4D);
    m_array.append(float(value.x()), float(value.y()),
                   float(value.z()), float(value.w()));
}

inline void QCustomDataArray::append(const QColor4ub& value)
{
    Q_ASSERT(m_elementType == QCustomDataArray::Color);
    *(reinterpret_cast<QColor4ub *>(m_array.extend(1))) = value;
}

inline void QCustomDataArray::append(Qt::GlobalColor value)
{
    Q_ASSERT(m_elementType == QCustomDataArray::Color);
    *(reinterpret_cast<QColor4ub *>(m_array.extend(1))) = QColor4ub(value);
}

inline void QCustomDataArray::append(const QCustomDataArray &array)
{
    Q_ASSERT(isEmpty() || (array.elementType() == elementType()));
    if (isEmpty())
        *this = array;
    else
        m_array.append(array.m_array);
}

inline const void *QCustomDataArray::data() const
{
    return m_array.constData();
}

#ifndef QT_NO_DEBUG_STREAM
Q_QT3D_EXPORT QDebug operator<<(QDebug dbg, const QCustomDataArray &array);
#endif

QT_END_NAMESPACE

QT_END_HEADER

#endif
