pragma Singleton
import QtQuick 2.15

QtObject{
    property bool darkTheme: true

    property color background: darkTheme ? "#17171b" : "#f7f5fb"
    property color backgroundShade: darkTheme ? "#2b2b2f" : "#b99ae6"
    property color substrate: darkTheme ? "#000000" : "#ede7ff"
    property color lighterSubstrate: darkTheme ? "#191919" : "#f7f5fb"

    property color invertedBackground: darkTheme ? "#ffffff" : "#17171b"
    property color invertedbackgroundShade: darkTheme ? "#d5d5d5" : "#2b2b2f"
    property color invertedSubstrate: darkTheme ? "#d5d5d5" : "#000000"
    property color invertedLighterSubstrate: darkTheme ? "#ecebeb" : "#191919"

    property color text: darkTheme ? "#ffffff" : "#000000"
    property color hover: darkTheme ? "#3d0e69" : "#b99ae6"

    property color main: "#8a2be2"
    property color additional:darkTheme ? "#d05ce3" : "#3d0e69"

    property color mainError: "#ff0000"
    property color additionalError: "#c60046"
}