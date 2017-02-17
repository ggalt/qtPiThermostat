import QtQuick 1.1


Rectangle {
    id: mainRectangle
    width: 320
    height: 240
    objectName: "mainRectangle"

    //////////////////////////////////////////////////////////
    // properties for main screen
    property string curTemp: ""
    property int targetHiTemp: 80
    property int targetLoTemp: 60
    property string curHumidity: ""
    property string curDate: ""
    property string curTime: ""
    property bool showColon: true
    property string outsideCurrentTemp: ""
    property string currentWeatherIcon: ""
    property int fanState: 0
    property int coolingState: 0
    property string tempScale: "F"
    property string sourceHeatingImage: "icons/heating.png"

    //////////////////////////////////////////////////////////
    // properties for weather screen
    property string todayHiTemp: ""
    property string todayLoTemp: ""
    property string tomorrowHiTemp: ""
    property string tomorrowLoTemp: ""
    property string nextDayHiTemp: ""
    property string nextDayLoTemp: ""
    property string todayName: ""
    property string tomorrowName: ""
    property string nextDayName: ""
    property string todayIcon: ""
    property string tomorrowIcon: ""
    property string nextDayIcon: ""

    //////////////////////////////////////////////////////////
    // properties for thermostat event
    property string eventDayOfWeek: ""
    property string eventTime: ""
    property int eventTemp: 0
    property bool eventIsHeat: true

    //////////////////////////////////////////////////////////
    // signals
    signal mainAppState(string appState)
    signal captureThermostatEventInfo(string dayOfWeek, string targetTime, double loTemp, double HiTemp)

    //////////////////////////////////////////////////////////
    // functions
    function setHeatingState(heatingState) {
        if(heatingState === "heat") {
            sourceHeatingImage = "icons/heating.png"
//            console.log("heating and using", sourceHeatingImage)
        } else if(heatingState === "cool"){
            sourceHeatingImage = "icons/cooling.png"
//            console.log("cooling and using", sourceHeatingImage)
        } else {
            sourceHeatingImage = "icons/ACandHeatOff.png"
//            console.log("doing nothing and using", sourceHeatingImage)
        }
    }

    function changeAppState(appState) {
        mainRectangle.state = appState
        mainAppState(appState)
    }

    function getTime() {
        curDate = Qt.formatDate(new Date(),"MMM dd, yyyy");
        if(showColon) {
            curTime = Qt.formatTime(new Date(), "hh:mm AP")
        } else {
            curTime = Qt.formatTime(new Date(), "hh mm AP")
        }
        showColon = !showColon;
    }

    function convertFromKelvin(temp) {
        if(tempScale === "F") {
            return (temp * 9)/5 - 459.67
        } else {
            return temp - 273.15
        }
    }

    function setWeatherIcon(myWeatherIcon) {
        if(weatherIconTimer.interval===6000)
            weatherIconTimer.interval=60*1000*5
//        console.log("setWeatherIcon called in main.qml")

        switch(myWeatherIcon) {
        case "01d":
        case "01n":
            return "icons/weather-sunny.png"
        case "02d":
        case "02n":
            return "icons/weather-sunny-very-few-clouds.png"
        case "03d":
        case "03n":
            return "icons/weather-few-clouds.png"
        case "04d":
        case "04n":
            return "icons/weather-overcast.png"
        case "09d":
        case "09n":
            return "icons/weather-showers.png"
        case "10d":
        case "10n":
            return "icons/weather-showers.png"
        case "11d":
        case "11n":
            return "icons/weather-thundershower.png"
        case "13d":
        case "13n":
            return "icons/weather-snow.png"
        case "50d":
        case "50n":
            return "icons/weather-fog.png"
        default:
            return "icons/weather-sunny-very-few-clouds.png"
        }
    }

    //////////////////////////////////////////////////////////
    // timers
    Timer {
        id: weatherIconTimer
        interval: 6000
        repeat: true
        running: true
        triggeredOnStart: true
    }

    Timer {
        id: textTimer
        interval: 500
        repeat: true
        running: true
        triggeredOnStart: true
        onTriggered: getTime()
    }

    //////////////////////////////////////////////////////////
    // page loader
    Loader {
        id: loader
        onLoaded: {
            item.fadeIn()
            item.setCurrentWeatherIcon()
            weatherIconTimer.triggered.connect(item.setCurrentWeatherIcon)
        }
    }

    states: [
        State {
            name: "MainWindowState"
            PropertyChanges {
                target: loader;
                source: "MainWindow.qml"
            }
        },
        State {
            name: "EventWindowState"
            PropertyChanges {
                target: loader
                source: "EventListWin.qml"
            }
        },
        State {
            name: "WeatherWindowState"
            PropertyChanges {
                target: loader
                source: "WeatherWindow.qml"
            }
        },
        State {
            name: "AddEventState"
            PropertyChanges {
                target: loader
                source: "thermoEventPage.qml"

            }
        },
        State {
            name: "SpashScreenState"
            PropertyChanges {
                target: loader
                source: "SplashScreen.qml"
            }
        }
    ]

    state: "SpashScreenState"
}       /// end mainRectangle


