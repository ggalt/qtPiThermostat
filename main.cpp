#include "qthermoappviewer.h"
#include "thermostateventmodel.h"
#include "forecastlistmodel.h"
#include "weatherdata.h"
#include <QApplication>

int main(int argc, char *argv[])
{
    QApplication app(argc, argv);

    // establish for QSettings
    QCoreApplication::setOrganizationName("GaltIndustries");
    QCoreApplication::setOrganizationDomain("georgegalt.com");
    QCoreApplication::setApplicationName("qtPiThermostat");

    qmlRegisterType<thermostatEventModel>("com.georgegalt", 1, 0, "ThermostatEventModel");
    qmlRegisterType<forecastListModel>("com.georgegalt", 1, 0, "ForecastListModel");

    qThermoAppViewer viewer;
    viewer.addImportPath(QLatin1String("modules"));
    viewer.setOrientation(QtQuick1ApplicationViewer::ScreenOrientationAuto);
    viewer.setMainQmlFile(QLatin1String("qrc:main.qml"));
    viewer.Init();
//    QObject *obj = (QObject*)viewer.rootObject();

//    QObject::connect(obj, SIGNAL(showEventWindow()), &viewer, SLOT(LaunchEventListWin()));
    viewer.showExpanded();

    return app.exec();
}
