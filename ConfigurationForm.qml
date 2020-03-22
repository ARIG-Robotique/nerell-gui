import QtQuick 2.12
import QtQuick.Controls 2.12
import QtQuick.Controls.Material 2.12
import org.arig.robotmodel 1.0

Page {
    id: page
    width: 800
    height: 430

    title: qsTr("Configuration Nerell")

    RobotModel {
        id: mainModel
    }

    function getBooleanColor(value) {
        return value ? "green" : "red";
    }

    function getTeamColor(team) {
        if (team === RobotModel.BLEU) {
            return "blue";
        } else if (team === RobotModel.JAUNE) {
            return "yellow";
        }

        return Material.backgroundColor;
    }

    Popup {
        id: calibConfirmation
        modal: true
        focus: true
        width: 350
        height: 150
        closePolicy: Popup.CloseOnEscape | Popup.CloseOnPressOutsideParent

        enter: Transition {
            NumberAnimation {
                property: "opacity"
                from: 0.0
                to: 1.0
            }
        }
        exit: Transition {
            NumberAnimation {
                property: "opacity"
                from: 1.0
                to: 0.0
            }
        }

        anchors.centerIn: Overlay.overlay

        contentItem:  Column {
            padding: 5
            spacing: 10

            Label {
                text: "Lancement de la calibration ?"
                font.pointSize: 16
            }

            Label {
                text: "Pas de retour arrière possible"
                font.pointSize: 10
            }

            Row {
                padding: 5
                spacing: 10
                anchors.right: parent.right
                anchors.rightMargin: 5

                Button {
                    text: "Non"
                    onClicked: {
                        calibConfirmation.close();
                    }
                }

                Button {
                    text: "Oui"
                    onClicked: {
                        mainModel.startCalibration = true
                        calibConfirmation.close();
                    }
                }
            }
        }
    }

    Label {
        id: lblMessage
        height: 35
        text: mainModel.message
        horizontalAlignment: Text.AlignHCenter
        verticalAlignment: Text.AlignVCenter
        anchors.right: parent.right
        anchors.rightMargin: 5
        anchors.left: parent.left
        anchors.leftMargin: 5
        anchors.top: parent.top
        anchors.topMargin: 5
        font.pointSize: 16
    }

    Frame {
        id: frameInfos
        width: 395
        anchors.left: parent.left
        anchors.leftMargin: 5
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 5
        anchors.top: lblMessage.bottom
        anchors.topMargin: 10

        Row {
            id: rowStates
            height: 180
            spacing: 5
            anchors.right: parent.right
            anchors.rightMargin: 0
            anchors.left: parent.left
            anchors.leftMargin: 0
            anchors.top: parent.top
            anchors.topMargin: 0

            Column {
                width: 185
                spacing: 10

                StateComponent {
                    id: i2cState
                    anchors.right: parent.right
                    anchors.rightMargin: 5
                    anchors.left: parent.left
                    anchors.leftMargin: 5
                    libelle: qsTr("Bus i2c")
                    stateColor: getBooleanColor(mainModel.i2c)
                }

                StateComponent {
                    id: lidarState
                    anchors.right: parent.right
                    anchors.rightMargin: 5
                    anchors.left: parent.left
                    anchors.leftMargin: 5
                    libelle: qsTr("Lidar")
                    stateColor: getBooleanColor(mainModel.lidar)
                }

                StateComponent {
                    id: baliseState
                    anchors.right: parent.right
                    anchors.rightMargin: 5
                    anchors.left: parent.left
                    anchors.leftMargin: 5
                    libelle: qsTr("Balise")
                    stateColor: getBooleanColor(mainModel.balise)
                }

                StateComponent {
                    id: phareState
                    anchors.right: parent.right
                    anchors.rightMargin: 5
                    anchors.left: parent.left
                    anchors.leftMargin: 5
                    libelle: qsTr("Phare")
                    stateColor: getBooleanColor(mainModel.phare)
                }

            }

            Column {
                width: 185
                spacing: 10

                StateComponent {
                    id: auState
                    anchors.right: parent.right
                    anchors.rightMargin: 5
                    anchors.left: parent.left
                    anchors.leftMargin: 5
                    libelle: qsTr("Arret Urgence")
                    stateColor: getBooleanColor(mainModel.au)
                }

                StateComponent {
                    id: alim12vState
                    anchors.right: parent.right
                    anchors.rightMargin: 5
                    anchors.left: parent.left
                    anchors.leftMargin: 5
                    libelle: qsTr("Alim. 12V")
                    stateColor: getBooleanColor(mainModel.alim12v)
                }

                StateComponent {
                    id: alim5vpState
                    anchors.right: parent.right
                    anchors.rightMargin: 5
                    anchors.left: parent.left
                    anchors.leftMargin: 5
                    libelle: qsTr("Alim. 5V")
                    stateColor: getBooleanColor(mainModel.alim5vp)
                }

                StateComponent {
                    id: tiretteState
                    anchors.right: parent.right
                    anchors.rightMargin: 5
                    anchors.left: parent.left
                    anchors.leftMargin: 5
                    libelle: qsTr("Tirette")
                    stateColor: getBooleanColor(mainModel.tirette)
                }
            }
        }

        Row {
            id: rowConfig
            spacing: 5
            anchors.right: parent.right
            anchors.rightMargin: 0
            anchors.left: parent.left
            anchors.leftMargin: 0
            anchors.top: rowStates.bottom
            anchors.topMargin: 0
            anchors.bottom: parent.top
            anchors.bottomMargin: 0

            Column {
                width: 185
                spacing: 10

                Switch {
                    id: config1
                    text: qsTr("Config 1")
                }

                Switch {
                    id: config2
                    text: qsTr("Config 2")
                }

                Switch {
                    id: config3
                    text: qsTr("Config 3")
                }
            }

            Column {
                width: 185
                spacing: 10

                Switch {
                    id: config4
                    text: qsTr("Config 4")
                }

                Switch {
                    id: config5
                    text: qsTr("Config 5")
                }

                Switch {
                    id: config6
                    text: qsTr("Config 6")
                }
            }
        }
    }

    Frame {
        id: frameConfig
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 5
        anchors.top: lblMessage.bottom
        anchors.topMargin: 10
        anchors.right: parent.right
        anchors.rightMargin: 5
        anchors.left: frameInfos.right
        anchors.leftMargin: 5

        Label {
            id: lblTeam
            width: 59
            height: 24
            text: qsTr("Team")
            anchors.top: parent.top
            anchors.topMargin: 15
            font.pointSize: 16
            anchors.left: parent.left
            anchors.leftMargin: 5
        }

        Rectangle {
            id: rectColorTeam
            height: 42
            color: getTeamColor(mainModel.team)
            visible: mainModel.team != RobotModel.UNKNOWN
            anchors.top: parent.top
            anchors.topMargin: 5
            anchors.left: lblTeam.right
            anchors.leftMargin: 5
            anchors.right: parent.right
            anchors.rightMargin: 5
        }

        MouseArea {
            property bool checked: true

            enabled: !mainModel.startCalibration

            id: areaSelectColor
            height: rectColorTeam.height
            anchors.left: parent.left
            anchors.leftMargin: 5
            anchors.right: parent.right
            anchors.rightMargin: 5
            anchors.top: parent.top
            anchors.topMargin: 5

            onClicked: {
                areaSelectColor.checked = !areaSelectColor.checked;
                mainModel.team = areaSelectColor.checked ? RobotModel.BLEU : RobotModel.JAUNE;
            }
        }

        Column {
            id: strategies
            anchors.top: rectColorTeam.bottom
            anchors.topMargin: 30
            anchors.right: parent.right
            anchors.rightMargin: 0
            anchors.left: parent.left
            anchors.leftMargin: 0

            RadioButton {
                checked: true
                enabled: !mainModel.startCalibration
                text: qsTr("Basic")
                font.pointSize: 16
                onClicked: mainModel.strategy = RobotModel.STRAT1
            }
            RadioButton {
                enabled: !mainModel.startCalibration
                text: qsTr("Aggressive")
                font.pointSize: 16
                onClicked: mainModel.strategy = RobotModel.STRAT2
            }
            RadioButton {
                enabled: !mainModel.startCalibration
                text: qsTr("Finale")
                font.pointSize: 16
                onClicked: mainModel.strategy = RobotModel.STRAT3
            }
        }

        Button {
            id: buttonCalibration
            y: 277
            enabled: mainModel.au && mainModel.team != RobotModel.UNKNOWN && !mainModel.startCalibration
            text: qsTr("Lancer la calibration")
            anchors.right: parent.right
            anchors.rightMargin: 10
            anchors.left: parent.left
            anchors.leftMargin: 10
            anchors.bottom: parent.bottom
            anchors.bottomMargin: 10
            onClicked: {
                if (!mainModel.startCalibration) {
                    console.log("Start calibration")
                    calibConfirmation.open()
                }
            }
        }

        ButtonGroup {
            buttons: strategies.childrens
        }
    }

    Frame {
        id: matchInfos
        visible: false
        anchors.right: parent.right
        anchors.rightMargin: 0
        anchors.left: parent.left
        anchors.leftMargin: 0
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 0
        anchors.top: parent.top
        anchors.topMargin: 0

        Label {
            y: 85
            text: mainModel.score
            verticalAlignment: Text.AlignVCenter
            anchors.left: parent.left
            anchors.leftMargin: 0
            anchors.right: parent.right
            anchors.rightMargin: 0
            horizontalAlignment: Text.AlignHCenter
            font.pointSize: 150
            anchors.verticalCenter: parent.verticalCenter
        }

    }

    states: [
        State {
            name: "match"
            when: (mainModel.inMatch)

            PropertyChanges {
                target: frameInfos
                visible: false
            }

            PropertyChanges {
                target: frameConfig
                visible: false
            }

            PropertyChanges {
                target: matchInfos
                visible: true
            }

            PropertyChanges {
                target: page
                title: qsTr("Match")
            }
        }
    ]
}




