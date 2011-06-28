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

#include "utilities.h"
#include "geometry.h"
//#include "flatcolormaterial.h"
//#include "vertexcolormaterial.h"

#include <QtGui>
#include <QGLShaderProgram>


//SubTexture2D::SubTexture2D(TextureAtlasInterface *atlas, const QRect &allocatedRect)
//    : m_allocated(allocatedRect)
//    , m_atlas(atlas)
//    , m_texture(atlas->texture())
//{
//    qreal w = m_texture->size().width();
//    qreal h = m_texture->size().height();
//    m_source = QRectF(m_allocated.x() / w, m_allocated.y() / h, m_allocated.width() / w, m_allocated.height() / h);
//}

//SubTexture2D::SubTexture2D(const QGLTexture2DConstPtr &texture)
//    : m_source(0, 0, 1, 1)
//    , m_atlas(0)
//    , m_texture(texture)
//{
//}

//SubTexture2D::~SubTexture2D()
//{
//    if (m_atlas) {
//        Q_ASSERT(!m_allocated.isNull());
//        m_atlas->deallocate(m_allocated);
//    }
//}


void Utilities::setupRectGeometry(Geometry *geometry, const QRectF &rect, const QSize &textureSize, const QRectF &sourceRect)
{
    geometry->setDrawingMode(QGL::TriangleStrip);
    geometry->setVertexCount(4);

    const QVector<QGLAttributeDescription> &d = geometry->vertexDescription();
    int offset = 0;
    for (int i = 0; i < d.size(); ++i) {
        if (d.at(i).attribute() == QGL::Position) {
            Q_ASSERT(d.at(i).tupleSize() >= 2);
            Q_ASSERT(d.at(i).type() == GL_FLOAT);
            for (int j = 0; j < 4; ++j) {
                float *f = (float *)((uchar *)geometry->vertexData() + geometry->stride() * j + offset);
                f[0] = j & 2 ? rect.right() : rect.left();
                f[1] = j & 1 ? rect.bottom() : rect.top();
                for (int k = 2; k < d.at(i).tupleSize(); ++k)
                    f[k] = k - 2;
            }
        } else if (d.at(i).attribute() == QGL::TextureCoord0) {
            Q_ASSERT(d.at(i).tupleSize() >= 2);
            Q_ASSERT(d.at(i).type() == GL_FLOAT);

            qreal pw = textureSize.width();
            qreal ph = textureSize.height();

            for (int j = 0; j < 4; ++j) {
                float *f = (float *)((uchar *)geometry->vertexData() + geometry->stride() * j + offset);
                f[0] = (j & 2 ? sourceRect.right() : sourceRect.left()) / pw;
                f[1] = (j & 1 ? sourceRect.bottom() : sourceRect.top()) / ph;
                for (int k = 2; k < d.at(i).tupleSize(); ++k)
                    f[k] = k - 2;
            }
        }
        offset += d.at(i).tupleSize() * d.at(i).sizeOfType();
    }
}

QVector<QGLAttributeDescription> &Utilities::getRectGeometryDescription()
{
    static QVector<QGLAttributeDescription> desc;
    if (desc.isEmpty())
        desc << QGLAttributeDescription(QGL::Position, 2, GL_FLOAT, 2 * sizeof(float));
    return desc;
}

QVector<QGLAttributeDescription> &Utilities::getTexturedRectGeometryDescription()
{
    static QVector<QGLAttributeDescription> desc;
    if (desc.isEmpty()) {
        desc << QGLAttributeDescription(QGL::Position, 2, GL_FLOAT, 4 * sizeof(float));
        desc << QGLAttributeDescription(QGL::TextureCoord0, 2, GL_FLOAT, 4 * sizeof(float));
    }
    return desc;
}

QVector<QGLAttributeDescription> &Utilities::getColoredRectGeometryDescription()
{
    static QVector<QGLAttributeDescription> desc;
    if (desc.isEmpty()) {
        desc << QGLAttributeDescription(QGL::Position, 2, GL_FLOAT, 6 * sizeof(float));
        desc << QGLAttributeDescription(QGL::Color, 4, GL_FLOAT, 6 * sizeof(float));
    }
    return desc;
}

Geometry *Utilities::createRectGeometry(const QRectF &rect)
{
    Geometry *g = new Geometry(getRectGeometryDescription(), GL_UNSIGNED_SHORT);
    setupRectGeometry(g, rect);
    return g;
}

Geometry *Utilities::createTexturedRectGeometry(const QRectF &rect, const QSize &textureSize, const QRectF &sourceRect)
{
    Geometry *g = new Geometry(getTexturedRectGeometryDescription(), GL_UNSIGNED_SHORT);
    setupRectGeometry(g, rect, textureSize, sourceRect);
    return g;
}

