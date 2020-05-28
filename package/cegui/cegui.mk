################################################################################
#
# cegui
#
################################################################################

CEGUI_VERSION = 0-8-7
CEGUI_SITE = $(call github,cegui,cegui,v$(CEGUI_VERSION))
CEGUI_LICENSE = MIT
CEGUI_LICENSE_FILES = COPYING
CEGUI_INSTALL_STAGING = YES
CEGUI_CONF_OPTS += -DCEGUI_BUILD_XMLPARSER_XERCES=OFF \
		   -DCEGUI_HAS_MINIZIP_RESOURCE_PROVIDER=OFF \
		   -DCEGUI_BUILD_RENDERER_OGRE=OFF
CEGUI_DEPENDENCIES = glm \
		$(if $(BR2_PACKAGE_LIBGLFW),libglfw) \
		$(if $(BR2_PACKAGE_HAS_LIBGL),libgl) \
		$(if $(BR2_PACKAGE_HAS_LIBGLES),libgles) \
		$(if $(BR2_PACKAGE_LIBGLEW),libglew) \
		$(if $(BR2_PACKAGE_LIBICONV),libiconv)

# libepoxy support cannot be enabled together with libglew
ifeq ($(BR2_PACKAGE_LIBEPOXY):$(BR2_PACKAGE_LIBGLEW),y:)
CEGUI_DEPENDENCIES += libepoxy
CEGUI_CONF_OPTS += -DCEGUI_USE_EPOXY=ON
else
CEGUI_CONF_OPTS += -DCEGUI_USE_EPOXY=OFF
endif

ifeq ($(BR2_PACKAGE_EXPAT),y)
CEGUI_DEPENDENCIES += expat
CEGUI_CONF_OPTS += -DCEGUI_BUILD_XMLPARSER_EXPAT=ON
else
CEGUI_CONF_OPTS += -DCEGUI_BUILD_XMLPARSER_EXPAT=OFF
endif

ifeq ($(BR2_PACKAGE_IRRLICHT),y)
CEGUI_DEPENDENCIES += irrlicht
CEGUI_CONF_OPTS += -DCEGUI_BUILD_RENDERER_IRRLICHT=ON
else
CEGUI_CONF_OPTS += -DCEGUI_BUILD_RENDERER_IRRLICHT=OFF
endif

ifeq ($(BR2_PACKAGE_SDL2)$(BR2_PACKAGE_SDL2_IMAGE),yy)
CEGUI_DEPENDENCIES += sdl2 sdl2_image
CEGUI_CONF_OPTS += -DCEGUI_BUILD_IMAGECODEC_SDL2=ON
else
CEGUI_CONF_OPTS += -DCEGUI_BUILD_IMAGECODEC_SDL2=OFF
endif

ifeq ($(BR2_PACKAGE_PCRE),y)
CEGUI_DEPENDENCIES += pcre
CEGUI_CONF_OPTS += -DCEGUI_HAS_PCRE_REGEX=ON
else
CEGUI_CONF_OPTS += -DCEGUI_HAS_PCRE_REGEX=OFF
endif

ifeq ($(BR2_PACKAGE_FREETYPE),y)
CEGUI_DEPENDENCIES += freetype
CEGUI_CONF_OPTS += -DCEGUI_HAS_FREETYPE=ON
else
CEGUI_CONF_OPTS += -DCEGUI_HAS_FREETYPE=OFF
endif

ifeq ($(BR2_PACKAGE_LIBXML2),y)
CEGUI_DEPENDENCIES += libxml2
CEGUI_CONF_OPTS += -DCEGUI_BUILD_XMLPARSER_LIBXML2=ON
else
CEGUI_CONF_OPTS += -DCEGUI_BUILD_XMLPARSER_LIBXML2=OFF
endif

ifeq ($(BR2_PACKAGE_RAPIDXML),y)
CEGUI_DEPENDENCIES += rapidxml
CEGUI_CONF_OPTS += -DCEGUI_BUILD_XMLPARSER_RAPIDXML=ON
else
CEGUI_CONF_OPTS += -DCEGUI_BUILD_XMLPARSER_RAPIDXML=OFF
endif

ifeq ($(BR2_PACKAGE_TINYXML),y)
CEGUI_DEPENDENCIES += tinyxml
CEGUI_CONF_OPTS += -DCEGUI_BUILD_XMLPARSER_TINYXML=ON
else
CEGUI_CONF_OPTS += -DCEGUI_BUILD_XMLPARSER_TINYXML=OFF
endif

ifeq ($(BR2_PACKAGE_TINYXML2),y)
CEGUI_DEPENDENCIES += tinyxml2
CEGUI_CONF_OPTS += -DCEGUI_BUILD_XMLPARSER_TINYXML2=ON
else
CEGUI_CONF_OPTS += -DCEGUI_BUILD_XMLPARSER_TINYXML2=OFF
endif

ifeq ($(BR2_PACKAGE_LIBFREEIMAGE),y)
CEGUI_DEPENDENCIES += libfreeimage
CEGUI_CONF_OPTS += -DCEGUI_BUILD_IMAGECODEC_FREEIMAGE=ON
else
CEGUI_CONF_OPTS += -DCEGUI_BUILD_IMAGECODEC_FREEIMAGE=OFF
endif

$(eval $(cmake-package))
