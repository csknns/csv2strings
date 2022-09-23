//
//  Libcsv2stringsTests.swift
//  
//
//  Created by Christos Koninis on 9/22/22.
//

import Foundation
import XCTest
import CSVImporter
@testable import libcsv2strings

final class Libcsv2stringsTests: XCTestCase {

    private class FileWriterSpy: FileWriter {
        var data: String?
        var path: URL?

        init() {}

        func saveData(_ stringsFileData: String, toFile path: URL) {
            data = stringsFileData
            self.path = path
        }
    }

    private class CSVReaderMock: CSVReader {
        let recordsForPath: [String: [[String]]]

        init(path: String = "", records: [[String]] = [[]]) {
            recordsForPath = [path: records]
        }

        func readCSVAtPath(path: String) -> [[String]] {
            recordsForPath[path] ?? [[]]
        }
    }

    private class FileReaderMock: FileReader {
        var textForFile: [String: String]

        init(mockedText: String = "", forFileAt path: String = "") {
            textForFile = [path: mockedText]
        }

        func readTextFromFile(path: String) throws -> String {
            guard let text = textForFile[path] else {
                throw NSError()
            }

            return text
        }
    }

    func test_CSVFileIsCovertedToStringsFile() {
        // Given
        let csvFilePath = "path/to/file.csv"
        let records = CSVImporter(contentString: Resources.CSVFile).importRecords(mapper: { $0 })
        let aCSVReaderMock = CSVReaderMock(path: csvFilePath, records: records)
        let fileWriterSpy = FileWriterSpy()

        // When
        let convertor = StringsConvertor(CSVReader: aCSVReaderMock,
                                         fileWriter: fileWriterSpy,
                                         fileReader: FileReaderMock())
        convertor.toStringsFile(csvFilePath)

        // Then
        XCTAssertEqual(fileWriterSpy.data, Resources.stringsFile)
    }

    func test_StringFileIsCovertedToCSVFile() {
        // Given
        let stringsFilePath = "path/to/file.strings"
        let fileWriterSpy = FileWriterSpy()
        let fileReaderMock = FileReaderMock(mockedText: Resources.stringsFile, forFileAt: stringsFilePath)

        // When
        let convertor = StringsConvertor(CSVReader: CSVReaderMock(),
                                         fileWriter: fileWriterSpy,
                                         fileReader: fileReaderMock)
        convertor.toCSVFile(stringsFilePath)

        // Then
        XCTAssertEqual(fileWriterSpy.data, Resources.CSVFile)
    }
}


