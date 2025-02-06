import QtQuick 2.15
import QtQuick.Controls 2.15

ApplicationWindow {
    visible: true
    width: 900
    height: 900
    title: "Fuel Gauge"

    Column {
        spacing: 10
        anchors.centerIn: parent

        // Компонент шкалы расхода топлива
        FuelGauge {
            id: fuelGauge
            width: 100
            height: 300
            scaleColor: scaleColorField.text
            tickColor: tickColorField.text
            arrowColor: arrowColorField.text
            fuelLevel: fuelLevelSlider.value
            maxValue: parseInt(maxValueField.text)
            minValue: parseInt(minValueField.text)
        }

        // Настройка цвета шкалы
        Row {
            spacing: 10
            Label {
                text: "Scale Color (HEX):"
            }
            TextField {
                id: scaleColorField
                text: "#000000"
            }
        }

        // Настройка цвета рисок
        Row {
            spacing: 10
            Label {
                text: "Tick Color (HEX):"
            }
            TextField {
                id: tickColorField
                text: "#808080"
            }
        }

        // Настройка цвета стрелки
        Row {
            spacing: 10
            Label {
                text: "Arrow Color (HEX):"
            }
            TextField {
                id: arrowColorField
                text: "#FF0000"
            }
        }

        // Настройка текущего уровня топлива
        Row {
            spacing: 10
            Label {
                text: "Fuel Level:"
            }
            Slider {
                id: fuelLevelSlider
                from: fuelGauge.minValue
                to: fuelGauge.maxValue
                value: 50
            }
            Label {
                text: fuelLevelSlider.value.toFixed(1)
            }
        }

        // Максимальное значение шкалы
        Row {
            spacing: 10
            Label {
                text: "Max Value:"
            }
            TextField {
                id: maxValueField
                text: "100"
                validator: IntValidator {
                    bottom: parseInt(minValueField.text) + 1
                }
                onTextChanged: {
                    if (parseInt(maxValueField.text) <= parseInt(
                                minValueField.text)) {
                        maxValueField.text = (parseInt(
                                                  minValueField.text) + 1).toString()
                    }
                    fuelLevelSlider.to = parseInt(maxValueField.text)
                }
            }
        }

        // Минимальное значение шкалы
        Row {
            spacing: 10
            Label {
                text: "Min Value:"
            }
            TextField {
                id: minValueField
                text: "0"
                validator: IntValidator {
                    bottom: 0
                    top: parseInt(maxValueField.text) - 1
                }
                onTextChanged: {
                    if (parseInt(minValueField.text) >= parseInt(
                                maxValueField.text)) {
                        minValueField.text = (parseInt(
                                                  maxValueField.text) - 1).toString()
                    }
                    fuelLevelSlider.from = parseInt(minValueField.text)
                }
            }
        }
    }
}
