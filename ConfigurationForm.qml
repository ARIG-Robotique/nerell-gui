import QtQuick 2.12
import QtQuick.Controls 2.12
import QtQuick.Dialogs 1.2
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
        if (team === RobotModel.BLUE) {
            return "blue";
        } else if (team === RobotModel.YELLOW) {
            return "yellow";
        }

        return Material.backgroundColor;
    }

    Label {
        id: lblMessage
        y: 3
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

        StateComponent {
            id: auState
            anchors.right: parent.right
            anchors.rightMargin: 5
            anchors.left: parent.left
            anchors.leftMargin: 5
            anchors.top: parent.top
            anchors.topMargin: 5
            libelle: qsTr("Arret Urgence")
            stateColor: getBooleanColor(mainModel.au)
        }

        StateComponent {
            id: alim12vState
            anchors.right: parent.right
            anchors.rightMargin: 5
            anchors.left: parent.left
            anchors.leftMargin: 5
            anchors.top: auState.bottom
            anchors.topMargin: 5
            libelle: qsTr("Alimentation 12V")
            stateColor: getBooleanColor(mainModel.alim12v)
        }

        StateComponent {
            id: alim5vpState
            anchors.right: parent.right
            anchors.rightMargin: 5
            anchors.left: parent.left
            anchors.leftMargin: 5
            anchors.top: alim12vState.bottom
            anchors.topMargin: 5
            libelle: qsTr("Alimentation 5V Puissance")
            stateColor: getBooleanColor(mainModel.alim5vp)
        }

        StateComponent {
            id: alim5vlState
            anchors.right: parent.right
            anchors.rightMargin: 5
            anchors.left: parent.left
            anchors.leftMargin: 5
            anchors.top: alim5vpState.bottom
            anchors.topMargin: 5
            libelle: qsTr("Alimentation 5V Logique")
            stateColor: getBooleanColor(mainModel.alim5vl)
        }

        StateComponent {
            id: tiretteState
            anchors.right: parent.right
            anchors.rightMargin: 5
            anchors.left: parent.left
            anchors.leftMargin: 5
            anchors.top: alim5vlState.bottom
            anchors.topMargin: 5
            libelle: qsTr("Tirette")
            stateColor: getBooleanColor(mainModel.tirette)
        }

        StateComponent {
            id: baliseState
            anchors.right: parent.right
            anchors.rightMargin: 5
            anchors.left: parent.left
            anchors.leftMargin: 5
            anchors.top: tiretteState.bottom
            anchors.topMargin: 30
            libelle: qsTr("Balise")
            stateColor: getBooleanColor(mainModel.balise)
        }

        StateComponent {
            id: phareState
            anchors.right: parent.right
            anchors.rightMargin: 5
            anchors.left: parent.left
            anchors.leftMargin: 5
            anchors.top: baliseState.bottom
            anchors.topMargin: 5
            libelle: qsTr("Phare")
            stateColor: getBooleanColor(mainModel.phare)
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
                mainModel.team = areaSelectColor.checked ? RobotModel.BLUE : RobotModel.YELLOW;
            }
        }

        ButtonGroup {
            buttons: strategies.childrens
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
                text: qsTr("Strategy 1")
                font.pointSize: 16
                onClicked: mainModel.strategy = RobotModel.STRAT1
            }
            RadioButton {
                enabled: !mainModel.startCalibration
                text: qsTr("Strategy 2")
                font.pointSize: 16
                onClicked: mainModel.strategy = RobotModel.STRAT2
            }
            RadioButton {
                enabled: !mainModel.startCalibration
                text: qsTr("Strategy 3")
                font.pointSize: 16
                onClicked: mainModel.strategy = RobotModel.STRAT3
            }
        }

        Button {
            id: buttonCalibration
            y: 277
            text: qsTr("Lancer la calibration")
            anchors.right: parent.right
            anchors.rightMargin: 10
            anchors.left: parent.left
            anchors.leftMargin: 10
            anchors.bottom: parent.bottom
            anchors.bottomMargin: 10
            onClicked: {
                if (!mainModel.startCalibration) {
                    calibConfirmation.open()
                }
            }
        }
    }

    MessageDialog {
        id: calibConfirmation

        title: "Confirmation"
        text: "Lancement de la calibration. Pas de retour arrière possible"
        standardButtons: StandardButton.Yes | StandardButton.No
        icon: StandardIcon.Warning

        onYes: mainModel.startCalibration = true
    }

    Label {
        id: lblScore
        y: 207
        width: 180
        text: mainModel.score
        visible: false
        horizontalAlignment: Text.AlignRight
        anchors.right: parent.horizontalCenter
        anchors.rightMargin: 0
        anchors.left: parent.left
        anchors.leftMargin: 0
        font.pointSize: 50
        anchors.verticalCenter: parent.verticalCenter
    }

    Label {
        id: lblPoints
        x: -9
        y: 198
        width: 180
        text: "points"
        anchors.leftMargin: 5
        visible: false
        anchors.right: parent.right
        anchors.rightMargin: 0
        font.pointSize: 50
        anchors.left: parent.horizontalCenter
        horizontalAlignment: Text.AlignLeft
        anchors.verticalCenter: parent.verticalCenter
    }

    states: [
        State {
            name: "match"
            when: mainModel.step === RobotModel.MATCH

            PropertyChanges {
                target: frameInfos
                visible: false
            }

            PropertyChanges {
                target: frameConfig
                visible: false
            }

            PropertyChanges {
                target: lblScore
                visible: true
            }

            PropertyChanges {
                target: lblPoints
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
    D{i:1;anchors_height:332;anchors_x:35;anchors_y:34}D{i:2;anchors_width:145;anchors_x:"-9";anchors_y:3}
D{i:4;anchors_width:145;anchors_x:"-9";anchors_y:3}D{i:5;anchors_width:356;anchors_x:393;anchors_y:"-1"}
D{i:6;anchors_width:145;anchors_x:"-9";anchors_y:3}D{i:7;anchors_width:356;anchors_x:393;anchors_y:"-1"}
D{i:8;anchors_width:145;anchors_x:"-9";anchors_y:3}D{i:9;anchors_width:356;anchors_x:393;anchors_y:"-1"}
D{i:10;anchors_width:145;anchors_x:"-9";anchors_y:3}D{i:3;anchors_width:356;anchors_x:393;anchors_y:"-1"}
D{i:12;anchors_width:356;anchors_x:5;anchors_y:59}D{i:20;anchors_x:16}D{i:11;anchors_width:356;anchors_x:393;anchors_y:"-1"}
D{i:22;anchors_width:180;anchors_x:264}D{i:23;anchors_width:180;anchors_x:264}
}
##^##*/
