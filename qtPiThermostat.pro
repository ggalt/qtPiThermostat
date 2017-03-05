QT += network

# Additional import path used to resolve QML modules in Creator's code model
QML_IMPORT_PATH =

# The .cpp file which was generated for your project. Feel free to hack it.
SOURCES += main.cpp \
    forecastlistmodel.cpp \
    qthermoappviewer.cpp \
    weatherdata.cpp \
    weathernetworkconnection.cpp \
    thermostateventmodel.cpp \
    thermoeventmonitor.cpp \
    serverconnection.cpp

#so we can test on windows, if we absolutely have to!!
unix {
SOURCES += source/common_dht_read.c \
    source/Raspberry_Pi/pi_dht_read.c \
    source/Raspberry_Pi/pi_mmio.c
}

RESOURCES += qml.qrc

# Installation path
# target.path =

# Please do not modify the following two lines. Required for deployment.
include(qtquick1applicationviewer/qtquick1applicationviewer.pri)

# Default rules for deployment.
include(deployment.pri)

HEADERS += \
    forecastlistmodel.h \
    qthermoappviewer.h \
    weatherdata.h \
    weathernetworkconnection.h \
    thermostateventmodel.h \
    thermoeventmonitor.h \
    wiringPi/wiringPi.h \
    serverconnection.h

unix {
HEADERS += source/common_dht_read.h \
    source/Raspberry_Pi/pi_dht_read.h \
    source/Raspberry_Pi/pi_mmio.h
}