//    function captureThermostatEventInfo(dayOfWeek, targetTime, mytargetTemp, isHeat) {
//        eventDayOfWeek = dayOfWeek
//        eventTime = targetTime
//        eventTemp = mytargetTemp
//        eventIsHeat = isHeat
//        console.log("captureThermostatEventInfo:", eventDayOfWeek, eventTime, eventTemp, "Heat =", eventIsHeat)
//    }

//    ThermostatEventModel {
//        id: eventListModel
//        ListElement {
//            name: "Grey"
//            colorCode: "grey"
//        }

//        ListElement {
//            name: "Red"
//            colorCode: "red"
//        }

//        ListElement {
//            name: "Blue"
//            colorCode: "blue"
//        }

//        ListElement {
//            name: "Green"
//            colorCode: "green"
//        }
//    }

//    ForecastListModel {
//        id: forecastListModel
//    }

//    Timer {
//        id: introTimer
//        interval: 700
//        repeat: false
//        running: true
//        triggeredOnStart: true
//        onTriggered: state="MainWindowState"
//    }

    /*
     * Icon list
     * Day icon 	Night icon 	Description
     * 01d.png      01n.png 	clear sky
     * 02d.png      02n.png 	few clouds
     * 03d.png      03n.png 	scattered clouds
     * 04d.png      04n.png 	broken clouds
     * 09d.png      09n.png 	shower rain
     * 10d.png      10n.png 	rain
     * 11d.png      11n.png 	thunderstorm
     * 13d.png      13n.png 	snow
     * 50d.png      50n.png 	mist
     */
//        function setWeatherIcon() {
//            switch(weatherIcon) {
//            case "01d":
//            case "01n":
//                imgCurrentWeather.source = "icons/weather-sunny.png"
//                break;
//            case "02d":
//            case "02n":
//                imgCurrentWeather.source = "icons/weather-sunny-very-few-clouds.png"
//                break;
//            case "03d":
//            case "03n":
//                imgCurrentWeather.source = "icons/weather-few-clouds.png"
//                break;
//            case "04d":
//            case "04n":
//                imgCurrentWeather.source = "icons/weather-overcast.png"
//                break;
//            case "09d":
//            case "09n":
//                imgCurrentWeather.source = "icons/weather-showers.png"
//                break;
//            case "10d":
//            case "10n":
//                imgCurrentWeather.source = "icons/weather-showers.png"
//                break;
//            case "11d":
//            case "11n":
//                imgCurrentWeather.source = "icons/weather-thundershower.png"
//                break;
//            case "13d":
//            case "13n":
//                imgCurrentWeather.source = "icons/weather-snow.png"
//                break;
//            case "50d":
//            case "50n":
//                imgCurrentWeather.source = "icons/weather-fog.png"
//                break;
//            default:
//                imgCurrentWeather.source = "icons/weather-sunny-very-few-clouds.png"
//                break;
//            }
//            if(weatherIconTimer.interval===6000)
//                weatherIconTimer.interval=60*1000*5
//        }
