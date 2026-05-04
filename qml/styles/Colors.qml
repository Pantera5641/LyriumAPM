pragma Singleton
import QtQuick 2.15

QtObject{
    property bool darkTheme: true

    property color background: darkTheme ? "#17171b" : "#ffffff"
    property color backgroundShade: darkTheme ? "#2b2b2f" : "#d5d5d5"
    property color substrate: darkTheme ? "#000000" : "#d5d5d5"

    property color invertedBackground: darkTheme ? "#ffffff" : "#17171b"
    property color invertedbackgroundShade: darkTheme ? "#d5d5d5" : "#2b2b2f"
    property color invertedSubstrate: darkTheme ? "#d5d5d5" : "#000000"

    property color text: darkTheme ? "#ffffff" : "#000000"

    property color main: "#8a2be2"
    property color additional: "#d05ce3"

    property color mainError: "#ff0000"
    property color additionalError: "#c60046"
}