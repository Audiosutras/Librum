import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

FocusScope
{
    id: root
    implicitWidth: 38
    implicitHeight: 36
    
    property int defaultWidth : 0
    property int expensionWidth : 445
    property int openAnimationDuration : 300
    property int closeAnimationDuration : 200
    property bool opened : false
    
    signal triggered(string query)
    
    Rectangle
    {
        id: searchBar
        width: root.width
        height: root.height
        color: properties.colorBackground
        border.width: 1
        border.color: properties.colorLightBorder
        radius: 5
        
        RowLayout
        {
            id: layout
            anchors.fill: parent
            
            TextField
            {
                id: inputField
                visible: false
                z: 1
                Layout.fillWidth: true
                Layout.fillHeight: true
                Layout.alignment: Qt.AlignVCenter
                leftPadding: 12
                color: properties.colorBaseText
                font.pointSize: 12
                placeholderText: "What should I search for you?"
                placeholderTextColor: properties.colorLightText2
                
                onVisibleChanged: if(visible == true) forceActiveFocus();
                
                background: Rectangle
                {
                    anchors.fill: parent
                    radius: 4
                    color: "transparent"
                }
                
                Keys.onPressed: (event) => 
                {
                    if(event.key === Qt.Key_Return)
                        triggered(inputField.text);
                }
            }
            
            Item
            {
                id: searchBarDefaultBox
                Layout.preferredHeight: parent.height
                Layout.preferredWidth: root.defaultWidth
                Layout.alignment: Qt.AlignVCenter | Qt.AlignRight
                
                Image
                {
                    id: searchBarIcon
                    anchors.centerIn: parent
                    sourceSize.height: 16
                    source: "/resources/images/search-icon.svg"
                    fillMode: Image.PreserveAspectFit
                    antialiasing: false
                }
                
                MouseArea
                {
                    anchors.fill: parent
                    
                    onClicked:
                    {
                        if(root.opened)
                            closeAnimation.start();
                        else
                            openAnimation.start();
                    }
                }
            }
        }
    }
    
    
    ParallelAnimation
    {
        id: openAnimation
        
        PropertyAnimation
        {
            target: root
            property: "implicitWidth"
            to: root.expensionWidth
            duration: root.openAnimationDuration
            easing.type: Easing.InOutQuad
        }
        
        PropertyAnimation
        {
            target: inputField
            property: "visible"
            to: true
            duration: root.openAnimationDuration - 50
            easing.type: Easing.InOutQuad
        }
        
        PropertyAnimation
        {
            target: inputField
            property: "opacity"
            to: 1
            duration: 0
        }
        
        onFinished:
        {
            root.opened = true;
        }
    }
    
    
    ParallelAnimation
    {
        id: closeAnimation
        
        PropertyAnimation
        {
            target: root
            property: "implicitWidth"
            to: root.defaultWidth
            duration: root.closeAnimationDuration
            easing.type: Easing.InOutQuad
        }
        
        PropertyAnimation
        {
            target: inputField
            property: "opacity"
            to: 0
            duration: root.closeAnimationDuration / 3
            easing.type: Easing.InOutQuad
        }
        
        PropertyAnimation
        {
            target: inputField
            property: "visible"
            to: false
            duration: root.closeAnimationDuration / 2
            easing.type: Easing.InOutQuad
        }
        
        onFinished:
        {
            root.opened = false;
            inputField.clear();
        }
    }
    
    
    Component.onCompleted: 
    {
        root.defaultWidth = width;
    }
}