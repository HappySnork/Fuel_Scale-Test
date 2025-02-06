import QtQuick 2.15
import QtQuick.Shapes 1.15
import QtQuick.Controls 2.15

Item {
    id: scale
    width: 200
    height: 400

    property color scaleColor: "black"
    property color tickColor: "gray"
    property color arrowColor: "red"
    property real fuelLevel: 50 // Текущий уровень топлива (0-100)
    property int minValue: 0 // Минимальное значение шкалы
    property int maxValue: 100 // Максимальное значение шкалы

    Rectangle {
        width: 2
        height: parent.height
        color: scaleColor
        anchors.centerIn: parent
    }

    Repeater {
        model: 11 // Количество рисок (10 основных + 1 дополнительная)
        delegate: Item {
            x: parent.width / 2 - (index % 2 === 0 ? 10 : 5) // Широкие и узкие риски
            y: parent.height - (index * (parent.height / 10)) //Расположение рисок от мнимума снизу к максимуму сверху
            width: index % 2 === 0 ? 20 : 10
            height: 2
            Rectangle {
                width: parent.width
                height: parent.height
                color: tickColor
            }
            Text {
                visible: index % 2 === 0
                text: minValue + index * ((maxValue - minValue) / 10)
                anchors.left: parent.right
                anchors.leftMargin: 5
                anchors.verticalCenter: parent.verticalCenter
                font.pixelSize: 12
                color: scaleColor
            }
        }
    }

    Shape //Отрисовка стрелки
    {
        id: arrow
        width: 20
        height: 20
        anchors.right: parent.left
        anchors.rightMargin: 10
        y: ((maxValue - fuelLevel) / (maxValue - minValue)) * parent.height - height / 2
        rotation: 90
        transformOrigin: Item.Center

        ShapePath {
            startX: 10
            startY: 0 // Вершина стрелки
            strokeColor: arrowColor
            fillColor: arrowColor

            PathLine {
                x: 15
                y: 20
            } // Нижний правый угол
            PathLine {
                x: 5
                y: 20
            } // Нижний левый угол
            PathLine {
                x: 10
                y: 0
            } // Возвращение к вершине
        }
    }
}