fileprivate enum Resources {
    static let stringsFile =
    """
/* Button for smaller reader font size. Keep this extremely short! This is shown in the reader mode toolbar. */
"-" = "-";

/* Button for larger reader font size. Keep this extremely short! This is shown in the reader mode toolbar. */
"+" = "+";

/* Authentication prompt message with no realm. Parameter is the hostname of the site */
"A username and password are being requested by %@." = "%@ यूजरनाम आरू पासवर्ड मांगी रहलो छै";

/* Authentication prompt message with a realm. First parameter is the hostname. Second is the realm string */
"A username and password are being requested by %@. The site says: %@" = "%1$@ द्वारा एगो उपयोगकर्ता नाम आरू पासवर्ड रो अनुरोध करी रहलो छै। साइट कहै छै: %2$@";

/* Button for reader mode font size. Keep this extremely short! This is shown in the reader mode toolbar. */
"Aa" = "Aa";

/* About settings section title */
"About" = "रो संबंध में";

/* A string used to signify the start of the Recently Saved section in Home Screen. */
"ActivityStream.Library.Title" = "हाल में सहेजल गेल";

/* Section title label for recently visited websites */
"ActivityStream.RecentHistory.Title" = "हाल में देखलोॅ गेल";

/* The title for the setting page which lets you select the number of top site rows */
"ActivityStream.TopSites.RowSettingFooter" = "पंक्तियां सेट करोॅ";

/* Accessibility label for the Add Tab button in the Tab Tray. */
"Add Tab" = "टैब जोरोॅ";

/* Name for button adding current article to reading list in reader mode */
"Add to Reading List" = "पठन सूची में जोड़ोॅ";

/* Accessibility message e.g. spoken by VoiceOver after the current page gets added to the Reading List using the Reader View button, e.g. by long-pressing it or by its accessibility custom action. */
"Added page to Reading List" = "पठन सूची रो पेज जोड़लोॅ गेल";

/* Button to dismiss the 'Add Pass Failed' alert.  See https://support.apple.com/HT204003 for context on Wallet. */
"AddPass.Error.Dismiss" = "ठीक";

/* Text of the 'Add Pass Failed' alert.  See https://support.apple.com/HT204003 for context on Wallet. */
"AddPass.Error.Message" = "पास रो वॉलेट में जोड़ै समय गलती भेल. कृपया बादो मेॅ फेनू कोशिश करोॅ.";

/* Title of the 'Add Pass Failed' alert. See https://support.apple.com/HT204003 for context on Wallet. */
"AddPass.Error.Title" = "पास करे मेॅ विफल";

/* Accessibility label for address and search field, both words (Address, Search) are therefore nouns. */
"Address and Search" = "पता आरू खोज";

/* Used as a button label for crash dialog prompt */
"Always Send" = "हमेशा भेजोॅ";

/* Tile title for Amazon */
"Amazon" = "Amazon";

/* Authentication prompt title */
"Authentication required" = "प्रमाणीकरण जरुरी छै";

/* Accessibility label for the Back button in the tab toolbar. */
"Back" = "पिछू";

/* Block pop-up windows setting */
"Block Pop-up Windows" = "पॉपअप विंडो रो अवरोध करोॅ";

/* The label for the Title field when editing a bookmark */
"Bookmark.DetailFieldTitle.Label" = "शीर्षक";

/* The label for the URL field when editing a bookmark */
"Bookmark.DetailFieldURL.Label" = "URL";

/* Toggle bookmarks syncing setting */
"Bookmarks" = "बुकमार्कस";

/* The button on the snackbar to edit a bookmark after adding it. */
"Bookmarks.Edit.Button" = "संपादित करोॅ";

/* The button to edit a bookmark */
"Bookmarks.EditBookmark.Label" = "बुकमार्क संपादित करोॅ";

/* The button to edit a folder */
"Bookmarks.EditFolder.Label" = "फोल्डर संपादित करोॅ";

/* The label to show the location of the folder where the bookmark is located */
"Bookmarks.Folder.Label" = "फोल्डर";

/* A label indicating all bookmarks grouped under the category 'Desktop Bookmarks'. */
"Bookmarks.Menu.DesktopBookmarks" = "डेस्कटॉप बुकमार्कस";

/* The button to create a new bookmark */
"Bookmarks.NewBookmark.Label" = "नया बुकमार्क";

/* The button to create a new folder */
"Bookmarks.NewFolder.Label" = "नया फोल्डर";

/* The button to create a new separator */
"Bookmarks.NewSeparator.Label" = "नया विभाजक";

/* The label for the title of a bookmark */
"Bookmarks.Title.Label" = "शीर्षक";

/* Describes the date on which the breach occurred */
"BreachAlerts.BreachDate" = "ई उल्लंघन भेल";

/* Description of what a breach is */
"BreachAlerts.Description" = "जब तोय अंतिम बार पासवर्ड बदललो रहे ते पासवर्ड लीक या चोरी भे गेल रहै| खाता के सुरक्षा खातिर साईट मे लॉग इन करोॅ आरू पासवर्ड बदलोॅ |";

/* Link to monitor.firefox.com to learn more about breached passwords */
"BreachAlerts.LearnMoreButton" = "बेसी जानकारी";

/* Leads to a link to the breached website */
"BreachAlerts.Link" = "खातिर जाहो";

/* Title for the Breached Login Detail View. */
"BreachAlerts.Title" = "वेबसाइट भंग भेल";

/* Accessibility label for brightness adjustment slider in Reader Mode display settings */
"Brightness" = "चमक";

/* Label for Cancel button */
"Cancel" = "रद्द करोॅ";

/* Accessibility hint for the color theme setting buttons in reader mode display settings */
"Changes color theme." = "रंग थीम बदलोॅ";

/* Accessibility hint for the font type buttons in reader mode display settings */
"Changes font type." = "फ्रंट प्रकार बदलोॅ";

/* The button to open a new tab with the copied link */
"ClipboardToast.GoToCopiedLink.Button" = "जाइयै";

/* Message displayed when the user has a copied link on the clipboard */
"ClipboardToast.GoToCopiedLink.Title" = "कॉपी करलोॅ लिंक पर जाए ले चाहे छिकै?";

/* Accessibility label for action denoting closing a tab in tab list (tray) */
"Close" = "बंद करोॅ";

/* Accessibility label (used by assistive technology) notifying the user that the tab is being closed. */
"Closing tab" = "टैब बंद करि रहलोॅ छै";

/* Context menu item for bookmarking a link URL */
"ContextMenu.BookmarkLinkButtonTitle" = "बुकमार्कस लिंक";

/* The label text in the Button Toast for switching to a fresh New Private Tab. */
"ContextMenu.ButtonToast.NewPrivateTabOpened.LabelText" = "नया गोपनीय टेब खुलल";

/* The button text in the Button Toast for switching to a fresh New Tab. */
"ContextMenu.ButtonToast.NewTabOpened.ButtonText" = "बदलोॅ";

/* The label text in the Button Toast for switching to a fresh New Tab. */
"ContextMenu.ButtonToast.NewTabOpened.LabelText" = "नया टैब खुलल";

/* Context menu item for copying an image to the clipboard */
"ContextMenu.CopyImageButtonTitle" = "इमेज कॉपी करोॅ";

/* Context menu item for copying an image URL to the clipboard */
"ContextMenu.CopyImageLinkButtonTitle" = "इमेज रो लिंक कॉपी करोॅ";

/* Context menu item for copying a link URL to the clipboard */
"ContextMenu.CopyLinkButtonTitle" = "लिंक कॉपी करोॅ";

/* Context menu item for downloading a link URL */
"ContextMenu.DownloadLinkButtonTitle" = "लिंक डाउनलोड करोॅ";

/* Context menu item for opening a link in a new tab */
"ContextMenu.OpenInNewTabButtonTitle" = "नया टैब में खोलोॅ";

/* Context menu item for saving an image */
"ContextMenu.SaveImageButtonTitle" = "चित्र सहेजोॅ";

/* Context menu item for sharing a link URL */
"ContextMenu.ShareLinkButtonTitle" = "लिंक शेयर करोॅ";

/* Accessibility message e.g. spoken by VoiceOver after adding current webpage to the Reading List failed. */
"Could not add page to Reading list" = "पठन सूची रो पेज नै जोड़लोॅ गेल";

/* Accessibility message e.g. spoken by VoiceOver after the user wanted to add current page to the Reading List and this was not done, likely because it already was in the Reading List, but perhaps also because of real failures. */
"Could not add page to Reading List. Maybe it’s already there?" = "पठन सूची मेॅ पेज नै जुड़ सकलै। शायद इ पहलोॅ से जुड़ल छै ?";

/* Error message that is shown in settings when there was a problem loading */
"Could not load page." = "पेज नै लोड होए सकलोॅ";

/* Text for the new ETP settings button */
"CoverSheet.v24.ETP.Settings.Button" = "सेटिंग्स में जाहोॅ";

/* Title for the new ETP mode i.e. standard vs strict */
"CoverSheet.v24.ETP.Title" = "विज्ञापन ट्रैकिंग रो विरुद्ध संरक्षण";

/* See http://mzl.la/1Qtkf0j */
"Create an account" = "नया खाता बनाबोॅ";

/* Dark theme setting in Reading View settings */
"Dark" = "गहरा";

/* Accessibility label for button decreasing font size in display settings of reader mode */
"Decrease text size" = "शब्द रो आकार घटाबो";

/* Title for default search engine picker. */
"Default Search Engine" = "डिफॉल्ट सर्च इंजन";

/* Accessibility label for action denoting closing default browser home tab banner. */
"DefaultBrowserCloseButtonAccessibility.v102" = "बंद करियै";

/* Name for display settings button in reader mode. Display in the meaning of presentation, not monitor. */
"Display Settings" = "डिसप्ले सेटिंग्स";

/* Used as a button label for crash dialog prompt */
"Don’t Send" = "नै भेजोॅ";

/* Done button on left side of the Settings view controller title bar */
"Done" = "पूर्ण भेल";

/* Panel accessibility label */
"Downloads" = "डाउनलोडस";

/* The label of the button the user will press to start downloading a file */
"Downloads.Alert.DownloadNow" = "अभि डाउनलोड करोॅ";

/* Button confirming the cancellation of the download. */
"Downloads.CancelDialog.Cancel" = "रद्द करोॅ";

/* Alert dialog body when the user taps the cancel download icon. */
"Downloads.CancelDialog.Message" = "की तोय सच में डाउनलोड रद करै ले चाहे छौ ?";

/* Button declining the cancellation of the download. */
"Downloads.CancelDialog.Resume" = "फेनु से शुरू करोॅ";

/* Alert dialog title when the user taps the cancel download icon. */
"Downloads.CancelDialog.Title" = "डाउनलोड रद्द करोॅ";

/* The label text in the Download Cancelled toast for showing confirmation that the download was cancelled. */
"Downloads.Toast.Cancelled.LabelText" = "डाउनलोड रद्द होय गेल छै";

/* The label text in the Download Failed toast for showing confirmation that the download has failed. */
"Downloads.Toast.Failed.LabelText" = "डाउनलोड असफल";

/* The button to open a new tab with the Downloads home panel */
"Downloads.Toast.GoToDownloads.Button" = "डाउनलोडस";

/* The description text in the Download progress toast for showing the number of files when multiple files are downloading. */
"Downloads.Toast.MultipleFiles.DescriptionText" = "1 का %d फाइल्स";

/* The description text in the Download progress toast for showing the number of files (1$) and download progress (2$). This string only consists of two placeholders for purposes of displaying two other strings side-by-side where 1$ is Downloads.Toast.MultipleFiles.DescriptionText and 2$ is Downloads.Toast.Progress.DescriptionText. This string should only consist of the two placeholders side-by-side separated by a single space and 1$ should come before 2$ everywhere except for right-to-left locales. */
"Downloads.Toast.MultipleFilesAndProgress.DescriptionText" = "%1$@ %2$@";

/* The description text in the Download progress toast for showing the downloaded file size (1$) out of the total expected file size (2$). */
"Downloads.Toast.Progress.DescriptionText" = "%1$@/%2$@";

/* Action button for deleting downloaded files in the Downloads panel. */
"DownloadsPanel.Delete.Title" = "हटाबोॅ";

/* Title for the Downloads Panel empty state. */
"DownloadsPanel.EmptyState.Title" = "डाउनलोड करलोॅ फाइलें यहां दिखी जैतै";

/* Action button for sharing downloaded files in the Downloads panel. */
"DownloadsPanel.Share.Title" = "शेयर करोॅ";

/* Text message in the settings table view */
"Enter your password to connect" = "जुरै लेॅ पासवर्ड दहो";

/* Label for button to perform advanced actions on the error page */
"ErrorPages.Advanced.Button" = "विकसित करलोॅ गेल";

/* Warning text when clicking the Advanced button on error pages */
"ErrorPages.AdvancedWarning1.Text" = "चेतावनी: हम पक्का नै कैर सकै छियै की इ वेबसाइट सुरक्षित छै ।";

/* Title on the certificate error page */
"ErrorPages.CertWarning.Title" = "इ कनेक्शन विश्वासयोग्य नै छै";

/* Label for button to go back from the error page */
"ErrorPages.GoBack.Button" = "पिछू जाइयै";

/* Button label to temporarily continue to the site from the certificate error page */
"ErrorPages.VisitOnce.Button" = "फिर भी साइट देखोॅ";

/* Question shown to user when tapping a link that opens the App Store app */
"ExternalLink.AppStore.ConfirmationTitle" = "इस लिंक रो App Store में खोलोॅ?";

/* Question shown to user when tapping an SMS or MailTo link that opens the external app for those. */
"ExternalLink.AppStore.GenericConfirmationTitle" = "इस लिंक रो बाहरी एप्प में खोलोॅ?";

/* Tile title for Facebook */
"Facebook" = "Facebook";

/* Title for firefox about:home page in tab history list */
"Firefox.HomePage.Title" = "Firefox होम पेज";

/* When a user taps and holds on an item from the Recently Visited section, this label will appear indicating the option to remove that item. */
"FirefoxHome.RecentHistory.Remove" = "हटैइयै";

/* The title for the Settings context menu action for sponsored tiles in the Firefox home page shortcuts section. Clicking this brings the users to the Shortcuts Settings. */
"FirefoxHomepage.ContextualMenu.Settings.v101" = "सेटिंग्स";

/* Accessibility Label for the tab toolbar Forward button */
"Forward" = "आगू बढ़ावोॅ";

/* Settings section title for Firefox Account */
"FxA.FirefoxAccount" = "Firefox खाता";

/* Button label to go to Firefox Account settings */
"FxA.ManageAccount" = "खाता आरू उपकरण प्रबंधित करोॅ";

/* Label when no internet is present */
"FxA.NoInternetConnection" = "इंटरनेट कनेक्शन नै छै";

/* Button label to Sync your Firefox Account */
"FxA.SyncNow" = "अब सिंक करोॅ";

/* Title of a notification displayed when another device has connected to FxA. %@ refers to the name of the newly connected device. */
"FxAPush_DeviceConnected_body" = "Firefox सिंक %@ में जोड़ देल गेलै.";

/* Title of a notification displayed when another device has connected to FxA. */
"FxAPush_DeviceConnected_title" = "सिंक जुड़ गेल";

/* Body of a notification displayed when named device has been disconnected from FxA. %@ refers to the name of the disconnected device. */
"FxAPush_DeviceDisconnected_body" = "%@ सफलतापूर्ण डिसकनेक्ट करलो गेल।";

/* Body of a notification displayed when this device has been disconnected from FxA by another device. */
"FxAPush_DeviceDisconnected_ThisDevice_body" = "कंप्यूटर रो Firefox सिंक सेॅ पूरी तरह से डिसकनेक्ट भे गेल";

/* Title of a notification displayed when this device has been disconnected by another device. */
"FxAPush_DeviceDisconnected_ThisDevice_title" = "सिंक डिसकनेक्ट भेल";

/* Title of a notification displayed when named device has been disconnected from FxA. */
"FxAPush_DeviceDisconnected_title" = "सिंक डिसकनेक्ट भेल";

/* Body of a notification displayed when unnamed device has been disconnected from FxA. */
"FxAPush_DeviceDisconnected_UnknownDevice_body" = "ई उपकरण Firefox सिंक सेॅ डिसकनेक्ट होय गेल छै";

/* Show the SUMO support page from the Support section in the settings. see http://mzl.la/1dmM8tZ */
"Help" = "मदद";

/* Toggle history syncing setting */
"History" = "इतिहास";

/* Title for button in the history panel to clear recent history */
"HistoryPanel.ClearHistoryButtonTitle" = "हाल रो इतिहास मिटाबो…";

/* Option title to clear all browsing history. */
"HistoryPanel.ClearHistoryMenuOptionEverything" = "सबचीज";

/* Button to perform action to clear history for the last hour */
"HistoryPanel.ClearHistoryMenuOptionTheLastHour" = "अंतिम घंटा";

/* Button to perform action to clear history for today only */
"HistoryPanel.ClearHistoryMenuOptionToday" = "आय";

/* Button to perform action to clear history for yesterday and today */
"HistoryPanel.ClearHistoryMenuOptionTodayAndYesterday" = "आय आरू कल";

/* Title for the History Panel empty state. */
"HistoryPanel.EmptyState.Title" = "आपनो हाल के देखल वेबसाइट उपर दिख रहलो छै";

/* Description for the empty synced tabs 'not signed in' state in the History Panel */
"HistoryPanel.EmptySyncedTabsPanelNotSignedInState.Description" = "आपन दोसरो उपकरणों से टैब की सूची देखै ले साइन इन करो।";

/* Title for the empty synced tabs state in the History Panel */
"HistoryPanel.EmptySyncedTabsState.Title" = "Firefox सिंक";

/* Title for the Back to History button in the History Panel */
"HistoryPanel.HistoryBackButton.Title" = "इतिहास";

/* Title for the Recently Closed button in the History Panel */
"HistoryPanel.RecentlyClosedTabsButton.Title" = "हाल में बंद करलोॅ गेल";

/* Accessibility label for the tab toolbar indicating the Home button. */
"Home" = "होम";

/* The title for the Bookmark context menu action for sites in Home Panels */
"HomePanel.ContextMenu.Bookmark" = "बुकमार्क";

/* The title for the Delete from History context menu action for sites in Home Panels */
"HomePanel.ContextMenu.DeleteFromHistory" = "इतिहास से हटाबोॅ";

/* The title for the Open in New Private Tab context menu action for sites in Home Panels */
"HomePanel.ContextMenu.OpenInNewPrivateTab.v101" = "नया गोपनीय टैब में खोलियै";

/* The title for the Open in New Tab context menu action for sites in Home Panels */
"HomePanel.ContextMenu.OpenInNewTab" = "नया टैब मे खोलियै";

/* The title for the Remove context menu action for sites in Home Panels */
"HomePanel.ContextMenu.Remove" = "हटाबोॅ";

/* The title for the Remove Bookmark context menu action for sites in Home Panels */
"HomePanel.ContextMenu.RemoveBookmark" = "बुकमार्क हटाबोॅ";

/* The title for the Share context menu action for sites in Home Panels */
"HomePanel.ContextMenu.Share" = "शेयर";

/* A label indicating the keyboard shortcut to navigate backwards, through session history, inside the current tab. This label is displayed in the Discoverability overlay when a user presses the Command key. The Discoverability overlay and shortcut become available only when a user has connected a hardware keyboard to an iPad. See https://drive.google.com/file/d/1gH3tbvDceg7yG5N67NIHS-AXgDgCzBHN/view?usp=sharing for more details. */
"Hotkeys.Back.DiscoveryTitle" = "पिछू जाइयै";

/* A label indicating the keyboard shortcut of closing the current tab a user is in. This label is displayed inside the Discoverability overlay when a user presses the Command key. The Discoverability overlay and shortcut become available only when a user has connected a hardware keyboard to an iPad. See https://drive.google.com/file/d/1gH3tbvDceg7yG5N67NIHS-AXgDgCzBHN/view?usp=sharing for more details. */
"Hotkeys.CloseTab.DiscoveryTitle" = "टैब बंद करोॅ";

/* A label indicating the keyboard shortcut of finding text a user desires within a page. This label is displayed inside the Discoverability overlay when a user presses the Command key. The Discoverability overlay and shortcut become available only when a user has connected a hardware keyboard to an iPad. See https://drive.google.com/file/d/1gH3tbvDceg7yG5N67NIHS-AXgDgCzBHN/view?usp=sharing for more details. */
"Hotkeys.Find.DiscoveryTitle" = "खोजोॅ";

/* A label indicating the keyboard shortcut of switching to a subsequent tab. This label is displayed inside the Discoverability overlay when a user presses the Command key. The Discoverability overlay and shortcut become available only when a user has connected a hardware keyboard to an iPad. See https://drive.google.com/file/d/1gH3tbvDceg7yG5N67NIHS-AXgDgCzBHN/view?usp=sharing for more details. */
"Hotkeys.Forward.DiscoveryTitle" = "आगू बढ़ावोॅ";

/* A label indicating the keyboard shortcut of creating a new private tab. This label is displayed inside the Discoverability overlay when a user presses the Command key. The Discoverability overlay and shortcut become available only when a user has connected a hardware keyboard to an iPad. See https://drive.google.com/file/d/1gH3tbvDceg7yG5N67NIHS-AXgDgCzBHN/view?usp=sharing for more details. */
"Hotkeys.NewPrivateTab.DiscoveryTitle" = "नया गोपनीय टैब";

/* A label indicating the keyboard shortcut of creating a new tab. This label is displayed inside the Discoverability overlay when a user presses the Command key. The Discoverability overlay and shortcut become available only when a user has connected a hardware keyboard to an iPad. See https://drive.google.com/file/d/1gH3tbvDceg7yG5N67NIHS-AXgDgCzBHN/view?usp=sharing for more details. */
"Hotkeys.NewTab.DiscoveryTitle" = "नया टैब";

/* A label indicating the keyboard shortcut of switching from Private Browsing to Normal Browsing Mode. This label is displayed inside the Discoverability overlay when a user presses the Command key. The Discoverability overlay and shortcut become available only when a user has connected a hardware keyboard to an iPad. See https://drive.google.com/file/d/1gH3tbvDceg7yG5N67NIHS-AXgDgCzBHN/view?usp=sharing for more details. */
"Hotkeys.NormalMode.DiscoveryTitle" = "सामान्य ब्राउज़िंग मोड";

/* A label indicating the keyboard shortcut of switching from Normal Browsing mode to Private Browsing Mode. This label is displayed inside the Discoverability overlay when a user presses the Command key. The Discoverability overlay and shortcut become available only when a user has connected a hardware keyboard to an iPad. See https://drive.google.com/file/d/1gH3tbvDceg7yG5N67NIHS-AXgDgCzBHN/view?usp=sharing for more details. */
"Hotkeys.PrivateMode.DiscoveryTitle" = "निजी ब्राउज़िंग मोड";

/* A label indicating the keyboard shortcut of reloading the current page. This label is displayed inside the Discoverability overlay when a user presses the Command key. The Discoverability overlay and shortcut become available only when a user has connected a hardware keyboard to an iPad. See https://drive.google.com/file/d/1gH3tbvDceg7yG5N67NIHS-AXgDgCzBHN/view?usp=sharing for more details. */
"Hotkeys.Reload.DiscoveryTitle" = "पेज फेरु लोड करोॅ";

/* A label indicating the keyboard shortcut of directly accessing the URL, location, bar. This label is displayed inside the Discoverability overlay when a user presses the Command key. The Discoverability overlay and shortcut become available only when a user has connected a hardware keyboard to an iPad. See https://drive.google.com/file/d/1gH3tbvDceg7yG5N67NIHS-AXgDgCzBHN/view?usp=sharing for more details. */
"Hotkeys.SelectLocationBar.DiscoveryTitle" = "लोकेशन बार रो चयन करोॅ";

/* A label indicating the keyboard shortcut of switching to a subsequent tab. This label is displayed inside the Discoverability overlay when a user presses the Command key. The Discoverability overlay and shortcut become available only when a user has connected a hardware keyboard to an iPad. See https://drive.google.com/file/d/1gH3tbvDceg7yG5N67NIHS-AXgDgCzBHN/view?usp=sharing for more details. */
"Hotkeys.ShowNextTab.DiscoveryTitle" = "अगला टैब दिखाबोॅ";

/* A label indicating the keyboard shortcut of switching to a tab immediately preceding to the currently selected tab. This label is displayed inside the Discoverability overlay when a user presses the Command key. The Discoverability overlay and shortcut become available only when a user has connected a hardware keyboard to an iPad. See https://drive.google.com/file/d/1gH3tbvDceg7yG5N67NIHS-AXgDgCzBHN/view?usp=sharing for more details. */
"Hotkeys.ShowPreviousTab.DiscoveryTitle" = "पिछला टैब दिखाबोॅ";

/* Accessibility label for button increasing font size in display settings of reader mode */
"Increase text size" = "शब्द रो आकार बढ़ाबो";

/* Relative time for a tab that was visited within the last few moments. */
"just now" = "अभी तुरंत";

/* This label is meant to signify the section containing a group of items from the past thirty days. */
"Last month" = "अंतिम महिना";

/* This label is meant to signify the section containing a group of items from the past seven days. */
"Last week" = "अंतिम सप्ताह";

/* Settings item that opens a tab containing the licenses. See http://mzl.la/1NSAWCG */
"Licenses" = "लाइसेंस";

/* Light theme setting in Reading View settings */
"Light" = "प्रकाश";

/* Authentication prompt log in button */
"Log in" = "लॉग इन";

/* Toggle logins syncing setting */
"Logins" = "लॉगइन्स";

/* Button to not save the user's password */
"LoginsHelper.DontSave.Button" = "नै सहेजोॅ";

/* Button to not update the user's password */
"LoginsHelper.DontUpdate.Button" = "नै अपडेट करोॅ";

/* Prompt for saving a password with no username. The parameter is the hostname of the site. */
"LoginsHelper.PromptSavePassword.Title" = "%@ ले पासवर्ड सहेजोॅ";

/* Button to save the user's password */
"LoginsHelper.SaveLogin.Button" = "लॉग इन सहेजोॅ";

/* Button to update the user's password */
"LoginsHelper.Update.Button" = "अपडेट करोॅ";

/* Toast displayed to the user after a bookmark has been added. */
"Menu.AddBookmark.Confirm" = "बुकमार्क जोड़लोॅ गेल";

/* Toast displayed to the user after adding the item to their reading list. */
"Menu.AddToReadingList.Confirm" = "पठन सूची रो जोड़लोॅ गेल";

/* Label for the button, displayed in the menu, takes you to to bookmarks screen when pressed. */
"Menu.Bookmarks.Label" = "बुकमार्कस";

/* The title for the button that lets you copy the url from the location bar. */
"Menu.Copy.Title" = "एड्रेस कॉपी करोॅ";

/* Label for the button, displayed in the menu, takes you to to Downloads screen when pressed. */
"Menu.Downloads.Label" = "डाउनलोडस";

/* Label for the button, displayed in the menu, takes you to to History screen when pressed. */
"Menu.History.Label" = "इतिहास";

/* The title for the button that lets you paste into the location bar */
"Menu.Paste.Title" = "पेस्ट";

/* The title for the button that lets you paste and go to a URL */
"Menu.PasteAndGo.Title" = "पेस्ट आरु गो";

/* Label for the button, displayed in the menu, takes you to to Reading List screen when pressed. */
"Menu.ReadingList.Label" = "पठन सूची";

/* Toast displayed to the user after a bookmark has been removed. */
"Menu.RemoveBookmark.Confirm" = "बुकमार्क हटैलोॅ गेल";

/* The title that shows the number of social URLs blocked */
"Menu.TrackingProtectionBlockedSocial.Title" = "सोशल ट्रैकर्स";

/* The title that shows the number of fingerprinting scripts blocked */
"Menu.TrackingProtectionFingerprintersBlocked.Title" = "फिंगरप्रिंटर";

/* The title for the option to view the What's new page. */
"Menu.WhatsNew.Title" = "नया कथि छै";

/* Accessibility label for the New Tab button in the tab toolbar. */
"New Tab" = "नया टैब";

/* Restore Tabs Negative Action */
"No" = "नैय";

/* OK button */
"OK" = "ठीक";

/* Restore Tabs Affirmative Action */
"Okay" = "ठीक";

/* See http://mzl.la/1G7uHo7 */
"Open Settings" = "सेटिंग्स खोलोॅ";

/* Toggle tabs syncing setting */
"Open Tabs" = "टैब्स खोलोॅ";

/* Password textbox in Authentication prompt */
"Password" = "पासवर्ड";

/* Button for closing the menu action sheet */
"PhotonMenu.close" = "बंद करियै";

/* Privacy section title */
"Privacy" = "गोपनीयता";

/* Show Firefox Browser Privacy Policy page from the Privacy section in the settings. See https://www.mozilla.org/privacy/firefox/ */
"Privacy Policy" = "गोपनीयता नीति";

/* Accessibility label for read article in reading list. It's a past participle - functions as an adjective. */
"read" = "पढ़ियै";

/* Panel accessibility label */
"Reading list" = "पठन सूची";

/* Title for the Recently Closed Tabs Panel */
"RecentlyClosedTabsPanel.Title" = "हाल में बंद करलोॅ गेल";

/* Accessibility label for the reload button */
"Reload page" = "पेज फेरु लोड करोॅ";

/* Title for the button that removes a reading list item */
"Remove" = "हटाबोॅ";

/* Name for button removing current article from reading list in reader mode */
"Remove from Reading List" = "पठन सूची से हटाबोॅ";

/* Cancel button text shown in reopen-alert at home page. */
"ReopenAlert.Actions.Cancel" = "रद्द करोॅ";

/* OK button to dismiss the error prompt. */
"ScanQRCode.Error.OK.Button" = "ठीक";

/* Title for the QR code scanner view. */
"ScanQRCode.View.Title" = "QR कोड स्कैन करोॅ";

/* Open search section of settings */
"Search" = "खोजियै";

/* The text shown in the URL bar on about:home */
"Search or enter address" = "खोजोॅ अथवा पता भरोॅ";

/* The success message that appears after a user sucessfully adds a new search engine */
"Search.ThirdPartyEngines.AddSuccess" = "सर्च ईंजन जोरल गेलै";

/* The cancel button if you do not want to add a search engine. */
"Search.ThirdPartyEngines.Cancel" = "रद्द करोॅ";

/* A title stating that we failed to add custom search engine. */
"Search.ThirdPartyEngines.DuplicateErrorTitle" = "असफल";

/* A title explaining that we failed to add a search engine */
"Search.ThirdPartyEngines.FailedTitle" = "असफल";

/* A message explaining fault in custom search engine form. */
"Search.ThirdPartyEngines.FormErrorMessage" = "कृपया सब फील्ड सही सेॅ भरोॅ";

/* A title stating that we failed to add custom search engine. */
"Search.ThirdPartyEngines.FormErrorTitle" = "असफल";

/* The confirmation button */
"Search.ThirdPartyEngines.OK" = "ठीक";

/* Menu item in settings used to open input.mozilla.org where people can submit feedback */
"Send Feedback" = "प्रतिक्रिया भेजोॅ";

/* Button title for cancelling share screen */
"SendTo.Cancel.Button" = "रद्द करोॅ";

/* Header for the list of devices table */
"SendTo.DeviceList.Text" = "उपलब्ध डिवाइसोॅ:";

/* OK button to dismiss the error prompt. */
"SendTo.Error.OK.Button" = "ठीक";

/* Title of the dialog that allows you to send a tab to a different device */
"SendTo.NavBar.Title" = "टैब भेजोॅ";

/* Navigation bar button to Send the current page to a device */
"SendTo.SendAction.Text" = "भेजोॅ";

/* Title of notification received after a spurious message from FxA has been received. */
"SentTab.NoTabArrivingNotification.title" = "Firefox सिंक";

/* Title in the settings view controller title bar */
"Settings" = "सेटिंग्स";

/* The button text in Search Settings that opens the Custom Search Engine view. */
"Settings.AddCustomEngine" = "सर्च ईंजन जोरियै";

/* The text on the Save button when saving a custom search engine */
"Settings.AddCustomEngine.SaveButtonText" = "सहेजियै";

/* The title of the  Custom Search Engine view. */
"Settings.AddCustomEngine.Title" = "सर्च ईंजन जोरियै";

/* The title for the field which sets the title for a custom search engine. */
"Settings.AddCustomEngine.TitleLabel" = "शीर्षक";

/* The placeholder for Title Field when saving a custom search engine. */
"Settings.AddCustomEngine.TitlePlaceholder" = "सर्च ईंजन";

/* The title for URL Field */
"Settings.AddCustomEngine.URLLabel" = "URL";

/* Button in Data Management that clears all items. */
"Settings.ClearAllWebsiteData.Clear.Button" = "सब वेबसाइट रो डाटा साफ करोॅ";

/* Button in settings that clears private data for the selected items. */
"Settings.ClearPrivateData.Clear.Button" = "गोपनीय डाटा मेटाबोॅ";

/* Label used as an item in Settings. When touched it will open a dialog prompting the user to make sure they want to clear all of their private data. */
"Settings.ClearPrivateData.SectionName" = "गोपनीय डाटा मेटैइयै";

/* Label used as an item in Settings. When touched it will open a dialog prompting the user to make sure they want to clear all of their private data. */
"Settings.DataManagement.SectionName" = "डेटा प्रबंधन";

/* Title displayed in header of the setting panel. */
"Settings.DataManagement.Title" = "डेटा प्रबंधन";

/* Cancel action button in alert when user is prompted for disconnect */
"Settings.Disconnect.CancelButton" = "रद्द करोॅ";

/* Option choice in display theme settings for dark theme */
"Settings.DisplayTheme.OptionDark" = "गहरा";

/* Option choice in display theme settings for light theme */
"Settings.DisplayTheme.OptionLight" = "प्रकाश";

/* Title in main app settings for Theme settings */
"Settings.DisplayTheme.Title.v2" = "थीम";

/* Label used for the device name settings section. */
"Settings.FxA.DeviceName" = "डिवाइस रो नाम";

/* Title displayed in header of the FxA settings panel. */
"Settings.FxA.Title" = "Firefox खाता";

/* General settings section title */
"Settings.General.SectionName" = "सामान्य";

/* Label used as an item in Settings. When touched it will open a dialog to configure the home page and its uses. */
"Settings.HomePage.SectionName" = "होमपेज";

/* Title for the logins and passwords screen. Translation could just use 'Logins' if the title is too long */
"Settings.LoginsAndPasswordsTitle" = "लोगिंस आरू पासवर्ड";

/* Label used to set a custom url as the new tab option (homepage). */
"Settings.NewTab.CustomURL" = "पसंदीदा URL";

/* Option in settings to show a blank page when you open a new tab */
"Settings.NewTab.Option.BlankPage" = "खाली पेज";

/* Option in settings to show Firefox Home when you open a new tab */
"Settings.NewTab.Option.FirefoxHome" = "Firefox होम";

/* Option in settings to show your homepage when you open a new tab */
"Settings.NewTab.Option.HomePage" = "होमपेज";

/* Label used as an item in Settings. When touched it will open a dialog to configure the new tab behavior. */
"Settings.NewTab.SectionName" = "नया टैब";

/* Title displayed in header of the setting panel. */
"Settings.NewTab.Title" = "नया टैब";

/* Label at the top of the New Tab screen after entering New Tab in settings */
"Settings.NewTab.TopSectionName" = "दिखाबोॅ";

/* Label used as an item in Settings. When touched it will open a dialog to configure the open with (mail links) behavior. */
"Settings.OpenWith.SectionName" = "मेल ऐप";

/* Setting to enable the built-in password manager */
"Settings.SaveLogins.Title" = "लॉग इन सहेजल गेलै";

/* Button displayed at the top of the search settings. */
"Settings.Search.Done.Button" = "पूर्ण भेल";

/* Button displayed at the top of the search settings. */
"Settings.Search.Edit.Button" = "संपादित करोॅ";

/* title for a link that explains how mozilla collects telemetry */
"Settings.SendUsage.Link" = "बेसी जानकारी";

/* A short description that explains why mozilla collects usage data. */
"Settings.SendUsage.Message" = "मोजिला खलि ओ चीज के जमा करै छै जकरा Firefox मे सभक लेली सुधार करै के आवश्यक्ता छै.";

/* The title for the setting to send usage data. */
"Settings.SendUsage.Title" = "उपयोग डेटा भेजियै";

/* The description of the open new tab siri shortcut */
"Settings.Siri.OpenTabShortcut" = "नया टैब खोलियै";

/* Dismiss button for the tracker protection alert. */
"Settings.TrackingProtection.Alert.Button" = "ठीक, बुझ गेलियै!";

/* The Title on info view which shows a list of all blocked websites */
"Settings.TrackingProtection.Info.BlocksTitle" = "ब्लॉक";

/* 'Learn more' info link on the Tracking Protection settings screen. */
"Settings.TrackingProtection.LearnMore" = "बेसी जानकारी";

/* Row in top-level of settings that gets tapped to show the tracking protection settings detail view. */
"Settings.TrackingProtection.SectionName" = "ट्रैकिंग सुरक्षा";

/* Button shows all websites on website data tableview */
"Settings.WebsiteData.ButtonShowMore" = "अधिक देखाबोॅ";

/* Description of the confirmation dialog shown when a user tries to clear their private data. */
"Settings.WebsiteData.ConfirmPrompt" = "इ क्रिया आपनों वेबसाइट डेटा के साफ़ कैर देतै। जेकरा तू फेनु पाए नै सकै छोॅ";

/* Action label on share extension to add page to the Firefox reading list. */
"ShareExtension.AddToReadingListAction.Title" = "पठन सूची में जोड़ियै";

/* Share extension label shown after user has performed 'Add to Reading List' action. */
"ShareExtension.AddToReadingListActionDone.Title" = "पठन सूची रो जोड़लोॅ गेल";

/* Action label on share extension to bookmark the page in Firefox. */
"ShareExtension.BookmarkThisPageAction.Title" = "पेज रो बुकमार्क करोॅ";

/* Share extension label shown after user has performed 'Bookmark this Page' action. */
"ShareExtension.BookmarkThisPageActionDone.Title" = "बुकमार्कड";

/* Share extension label shown after user has performed 'Load in Background' action. */
"ShareExtension.LoadInBackgroundActionDone.Title" = "Firefox में लोड भे रहलो छै";

/* Action label on share extension to immediately open page in Firefox. */
"ShareExtension.OpenInFirefoxAction.Title" = "Firefox में खोलियै";

/* Action label on share extension to search for the selected text in Firefox. */
"ShareExtension.SeachInFirefoxAction.Title" = "Firefox में खोजियै";

/* Label for show search suggestions setting. */
"Show Search Suggestions" = "खोज सुझाव दिखाबियै";

/* Accessibility Label for the tab toolbar Stop button */
"Stop" = "रूकयै";

/* Support section title */
"Support" = "समर्थन";

/* A label indicating the keyboard shortcut of showing the tab tray. This label is displayed inside the Discoverability overlay when a user presses the Command key. The Discoverability overlay and shortcut become available only when a user has connected a hardware keyboard to an iPad. See https://drive.google.com/file/d/1gH3tbvDceg7yG5N67NIHS-AXgDgCzBHN/view?usp=sharing for more details. */
"Tab.ShowTabTray.KeyCodeTitle" = "सब टैब बंद दिखाबियै";

/* The button to undo the delete all tabs */
"Tabs.DeleteAllUndo.Button" = "पहनो जैसन करोॅ";

/* A label indicating the keyboard shortcut of closing all tabs from the tab tray. This label is displayed inside the Discoverability overlay when a user presses the Command key. The Discoverability overlay and shortcut become available only when a user has connected a hardware keyboard to an iPad. See https://drive.google.com/file/d/1gH3tbvDceg7yG5N67NIHS-AXgDgCzBHN/view?usp=sharing for more details. */
"TabTray.CloseAllTabs.KeyCodeTitle" = "सब टैबो बंद करोॅ";

/* A label indicating the keyboard shortcut of opening a new tab in the tab tray. This label is displayed inside the Discoverability overlay when a user presses the Command key. The Discoverability overlay and shortcut become available only when a user has connected a hardware keyboard to an iPad. See https://drive.google.com/file/d/1gH3tbvDceg7yG5N67NIHS-AXgDgCzBHN/view?usp=sharing for more details. */
"TabTray.OpenNewTab.KeyCodeTitle" = "नया टैब खोलियै";

/* Relative date for date in past week. */
"this week" = "इस सप्ताह";

/* label for Not Now button */
"Toasts.NotNow" = "अभि नै";

/* Open App Store button */
"Toasts.OpenAppStore" = "App store खोलियै";

/* Label for button to undo the action just performed */
"Toasts.Undo" = "पहनो जैसन करोॅ";

/* This label is meant to signify the section containing a group of items from the current day. */
"Today" = "आय";

/* Accessibility label for the Menu button. */
"Toolbar.Menu.AccessibilityLabel" = "मेनू";

/* Accessibility label for the Close All Tabs menu button. */
"Toolbar.Menu.CloseAllTabs" = "सब टैबो बंद करोॅ";

/* Button shown in editing mode to remove this site from the top sites panel. */
"TopSites.RemovePage.Button" = "%@— पेज हटाबोॅ";

/* Button to disallow the page to be translated to the user locale language */
"TranslationToastHandler.PromptTranslate.Cancel" = "नैय";

/* Button to allow the page to be translated to the user locale language */
"TranslationToastHandler.PromptTranslate.OK" = "हौं";

/* Tile title for Twitter */
"Twitter" = "Twitter";

/* The menu item that pastes the current contents of the clipboard into the URL bar and navigates to the page */
"UIMenuItem.PasteGo" = "पेस्ट आरु गो";

/* Search in New Tab Text selection menu item */
"UIMenuItem.SearchWithFirefox" = "Firefox सेॅ खोजोॅ";

/* Username textbox in Authentication prompt */
"Username" = "यूजरनाम";

/* Accessibility label for the main web content view */
"Web content" = "वेब सामग्री";

/* Tile title for Wikipedia */
"Wikipedia" = "Wikipedia";

/* Relative date for yesterday. */
"yesterday" = "काल्य";

/* This label is meant to signify the section containing a group of items from the past 24 hours. */
"Yesterday" = "काल्य";

/* Your Rights settings section title */
"Your Rights" = "अपने के अधिकार";

/* Tile title for YouTube */
"YouTube" = "YouTube";


"""

    static let CSVFile =
    """
"-","-","/* Button for smaller reader font size. Keep this extremely short! This is shown in the reader mode toolbar. */"
"+","+","/* Button for larger reader font size. Keep this extremely short! This is shown in the reader mode toolbar. */"
"A username and password are being requested by %@.","%@ यूजरनाम आरू पासवर्ड मांगी रहलो छै","/* Authentication prompt message with no realm. Parameter is the hostname of the site */"
"A username and password are being requested by %@. The site says: %@","%1$@ द्वारा एगो उपयोगकर्ता नाम आरू पासवर्ड रो अनुरोध करी रहलो छै। साइट कहै छै: %2$@","/* Authentication prompt message with a realm. First parameter is the hostname. Second is the realm string */"
"Aa","Aa","/* Button for reader mode font size. Keep this extremely short! This is shown in the reader mode toolbar. */"
"About","रो संबंध में","/* About settings section title */"
"ActivityStream.Library.Title","हाल में सहेजल गेल","/* A string used to signify the start of the Recently Saved section in Home Screen. */"
"ActivityStream.RecentHistory.Title","हाल में देखलोॅ गेल","/* Section title label for recently visited websites */"
"ActivityStream.TopSites.RowSettingFooter","पंक्तियां सेट करोॅ","/* The title for the setting page which lets you select the number of top site rows */"
"Add Tab","टैब जोरोॅ","/* Accessibility label for the Add Tab button in the Tab Tray. */"
"Add to Reading List","पठन सूची में जोड़ोॅ","/* Name for button adding current article to reading list in reader mode */"
"Added page to Reading List","पठन सूची रो पेज जोड़लोॅ गेल","/* Accessibility message e.g. spoken by VoiceOver after the current page gets added to the Reading List using the Reader View button, e.g. by long-pressing it or by its accessibility custom action. */"
"AddPass.Error.Dismiss","ठीक","/* Button to dismiss the 'Add Pass Failed' alert.  See https://support.apple.com/HT204003 for context on Wallet. */"
"AddPass.Error.Message","पास रो वॉलेट में जोड़ै समय गलती भेल. कृपया बादो मेॅ फेनू कोशिश करोॅ.","/* Text of the 'Add Pass Failed' alert.  See https://support.apple.com/HT204003 for context on Wallet. */"
"AddPass.Error.Title","पास करे मेॅ विफल","/* Title of the 'Add Pass Failed' alert. See https://support.apple.com/HT204003 for context on Wallet. */"
"Address and Search","पता आरू खोज","/* Accessibility label for address and search field, both words (Address, Search) are therefore nouns. */"
"Always Send","हमेशा भेजोॅ","/* Used as a button label for crash dialog prompt */"
"Amazon","Amazon","/* Tile title for Amazon */"
"Authentication required","प्रमाणीकरण जरुरी छै","/* Authentication prompt title */"
"Back","पिछू","/* Accessibility label for the Back button in the tab toolbar. */"
"Block Pop-up Windows","पॉपअप विंडो रो अवरोध करोॅ","/* Block pop-up windows setting */"
"Bookmark.DetailFieldTitle.Label","शीर्षक","/* The label for the Title field when editing a bookmark */"
"Bookmark.DetailFieldURL.Label","URL","/* The label for the URL field when editing a bookmark */"
"Bookmarks","बुकमार्कस","/* Toggle bookmarks syncing setting */"
"Bookmarks.Edit.Button","संपादित करोॅ","/* The button on the snackbar to edit a bookmark after adding it. */"
"Bookmarks.EditBookmark.Label","बुकमार्क संपादित करोॅ","/* The button to edit a bookmark */"
"Bookmarks.EditFolder.Label","फोल्डर संपादित करोॅ","/* The button to edit a folder */"
"Bookmarks.Folder.Label","फोल्डर","/* The label to show the location of the folder where the bookmark is located */"
"Bookmarks.Menu.DesktopBookmarks","डेस्कटॉप बुकमार्कस","/* A label indicating all bookmarks grouped under the category 'Desktop Bookmarks'. */"
"Bookmarks.NewBookmark.Label","नया बुकमार्क","/* The button to create a new bookmark */"
"Bookmarks.NewFolder.Label","नया फोल्डर","/* The button to create a new folder */"
"Bookmarks.NewSeparator.Label","नया विभाजक","/* The button to create a new separator */"
"Bookmarks.Title.Label","शीर्षक","/* The label for the title of a bookmark */"
"BreachAlerts.BreachDate","ई उल्लंघन भेल","/* Describes the date on which the breach occurred */"
"BreachAlerts.Description","जब तोय अंतिम बार पासवर्ड बदललो रहे ते पासवर्ड लीक या चोरी भे गेल रहै| खाता के सुरक्षा खातिर साईट मे लॉग इन करोॅ आरू पासवर्ड बदलोॅ |","/* Description of what a breach is */"
"BreachAlerts.LearnMoreButton","बेसी जानकारी","/* Link to monitor.firefox.com to learn more about breached passwords */"
"BreachAlerts.Link","खातिर जाहो","/* Leads to a link to the breached website */"
"BreachAlerts.Title","वेबसाइट भंग भेल","/* Title for the Breached Login Detail View. */"
"Brightness","चमक","/* Accessibility label for brightness adjustment slider in Reader Mode display settings */"
"Cancel","रद्द करोॅ","/* Label for Cancel button */"
"Changes color theme.","रंग थीम बदलोॅ","/* Accessibility hint for the color theme setting buttons in reader mode display settings */"
"Changes font type.","फ्रंट प्रकार बदलोॅ","/* Accessibility hint for the font type buttons in reader mode display settings */"
"ClipboardToast.GoToCopiedLink.Button","जाइयै","/* The button to open a new tab with the copied link */"
"ClipboardToast.GoToCopiedLink.Title","कॉपी करलोॅ लिंक पर जाए ले चाहे छिकै?","/* Message displayed when the user has a copied link on the clipboard */"
"Close","बंद करोॅ","/* Accessibility label for action denoting closing a tab in tab list (tray) */"
"Closing tab","टैब बंद करि रहलोॅ छै","/* Accessibility label (used by assistive technology) notifying the user that the tab is being closed. */"
"ContextMenu.BookmarkLinkButtonTitle","बुकमार्कस लिंक","/* Context menu item for bookmarking a link URL */"
"ContextMenu.ButtonToast.NewPrivateTabOpened.LabelText","नया गोपनीय टेब खुलल","/* The label text in the Button Toast for switching to a fresh New Private Tab. */"
"ContextMenu.ButtonToast.NewTabOpened.ButtonText","बदलोॅ","/* The button text in the Button Toast for switching to a fresh New Tab. */"
"ContextMenu.ButtonToast.NewTabOpened.LabelText","नया टैब खुलल","/* The label text in the Button Toast for switching to a fresh New Tab. */"
"ContextMenu.CopyImageButtonTitle","इमेज कॉपी करोॅ","/* Context menu item for copying an image to the clipboard */"
"ContextMenu.CopyImageLinkButtonTitle","इमेज रो लिंक कॉपी करोॅ","/* Context menu item for copying an image URL to the clipboard */"
"ContextMenu.CopyLinkButtonTitle","लिंक कॉपी करोॅ","/* Context menu item for copying a link URL to the clipboard */"
"ContextMenu.DownloadLinkButtonTitle","लिंक डाउनलोड करोॅ","/* Context menu item for downloading a link URL */"
"ContextMenu.OpenInNewTabButtonTitle","नया टैब में खोलोॅ","/* Context menu item for opening a link in a new tab */"
"ContextMenu.SaveImageButtonTitle","चित्र सहेजोॅ","/* Context menu item for saving an image */"
"ContextMenu.ShareLinkButtonTitle","लिंक शेयर करोॅ","/* Context menu item for sharing a link URL */"
"Could not add page to Reading list","पठन सूची रो पेज नै जोड़लोॅ गेल","/* Accessibility message e.g. spoken by VoiceOver after adding current webpage to the Reading List failed. */"
"Could not add page to Reading List. Maybe it’s already there?","पठन सूची मेॅ पेज नै जुड़ सकलै। शायद इ पहलोॅ से जुड़ल छै ?","/* Accessibility message e.g. spoken by VoiceOver after the user wanted to add current page to the Reading List and this was not done, likely because it already was in the Reading List, but perhaps also because of real failures. */"
"Could not load page.","पेज नै लोड होए सकलोॅ","/* Error message that is shown in settings when there was a problem loading */"
"CoverSheet.v24.ETP.Settings.Button","सेटिंग्स में जाहोॅ","/* Text for the new ETP settings button */"
"CoverSheet.v24.ETP.Title","विज्ञापन ट्रैकिंग रो विरुद्ध संरक्षण","/* Title for the new ETP mode i.e. standard vs strict */"
"Create an account","नया खाता बनाबोॅ","/* See http://mzl.la/1Qtkf0j */"
"Dark","गहरा","/* Dark theme setting in Reading View settings */"
"Decrease text size","शब्द रो आकार घटाबो","/* Accessibility label for button decreasing font size in display settings of reader mode */"
"Default Search Engine","डिफॉल्ट सर्च इंजन","/* Title for default search engine picker. */"
"DefaultBrowserCloseButtonAccessibility.v102","बंद करियै","/* Accessibility label for action denoting closing default browser home tab banner. */"
"Display Settings","डिसप्ले सेटिंग्स","/* Name for display settings button in reader mode. Display in the meaning of presentation, not monitor. */"
"Don’t Send","नै भेजोॅ","/* Used as a button label for crash dialog prompt */"
"Done","पूर्ण भेल","/* Done button on left side of the Settings view controller title bar */"
"Downloads","डाउनलोडस","/* Panel accessibility label */"
"Downloads.Alert.DownloadNow","अभि डाउनलोड करोॅ","/* The label of the button the user will press to start downloading a file */"
"Downloads.CancelDialog.Cancel","रद्द करोॅ","/* Button confirming the cancellation of the download. */"
"Downloads.CancelDialog.Message","की तोय सच में डाउनलोड रद करै ले चाहे छौ ?","/* Alert dialog body when the user taps the cancel download icon. */"
"Downloads.CancelDialog.Resume","फेनु से शुरू करोॅ","/* Button declining the cancellation of the download. */"
"Downloads.CancelDialog.Title","डाउनलोड रद्द करोॅ","/* Alert dialog title when the user taps the cancel download icon. */"
"Downloads.Toast.Cancelled.LabelText","डाउनलोड रद्द होय गेल छै","/* The label text in the Download Cancelled toast for showing confirmation that the download was cancelled. */"
"Downloads.Toast.Failed.LabelText","डाउनलोड असफल","/* The label text in the Download Failed toast for showing confirmation that the download has failed. */"
"Downloads.Toast.GoToDownloads.Button","डाउनलोडस","/* The button to open a new tab with the Downloads home panel */"
"Downloads.Toast.MultipleFiles.DescriptionText","1 का %d फाइल्स","/* The description text in the Download progress toast for showing the number of files when multiple files are downloading. */"
"Downloads.Toast.MultipleFilesAndProgress.DescriptionText","%1$@ %2$@","/* The description text in the Download progress toast for showing the number of files (1$) and download progress (2$). This string only consists of two placeholders for purposes of displaying two other strings side-by-side where 1$ is Downloads.Toast.MultipleFiles.DescriptionText and 2$ is Downloads.Toast.Progress.DescriptionText. This string should only consist of the two placeholders side-by-side separated by a single space and 1$ should come before 2$ everywhere except for right-to-left locales. */"
"Downloads.Toast.Progress.DescriptionText","%1$@/%2$@","/* The description text in the Download progress toast for showing the downloaded file size (1$) out of the total expected file size (2$). */"
"DownloadsPanel.Delete.Title","हटाबोॅ","/* Action button for deleting downloaded files in the Downloads panel. */"
"DownloadsPanel.EmptyState.Title","डाउनलोड करलोॅ फाइलें यहां दिखी जैतै","/* Title for the Downloads Panel empty state. */"
"DownloadsPanel.Share.Title","शेयर करोॅ","/* Action button for sharing downloaded files in the Downloads panel. */"
"Enter your password to connect","जुरै लेॅ पासवर्ड दहो","/* Text message in the settings table view */"
"ErrorPages.Advanced.Button","विकसित करलोॅ गेल","/* Label for button to perform advanced actions on the error page */"
"ErrorPages.AdvancedWarning1.Text","चेतावनी: हम पक्का नै कैर सकै छियै की इ वेबसाइट सुरक्षित छै ।","/* Warning text when clicking the Advanced button on error pages */"
"ErrorPages.CertWarning.Title","इ कनेक्शन विश्वासयोग्य नै छै","/* Title on the certificate error page */"
"ErrorPages.GoBack.Button","पिछू जाइयै","/* Label for button to go back from the error page */"
"ErrorPages.VisitOnce.Button","फिर भी साइट देखोॅ","/* Button label to temporarily continue to the site from the certificate error page */"
"ExternalLink.AppStore.ConfirmationTitle","इस लिंक रो App Store में खोलोॅ?","/* Question shown to user when tapping a link that opens the App Store app */"
"ExternalLink.AppStore.GenericConfirmationTitle","इस लिंक रो बाहरी एप्प में खोलोॅ?","/* Question shown to user when tapping an SMS or MailTo link that opens the external app for those. */"
"Facebook","Facebook","/* Tile title for Facebook */"
"Firefox.HomePage.Title","Firefox होम पेज","/* Title for firefox about:home page in tab history list */"
"FirefoxHome.RecentHistory.Remove","हटैइयै","/* When a user taps and holds on an item from the Recently Visited section, this label will appear indicating the option to remove that item. */"
"FirefoxHomepage.ContextualMenu.Settings.v101","सेटिंग्स","/* The title for the Settings context menu action for sponsored tiles in the Firefox home page shortcuts section. Clicking this brings the users to the Shortcuts Settings. */"
"Forward","आगू बढ़ावोॅ","/* Accessibility Label for the tab toolbar Forward button */"
"FxA.FirefoxAccount","Firefox खाता","/* Settings section title for Firefox Account */"
"FxA.ManageAccount","खाता आरू उपकरण प्रबंधित करोॅ","/* Button label to go to Firefox Account settings */"
"FxA.NoInternetConnection","इंटरनेट कनेक्शन नै छै","/* Label when no internet is present */"
"FxA.SyncNow","अब सिंक करोॅ","/* Button label to Sync your Firefox Account */"
"FxAPush_DeviceConnected_body","Firefox सिंक %@ में जोड़ देल गेलै.","/* Title of a notification displayed when another device has connected to FxA. %@ refers to the name of the newly connected device. */"
"FxAPush_DeviceConnected_title","सिंक जुड़ गेल","/* Title of a notification displayed when another device has connected to FxA. */"
"FxAPush_DeviceDisconnected_body","%@ सफलतापूर्ण डिसकनेक्ट करलो गेल।","/* Body of a notification displayed when named device has been disconnected from FxA. %@ refers to the name of the disconnected device. */"
"FxAPush_DeviceDisconnected_ThisDevice_body","कंप्यूटर रो Firefox सिंक सेॅ पूरी तरह से डिसकनेक्ट भे गेल","/* Body of a notification displayed when this device has been disconnected from FxA by another device. */"
"FxAPush_DeviceDisconnected_ThisDevice_title","सिंक डिसकनेक्ट भेल","/* Title of a notification displayed when this device has been disconnected by another device. */"
"FxAPush_DeviceDisconnected_title","सिंक डिसकनेक्ट भेल","/* Title of a notification displayed when named device has been disconnected from FxA. */"
"FxAPush_DeviceDisconnected_UnknownDevice_body","ई उपकरण Firefox सिंक सेॅ डिसकनेक्ट होय गेल छै","/* Body of a notification displayed when unnamed device has been disconnected from FxA. */"
"Help","मदद","/* Show the SUMO support page from the Support section in the settings. see http://mzl.la/1dmM8tZ */"
"History","इतिहास","/* Toggle history syncing setting */"
"HistoryPanel.ClearHistoryButtonTitle","हाल रो इतिहास मिटाबो…","/* Title for button in the history panel to clear recent history */"
"HistoryPanel.ClearHistoryMenuOptionEverything","सबचीज","/* Option title to clear all browsing history. */"
"HistoryPanel.ClearHistoryMenuOptionTheLastHour","अंतिम घंटा","/* Button to perform action to clear history for the last hour */"
"HistoryPanel.ClearHistoryMenuOptionToday","आय","/* Button to perform action to clear history for today only */"
"HistoryPanel.ClearHistoryMenuOptionTodayAndYesterday","आय आरू कल","/* Button to perform action to clear history for yesterday and today */"
"HistoryPanel.EmptyState.Title","आपनो हाल के देखल वेबसाइट उपर दिख रहलो छै","/* Title for the History Panel empty state. */"
"HistoryPanel.EmptySyncedTabsPanelNotSignedInState.Description","आपन दोसरो उपकरणों से टैब की सूची देखै ले साइन इन करो।","/* Description for the empty synced tabs 'not signed in' state in the History Panel */"
"HistoryPanel.EmptySyncedTabsState.Title","Firefox सिंक","/* Title for the empty synced tabs state in the History Panel */"
"HistoryPanel.HistoryBackButton.Title","इतिहास","/* Title for the Back to History button in the History Panel */"
"HistoryPanel.RecentlyClosedTabsButton.Title","हाल में बंद करलोॅ गेल","/* Title for the Recently Closed button in the History Panel */"
"Home","होम","/* Accessibility label for the tab toolbar indicating the Home button. */"
"HomePanel.ContextMenu.Bookmark","बुकमार्क","/* The title for the Bookmark context menu action for sites in Home Panels */"
"HomePanel.ContextMenu.DeleteFromHistory","इतिहास से हटाबोॅ","/* The title for the Delete from History context menu action for sites in Home Panels */"
"HomePanel.ContextMenu.OpenInNewPrivateTab.v101","नया गोपनीय टैब में खोलियै","/* The title for the Open in New Private Tab context menu action for sites in Home Panels */"
"HomePanel.ContextMenu.OpenInNewTab","नया टैब मे खोलियै","/* The title for the Open in New Tab context menu action for sites in Home Panels */"
"HomePanel.ContextMenu.Remove","हटाबोॅ","/* The title for the Remove context menu action for sites in Home Panels */"
"HomePanel.ContextMenu.RemoveBookmark","बुकमार्क हटाबोॅ","/* The title for the Remove Bookmark context menu action for sites in Home Panels */"
"HomePanel.ContextMenu.Share","शेयर","/* The title for the Share context menu action for sites in Home Panels */"
"Hotkeys.Back.DiscoveryTitle","पिछू जाइयै","/* A label indicating the keyboard shortcut to navigate backwards, through session history, inside the current tab. This label is displayed in the Discoverability overlay when a user presses the Command key. The Discoverability overlay and shortcut become available only when a user has connected a hardware keyboard to an iPad. See https://drive.google.com/file/d/1gH3tbvDceg7yG5N67NIHS-AXgDgCzBHN/view?usp=sharing for more details. */"
"Hotkeys.CloseTab.DiscoveryTitle","टैब बंद करोॅ","/* A label indicating the keyboard shortcut of closing the current tab a user is in. This label is displayed inside the Discoverability overlay when a user presses the Command key. The Discoverability overlay and shortcut become available only when a user has connected a hardware keyboard to an iPad. See https://drive.google.com/file/d/1gH3tbvDceg7yG5N67NIHS-AXgDgCzBHN/view?usp=sharing for more details. */"
"Hotkeys.Find.DiscoveryTitle","खोजोॅ","/* A label indicating the keyboard shortcut of finding text a user desires within a page. This label is displayed inside the Discoverability overlay when a user presses the Command key. The Discoverability overlay and shortcut become available only when a user has connected a hardware keyboard to an iPad. See https://drive.google.com/file/d/1gH3tbvDceg7yG5N67NIHS-AXgDgCzBHN/view?usp=sharing for more details. */"
"Hotkeys.Forward.DiscoveryTitle","आगू बढ़ावोॅ","/* A label indicating the keyboard shortcut of switching to a subsequent tab. This label is displayed inside the Discoverability overlay when a user presses the Command key. The Discoverability overlay and shortcut become available only when a user has connected a hardware keyboard to an iPad. See https://drive.google.com/file/d/1gH3tbvDceg7yG5N67NIHS-AXgDgCzBHN/view?usp=sharing for more details. */"
"Hotkeys.NewPrivateTab.DiscoveryTitle","नया गोपनीय टैब","/* A label indicating the keyboard shortcut of creating a new private tab. This label is displayed inside the Discoverability overlay when a user presses the Command key. The Discoverability overlay and shortcut become available only when a user has connected a hardware keyboard to an iPad. See https://drive.google.com/file/d/1gH3tbvDceg7yG5N67NIHS-AXgDgCzBHN/view?usp=sharing for more details. */"
"Hotkeys.NewTab.DiscoveryTitle","नया टैब","/* A label indicating the keyboard shortcut of creating a new tab. This label is displayed inside the Discoverability overlay when a user presses the Command key. The Discoverability overlay and shortcut become available only when a user has connected a hardware keyboard to an iPad. See https://drive.google.com/file/d/1gH3tbvDceg7yG5N67NIHS-AXgDgCzBHN/view?usp=sharing for more details. */"
"Hotkeys.NormalMode.DiscoveryTitle","सामान्य ब्राउज़िंग मोड","/* A label indicating the keyboard shortcut of switching from Private Browsing to Normal Browsing Mode. This label is displayed inside the Discoverability overlay when a user presses the Command key. The Discoverability overlay and shortcut become available only when a user has connected a hardware keyboard to an iPad. See https://drive.google.com/file/d/1gH3tbvDceg7yG5N67NIHS-AXgDgCzBHN/view?usp=sharing for more details. */"
"Hotkeys.PrivateMode.DiscoveryTitle","निजी ब्राउज़िंग मोड","/* A label indicating the keyboard shortcut of switching from Normal Browsing mode to Private Browsing Mode. This label is displayed inside the Discoverability overlay when a user presses the Command key. The Discoverability overlay and shortcut become available only when a user has connected a hardware keyboard to an iPad. See https://drive.google.com/file/d/1gH3tbvDceg7yG5N67NIHS-AXgDgCzBHN/view?usp=sharing for more details. */"
"Hotkeys.Reload.DiscoveryTitle","पेज फेरु लोड करोॅ","/* A label indicating the keyboard shortcut of reloading the current page. This label is displayed inside the Discoverability overlay when a user presses the Command key. The Discoverability overlay and shortcut become available only when a user has connected a hardware keyboard to an iPad. See https://drive.google.com/file/d/1gH3tbvDceg7yG5N67NIHS-AXgDgCzBHN/view?usp=sharing for more details. */"
"Hotkeys.SelectLocationBar.DiscoveryTitle","लोकेशन बार रो चयन करोॅ","/* A label indicating the keyboard shortcut of directly accessing the URL, location, bar. This label is displayed inside the Discoverability overlay when a user presses the Command key. The Discoverability overlay and shortcut become available only when a user has connected a hardware keyboard to an iPad. See https://drive.google.com/file/d/1gH3tbvDceg7yG5N67NIHS-AXgDgCzBHN/view?usp=sharing for more details. */"
"Hotkeys.ShowNextTab.DiscoveryTitle","अगला टैब दिखाबोॅ","/* A label indicating the keyboard shortcut of switching to a subsequent tab. This label is displayed inside the Discoverability overlay when a user presses the Command key. The Discoverability overlay and shortcut become available only when a user has connected a hardware keyboard to an iPad. See https://drive.google.com/file/d/1gH3tbvDceg7yG5N67NIHS-AXgDgCzBHN/view?usp=sharing for more details. */"
"Hotkeys.ShowPreviousTab.DiscoveryTitle","पिछला टैब दिखाबोॅ","/* A label indicating the keyboard shortcut of switching to a tab immediately preceding to the currently selected tab. This label is displayed inside the Discoverability overlay when a user presses the Command key. The Discoverability overlay and shortcut become available only when a user has connected a hardware keyboard to an iPad. See https://drive.google.com/file/d/1gH3tbvDceg7yG5N67NIHS-AXgDgCzBHN/view?usp=sharing for more details. */"
"Increase text size","शब्द रो आकार बढ़ाबो","/* Accessibility label for button increasing font size in display settings of reader mode */"
"just now","अभी तुरंत","/* Relative time for a tab that was visited within the last few moments. */"
"Last month","अंतिम महिना","/* This label is meant to signify the section containing a group of items from the past thirty days. */"
"Last week","अंतिम सप्ताह","/* This label is meant to signify the section containing a group of items from the past seven days. */"
"Licenses","लाइसेंस","/* Settings item that opens a tab containing the licenses. See http://mzl.la/1NSAWCG */"
"Light","प्रकाश","/* Light theme setting in Reading View settings */"
"Log in","लॉग इन","/* Authentication prompt log in button */"
"Logins","लॉगइन्स","/* Toggle logins syncing setting */"
"LoginsHelper.DontSave.Button","नै सहेजोॅ","/* Button to not save the user's password */"
"LoginsHelper.DontUpdate.Button","नै अपडेट करोॅ","/* Button to not update the user's password */"
"LoginsHelper.PromptSavePassword.Title","%@ ले पासवर्ड सहेजोॅ","/* Prompt for saving a password with no username. The parameter is the hostname of the site. */"
"LoginsHelper.SaveLogin.Button","लॉग इन सहेजोॅ","/* Button to save the user's password */"
"LoginsHelper.Update.Button","अपडेट करोॅ","/* Button to update the user's password */"
"Menu.AddBookmark.Confirm","बुकमार्क जोड़लोॅ गेल","/* Toast displayed to the user after a bookmark has been added. */"
"Menu.AddToReadingList.Confirm","पठन सूची रो जोड़लोॅ गेल","/* Toast displayed to the user after adding the item to their reading list. */"
"Menu.Bookmarks.Label","बुकमार्कस","/* Label for the button, displayed in the menu, takes you to to bookmarks screen when pressed. */"
"Menu.Copy.Title","एड्रेस कॉपी करोॅ","/* The title for the button that lets you copy the url from the location bar. */"
"Menu.Downloads.Label","डाउनलोडस","/* Label for the button, displayed in the menu, takes you to to Downloads screen when pressed. */"
"Menu.History.Label","इतिहास","/* Label for the button, displayed in the menu, takes you to to History screen when pressed. */"
"Menu.Paste.Title","पेस्ट","/* The title for the button that lets you paste into the location bar */"
"Menu.PasteAndGo.Title","पेस्ट आरु गो","/* The title for the button that lets you paste and go to a URL */"
"Menu.ReadingList.Label","पठन सूची","/* Label for the button, displayed in the menu, takes you to to Reading List screen when pressed. */"
"Menu.RemoveBookmark.Confirm","बुकमार्क हटैलोॅ गेल","/* Toast displayed to the user after a bookmark has been removed. */"
"Menu.TrackingProtectionBlockedSocial.Title","सोशल ट्रैकर्स","/* The title that shows the number of social URLs blocked */"
"Menu.TrackingProtectionFingerprintersBlocked.Title","फिंगरप्रिंटर","/* The title that shows the number of fingerprinting scripts blocked */"
"Menu.WhatsNew.Title","नया कथि छै","/* The title for the option to view the What's new page. */"
"New Tab","नया टैब","/* Accessibility label for the New Tab button in the tab toolbar. */"
"No","नैय","/* Restore Tabs Negative Action */"
"OK","ठीक","/* OK button */"
"Okay","ठीक","/* Restore Tabs Affirmative Action */"
"Open Settings","सेटिंग्स खोलोॅ","/* See http://mzl.la/1G7uHo7 */"
"Open Tabs","टैब्स खोलोॅ","/* Toggle tabs syncing setting */"
"Password","पासवर्ड","/* Password textbox in Authentication prompt */"
"PhotonMenu.close","बंद करियै","/* Button for closing the menu action sheet */"
"Privacy","गोपनीयता","/* Privacy section title */"
"Privacy Policy","गोपनीयता नीति","/* Show Firefox Browser Privacy Policy page from the Privacy section in the settings. See https://www.mozilla.org/privacy/firefox/ */"
"read","पढ़ियै","/* Accessibility label for read article in reading list. It's a past participle - functions as an adjective. */"
"Reading list","पठन सूची","/* Panel accessibility label */"
"RecentlyClosedTabsPanel.Title","हाल में बंद करलोॅ गेल","/* Title for the Recently Closed Tabs Panel */"
"Reload page","पेज फेरु लोड करोॅ","/* Accessibility label for the reload button */"
"Remove","हटाबोॅ","/* Title for the button that removes a reading list item */"
"Remove from Reading List","पठन सूची से हटाबोॅ","/* Name for button removing current article from reading list in reader mode */"
"ReopenAlert.Actions.Cancel","रद्द करोॅ","/* Cancel button text shown in reopen-alert at home page. */"
"ScanQRCode.Error.OK.Button","ठीक","/* OK button to dismiss the error prompt. */"
"ScanQRCode.View.Title","QR कोड स्कैन करोॅ","/* Title for the QR code scanner view. */"
"Search","खोजियै","/* Open search section of settings */"
"Search or enter address","खोजोॅ अथवा पता भरोॅ","/* The text shown in the URL bar on about:home */"
"Search.ThirdPartyEngines.AddSuccess","सर्च ईंजन जोरल गेलै","/* The success message that appears after a user sucessfully adds a new search engine */"
"Search.ThirdPartyEngines.Cancel","रद्द करोॅ","/* The cancel button if you do not want to add a search engine. */"
"Search.ThirdPartyEngines.DuplicateErrorTitle","असफल","/* A title stating that we failed to add custom search engine. */"
"Search.ThirdPartyEngines.FailedTitle","असफल","/* A title explaining that we failed to add a search engine */"
"Search.ThirdPartyEngines.FormErrorMessage","कृपया सब फील्ड सही सेॅ भरोॅ","/* A message explaining fault in custom search engine form. */"
"Search.ThirdPartyEngines.FormErrorTitle","असफल","/* A title stating that we failed to add custom search engine. */"
"Search.ThirdPartyEngines.OK","ठीक","/* The confirmation button */"
"Send Feedback","प्रतिक्रिया भेजोॅ","/* Menu item in settings used to open input.mozilla.org where people can submit feedback */"
"SendTo.Cancel.Button","रद्द करोॅ","/* Button title for cancelling share screen */"
"SendTo.DeviceList.Text","उपलब्ध डिवाइसोॅ:","/* Header for the list of devices table */"
"SendTo.Error.OK.Button","ठीक","/* OK button to dismiss the error prompt. */"
"SendTo.NavBar.Title","टैब भेजोॅ","/* Title of the dialog that allows you to send a tab to a different device */"
"SendTo.SendAction.Text","भेजोॅ","/* Navigation bar button to Send the current page to a device */"
"SentTab.NoTabArrivingNotification.title","Firefox सिंक","/* Title of notification received after a spurious message from FxA has been received. */"
"Settings","सेटिंग्स","/* Title in the settings view controller title bar */"
"Settings.AddCustomEngine","सर्च ईंजन जोरियै","/* The button text in Search Settings that opens the Custom Search Engine view. */"
"Settings.AddCustomEngine.SaveButtonText","सहेजियै","/* The text on the Save button when saving a custom search engine */"
"Settings.AddCustomEngine.Title","सर्च ईंजन जोरियै","/* The title of the  Custom Search Engine view. */"
"Settings.AddCustomEngine.TitleLabel","शीर्षक","/* The title for the field which sets the title for a custom search engine. */"
"Settings.AddCustomEngine.TitlePlaceholder","सर्च ईंजन","/* The placeholder for Title Field when saving a custom search engine. */"
"Settings.AddCustomEngine.URLLabel","URL","/* The title for URL Field */"
"Settings.ClearAllWebsiteData.Clear.Button","सब वेबसाइट रो डाटा साफ करोॅ","/* Button in Data Management that clears all items. */"
"Settings.ClearPrivateData.Clear.Button","गोपनीय डाटा मेटाबोॅ","/* Button in settings that clears private data for the selected items. */"
"Settings.ClearPrivateData.SectionName","गोपनीय डाटा मेटैइयै","/* Label used as an item in Settings. When touched it will open a dialog prompting the user to make sure they want to clear all of their private data. */"
"Settings.DataManagement.SectionName","डेटा प्रबंधन","/* Label used as an item in Settings. When touched it will open a dialog prompting the user to make sure they want to clear all of their private data. */"
"Settings.DataManagement.Title","डेटा प्रबंधन","/* Title displayed in header of the setting panel. */"
"Settings.Disconnect.CancelButton","रद्द करोॅ","/* Cancel action button in alert when user is prompted for disconnect */"
"Settings.DisplayTheme.OptionDark","गहरा","/* Option choice in display theme settings for dark theme */"
"Settings.DisplayTheme.OptionLight","प्रकाश","/* Option choice in display theme settings for light theme */"
"Settings.DisplayTheme.Title.v2","थीम","/* Title in main app settings for Theme settings */"
"Settings.FxA.DeviceName","डिवाइस रो नाम","/* Label used for the device name settings section. */"
"Settings.FxA.Title","Firefox खाता","/* Title displayed in header of the FxA settings panel. */"
"Settings.General.SectionName","सामान्य","/* General settings section title */"
"Settings.HomePage.SectionName","होमपेज","/* Label used as an item in Settings. When touched it will open a dialog to configure the home page and its uses. */"
"Settings.LoginsAndPasswordsTitle","लोगिंस आरू पासवर्ड","/* Title for the logins and passwords screen. Translation could just use 'Logins' if the title is too long */"
"Settings.NewTab.CustomURL","पसंदीदा URL","/* Label used to set a custom url as the new tab option (homepage). */"
"Settings.NewTab.Option.BlankPage","खाली पेज","/* Option in settings to show a blank page when you open a new tab */"
"Settings.NewTab.Option.FirefoxHome","Firefox होम","/* Option in settings to show Firefox Home when you open a new tab */"
"Settings.NewTab.Option.HomePage","होमपेज","/* Option in settings to show your homepage when you open a new tab */"
"Settings.NewTab.SectionName","नया टैब","/* Label used as an item in Settings. When touched it will open a dialog to configure the new tab behavior. */"
"Settings.NewTab.Title","नया टैब","/* Title displayed in header of the setting panel. */"
"Settings.NewTab.TopSectionName","दिखाबोॅ","/* Label at the top of the New Tab screen after entering New Tab in settings */"
"Settings.OpenWith.SectionName","मेल ऐप","/* Label used as an item in Settings. When touched it will open a dialog to configure the open with (mail links) behavior. */"
"Settings.SaveLogins.Title","लॉग इन सहेजल गेलै","/* Setting to enable the built-in password manager */"
"Settings.Search.Done.Button","पूर्ण भेल","/* Button displayed at the top of the search settings. */"
"Settings.Search.Edit.Button","संपादित करोॅ","/* Button displayed at the top of the search settings. */"
"Settings.SendUsage.Link","बेसी जानकारी","/* title for a link that explains how mozilla collects telemetry */"
"Settings.SendUsage.Message","मोजिला खलि ओ चीज के जमा करै छै जकरा Firefox मे सभक लेली सुधार करै के आवश्यक्ता छै.","/* A short description that explains why mozilla collects usage data. */"
"Settings.SendUsage.Title","उपयोग डेटा भेजियै","/* The title for the setting to send usage data. */"
"Settings.Siri.OpenTabShortcut","नया टैब खोलियै","/* The description of the open new tab siri shortcut */"
"Settings.TrackingProtection.Alert.Button","ठीक, बुझ गेलियै!","/* Dismiss button for the tracker protection alert. */"
"Settings.TrackingProtection.Info.BlocksTitle","ब्लॉक","/* The Title on info view which shows a list of all blocked websites */"
"Settings.TrackingProtection.LearnMore","बेसी जानकारी","/* 'Learn more' info link on the Tracking Protection settings screen. */"
"Settings.TrackingProtection.SectionName","ट्रैकिंग सुरक्षा","/* Row in top-level of settings that gets tapped to show the tracking protection settings detail view. */"
"Settings.WebsiteData.ButtonShowMore","अधिक देखाबोॅ","/* Button shows all websites on website data tableview */"
"Settings.WebsiteData.ConfirmPrompt","इ क्रिया आपनों वेबसाइट डेटा के साफ़ कैर देतै। जेकरा तू फेनु पाए नै सकै छोॅ","/* Description of the confirmation dialog shown when a user tries to clear their private data. */"
"ShareExtension.AddToReadingListAction.Title","पठन सूची में जोड़ियै","/* Action label on share extension to add page to the Firefox reading list. */"
"ShareExtension.AddToReadingListActionDone.Title","पठन सूची रो जोड़लोॅ गेल","/* Share extension label shown after user has performed 'Add to Reading List' action. */"
"ShareExtension.BookmarkThisPageAction.Title","पेज रो बुकमार्क करोॅ","/* Action label on share extension to bookmark the page in Firefox. */"
"ShareExtension.BookmarkThisPageActionDone.Title","बुकमार्कड","/* Share extension label shown after user has performed 'Bookmark this Page' action. */"
"ShareExtension.LoadInBackgroundActionDone.Title","Firefox में लोड भे रहलो छै","/* Share extension label shown after user has performed 'Load in Background' action. */"
"ShareExtension.OpenInFirefoxAction.Title","Firefox में खोलियै","/* Action label on share extension to immediately open page in Firefox. */"
"ShareExtension.SeachInFirefoxAction.Title","Firefox में खोजियै","/* Action label on share extension to search for the selected text in Firefox. */"
"Show Search Suggestions","खोज सुझाव दिखाबियै","/* Label for show search suggestions setting. */"
"Stop","रूकयै","/* Accessibility Label for the tab toolbar Stop button */"
"Support","समर्थन","/* Support section title */"
"Tab.ShowTabTray.KeyCodeTitle","सब टैब बंद दिखाबियै","/* A label indicating the keyboard shortcut of showing the tab tray. This label is displayed inside the Discoverability overlay when a user presses the Command key. The Discoverability overlay and shortcut become available only when a user has connected a hardware keyboard to an iPad. See https://drive.google.com/file/d/1gH3tbvDceg7yG5N67NIHS-AXgDgCzBHN/view?usp=sharing for more details. */"
"Tabs.DeleteAllUndo.Button","पहनो जैसन करोॅ","/* The button to undo the delete all tabs */"
"TabTray.CloseAllTabs.KeyCodeTitle","सब टैबो बंद करोॅ","/* A label indicating the keyboard shortcut of closing all tabs from the tab tray. This label is displayed inside the Discoverability overlay when a user presses the Command key. The Discoverability overlay and shortcut become available only when a user has connected a hardware keyboard to an iPad. See https://drive.google.com/file/d/1gH3tbvDceg7yG5N67NIHS-AXgDgCzBHN/view?usp=sharing for more details. */"
"TabTray.OpenNewTab.KeyCodeTitle","नया टैब खोलियै","/* A label indicating the keyboard shortcut of opening a new tab in the tab tray. This label is displayed inside the Discoverability overlay when a user presses the Command key. The Discoverability overlay and shortcut become available only when a user has connected a hardware keyboard to an iPad. See https://drive.google.com/file/d/1gH3tbvDceg7yG5N67NIHS-AXgDgCzBHN/view?usp=sharing for more details. */"
"this week","इस सप्ताह","/* Relative date for date in past week. */"
"Toasts.NotNow","अभि नै","/* label for Not Now button */"
"Toasts.OpenAppStore","App store खोलियै","/* Open App Store button */"
"Toasts.Undo","पहनो जैसन करोॅ","/* Label for button to undo the action just performed */"
"Today","आय","/* This label is meant to signify the section containing a group of items from the current day. */"
"Toolbar.Menu.AccessibilityLabel","मेनू","/* Accessibility label for the Menu button. */"
"Toolbar.Menu.CloseAllTabs","सब टैबो बंद करोॅ","/* Accessibility label for the Close All Tabs menu button. */"
"TopSites.RemovePage.Button","%@— पेज हटाबोॅ","/* Button shown in editing mode to remove this site from the top sites panel. */"
"TranslationToastHandler.PromptTranslate.Cancel","नैय","/* Button to disallow the page to be translated to the user locale language */"
"TranslationToastHandler.PromptTranslate.OK","हौं","/* Button to allow the page to be translated to the user locale language */"
"Twitter","Twitter","/* Tile title for Twitter */"
"UIMenuItem.PasteGo","पेस्ट आरु गो","/* The menu item that pastes the current contents of the clipboard into the URL bar and navigates to the page */"
"UIMenuItem.SearchWithFirefox","Firefox सेॅ खोजोॅ","/* Search in New Tab Text selection menu item */"
"Username","यूजरनाम","/* Username textbox in Authentication prompt */"
"Web content","वेब सामग्री","/* Accessibility label for the main web content view */"
"Wikipedia","Wikipedia","/* Tile title for Wikipedia */"
"yesterday","काल्य","/* Relative date for yesterday. */"
"Yesterday","काल्य","/* This label is meant to signify the section containing a group of items from the past 24 hours. */"
"Your Rights","अपने के अधिकार","/* Your Rights settings section title */"
"YouTube","YouTube","/* Tile title for YouTube */"

"""
}
