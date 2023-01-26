import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15
import QtQuick.Window 2.15
import Librum.models 1.0
import "PageNavigationLogic.js" as Logic

import "sidebar"
import "homePage"
import "loginPage"
import "registerPage"
import "freeBooksPage"
import "settings"
import "statisticsPage"
import "addOnsPage"
import "forgotPasswordPage"
import "readingPage"


ApplicationWindow
{
    id: baseRoot
    minimumHeight: 400
    minimumWidth: 904
    visible: true
    visibility: Window.Maximized
    title: qsTr("Librum - Your ebook reader")
    
    
    RowLayout
    {
        id: mainlayout
        anchors.fill: parent
        spacing: 0
        
        
        MSidebar
        {
            id: sidebar
            z: 1
            visible: pageManager.pageHasSidebar
        }
        
        /*
          The StackView is managing the switching of pages
          */
        StackView
        {
            id: pageManager
            property bool pageHasSidebar : false
            
            Layout.fillWidth: true
            Layout.fillHeight: true
            initialItem: loginPage
            
            popEnter: null
            popExit: null
            pushEnter: null
            pushExit: null
            replaceEnter: null
            replaceExit: null
        }
    }
    
    
    // Pages
    Component { id: loginPage; MLoginPage {} }
    Component { id: forgotPasswordPage; MForgotPasswordPage {} }
    Component { id: registerPage; MRegisterPage {} }
    Component { id: homePage; MHomePage {} }
    Component { id: freeBooksPage; MFreeBooksPage {} }
    Component { id: settings; MSettings {} }
    Component { id: addOnsPage; MAddOnsPage {} }
    Component { id: statisticsPage; MStatisticsPage {} }
    Component { id: readingPage; MReadingPage {} }
    
    
    
    /*
      loadPage() manages the page switching through out the application
      */
    function loadPage(page, sidebarItem, doSamePageCheck = true)
    {
        // Prevent switching to the same page that is currently active
        if(doSamePageCheck && Logic.checkIfNewPageIsTheSameAsOld(sidebarItem))
            return;
        
        // Terminate any pending operation on the previous page
        if(!Logic.terminateActionOfCurrentPage(page, sidebarItem))
            return;
        
        // Switch the page
        Logic.switchPage(page, sidebarItem);
    }
    
    
    
    /*
      Nested setting navigation - Navigate to a specific sub-page in one command.
      E.g. go from "Home" to "Settings / Account page"
      */
    
    function loadSettingsAccountPage()
    {
        loadPage(settings, sidebar.settingsItem, false);
        
        let page = pageManager.currentItem;
        page.loadSettingsPage(page.accountPage, page.settingsSidebar.accountItem);
    }
    
    function loadSettingsAppearancePage()
    {
        loadPage(settings, sidebar.settingsItem, false);
        
        let page = pageManager.currentItem;
        page.loadSettingsPage(page.appearancePage, page.settingsSidebar.appearanceItem);
    }
}