/*##^##
Designer {
    D{i:1;anchors_height:332;anchors_x:35;anchors_y:34}D{i:6;anchors_width:145;anchors_x:"-9";anchors_y:3}
D{i:5;anchors_width:356;anchors_x:393;anchors_y:"-1"}D{i:8;anchors_width:145;anchors_x:"-9";anchors_y:3}
D{i:9;anchors_width:356;anchors_x:393;anchors_y:"-1"}D{i:11;anchors_width:356;anchors_x:393;anchors_y:"-1"}
D{i:12;anchors_width:356;anchors_x:5;anchors_y:59}D{i:10;anchors_width:145;anchors_x:"-9";anchors_y:3}
D{i:7;anchors_width:356;anchors_x:393;anchors_y:"-1"}D{i:4;anchors_width:145;anchors_x:"-9";anchors_y:3}
D{i:3;anchors_width:356;anchors_x:393;anchors_y:"-1"}D{i:2;anchors_width:145;anchors_x:"-9";anchors_y:3}
D{i:20;anchors_x:16}D{i:22;anchors_width:180;anchors_x:264}D{i:23;anchors_width:180;anchors_x:264}
D{i:29;anchors_width:200;anchors_x:0}D{i:31;anchors_width:200;anchors_x:0}
}
##^##*/