//static struct TextureCache
//{
//    ~TextureCache()
//    {
//        QList<QWeakPointer<SubTexture2D> > t = textures.values();
//        int count = 0;
//        for (int i = 0; i < t.size(); ++i) {
//            if (!t.at(i).isNull())
//                ++count;
//        }
//        qDebug("Textures left in the texture cache: %i", count);
//        count = 0;
//        for (int i = 0; i < AtlasTypeCount; ++i) {
//            count += atlases[i].size();
//            qDeleteAll(atlases[i]);
//        }
//        qDebug("Number of texture atlases used: %i", count);
//    }

//    struct Key {
//        qint64 imageKey;
//        uint clampToEdge : 1;
//        bool operator == (const Key &other) const
//        {
//            return imageKey == other.imageKey && clampToEdge == other.clampToEdge;
//        }
//    };

//    enum AtlasType
//    {
//        StaticAtlasType,
//        DynamicAtlasType,
//        AtlasTypeCount
//    };

//    typedef QHash<Key, QWeakPointer<SubTexture2D> > Hash;

//    static SubTexture2DPtr insert(const TextureCache::Key &key, const QImage &image, bool clampToEdge, bool dynamic);

//    // ### Replace with a QCache or something to avoid growing to infinity and beyond.
//    Hash textures;
//    QVector<TextureAtlasInterface *> atlases[AtlasTypeCount];
//} textureCache;

//uint qHash(const TextureCache::Key &key)
//{
//    return qHash(key.imageKey) ^ uint(key.clampToEdge << 31);
//}

//SubTexture2DPtr TextureCache::insert(const TextureCache::Key &key, const QImage &image, bool clampToEdge, bool dynamic)
//{
//    AtlasType type = (dynamic ? DynamicAtlasType : StaticAtlasType);
//    uint flags = (dynamic ? TextureAtlasInterface::DynamicFlag : 0);

//    // Make sure that there is at least one texture atlas.
//    if (textureCache.atlases[type].isEmpty())
//        textureCache.atlases[type].append(qt_adaptation_layer()->createTextureAtlas(flags));

//    // The texture atlas is used for many small images. If the image is somewhat big, create a separate texture for it.
//    QSize size = textureCache.atlases[type].first()->texture()->size();
//    if (image.width() > size.width() / 4 || image.height() > size.height() / 4) {
//        QGLTexture2DPtr texture(new QGLTexture2D);
//        texture->setImage(image);
//        texture->setBindOptions(QGLContext::InternalBindOption);
//        QGL::TextureWrap wrap = clampToEdge ? QGL::ClampToEdge : QGL::Repeat;
//        texture->setVerticalWrap(wrap);
//        texture->setHorizontalWrap(wrap);
//        SubTexture2DPtr subtex(new SubTexture2D(texture.constCast<const QGLTexture2D>()));
//        textureCache.textures.insert(key, subtex.toWeakRef());
//        return subtex;
//    }

//    // Look for an atlas with room for the image.
//    TextureAtlasInterface *atlas;
//    QRect allocated;
//    int i = 0;
//    do {
//        atlas = textureCache.atlases[type].at(i);
//        allocated = atlas->allocate(image, clampToEdge);
//        ++i;
//    } while (i < textureCache.atlases[type].size() && allocated.isNull());

//    // No room in the atlases, make a new atlas.
//    if (allocated.isNull()) {
//        atlas = qt_adaptation_layer()->createTextureAtlas(flags);
//        textureCache.atlases[type].append(atlas);
//        allocated = atlas->allocate(image, clampToEdge);
//    }

//    // ### Need to add out-of-memory handling.
//    Q_ASSERT(!allocated.isNull());
//    SubTexture2DPtr subtex(new SubTexture2D(atlas, allocated));
//    textureCache.textures.insert(key, subtex.toWeakRef());
//    return subtex;
//}

//SubTexture2DPtr Utilities::getTextureForImage(const QImage &image, bool clampToEdge, bool dynamic)
//{
//    TextureCache::Key key = {image.cacheKey(), clampToEdge};
//    TextureCache::Hash::const_iterator it = textureCache.textures.find(key);
//    SubTexture2DPtr texture;
//    if (it != textureCache.textures.end()) {
//        texture = it.value().toStrongRef();
//        if (!texture.isNull())
//            return texture;
//    }
//    return textureCache.insert(key, image, clampToEdge, dynamic);
//}

//SubTexture2DPtr Utilities::getTextureForPixmap(const QPixmap &pixmap, bool clampToEdge, bool dynamic)
//{
//    TextureCache::Key key = {pixmap.cacheKey(), clampToEdge};
//    TextureCache::Hash::const_iterator it = textureCache.textures.find(key);
//    SubTexture2DPtr texture;
//    if (it != textureCache.textures.end()) {
//        texture = it.value().toStrongRef();
//        if (!texture.isNull())
//        return texture;
//    }
//    QImage image = pixmap.toImage();
//    return textureCache.insert(key, image, clampToEdge, dynamic);
//}
