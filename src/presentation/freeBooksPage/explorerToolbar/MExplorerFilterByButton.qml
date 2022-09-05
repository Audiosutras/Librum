import QtQuick 2.15
import QtQuick.Layouts 1.15
import QtQuick.Controls 2.15
import Librum.style 1.0
import Librum.icons 1.0


Item
{
    id: root
    property bool opened : false
    signal clicked()
    
    implicitWidth: 100
    implicitHeight: 36
    
    
    Pane
    {
        id: container
        anchors.fill: parent
        padding: 0
        background: Rectangle
        {
            color: Style.colorBackground
            border.width: 1
            border.color: Style.colorLightBorder
            radius: 5
        }
        
        
        RowLayout
        {
            anchors.centerIn: parent
            spacing: 5
            
            Image
            {
                id: filterByArrowIcon
                sourceSize.height: 14
                source: Icons.filter
                fillMode: Image.PreserveAspectFit
            }
            
            Label
            {
                id: filterByLabel
                Layout.topMargin: -1
                color: Style.colorBaseText
                text: "Filters"
                font.pointSize: 12
                font.family: Style.defaultFontFamily
                font.weight: Font.Bold
            }
        }
    }
    
    MouseArea
    {
        anchors.fill: parent
        
        onClicked: root.clicked()
    }
    
    
    function giveFocus()
    {
        root.forceActiveFocus();
    }    
}
