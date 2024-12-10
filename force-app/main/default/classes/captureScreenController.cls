/**
 * captureScreenController
 *
 * A global Apex controller to handle screen capture functionality in Salesforce.
 * Provides methods to capture, update, and delete screenshots, and retrieve associated metadata.
 *
 * @date 06/03/2024
 * @createdBy wrnunzio
 */
global without sharing class captureScreenController {
    
    /**
     * Record ID of the current context (e.g., Case ID).
     */
    global String recordId { get; set; }
    
    /**
     * The Case object associated with the given record ID.
     */
    global Case currentCase { get; set; }
    
    /**
     * Constructor for the captureScreenController.
     * Initializes the recordId from the current page's parameters and retrieves the associated Case.
     */
    global captureScreenController() {
        this.recordId = ApexPages.currentPage().getParameters().get('id');
        System.debug('##this.recordId## ' + this.recordId);
        Id idx = this.recordId;
        
        // Validate if the record ID belongs to a Case object.
        if (idx != null && idx.getSobjectType() != Case.getSObjectType()) {
            this.recordId = null;
            return;
        }
        
        // Query the Case record if the record ID is valid.
        if (idx != null) {
            this.currentCase = [SELECT Id, CaseNumber FROM Case WHERE Id = :idx];
        }
        System.debug('##this.currentCase## ' + this.currentCase);
    }
    
    /**
     * Captures a screenshot, stores it as a ContentVersion record, and associates it with a given parent ID.
     *
     * @param file Base64-encoded string representing the screenshot file.
     * @param idx The ID of the parent record (e.g., Case) to associate the screenshot with.
     *
     * @return A map containing the image source URL, title, and content document ID.
     */
    @RemoteAction
    global static Object captureScreen(String file, String idx) {
        System.debug('##file## ' + file);
        System.debug('##file## ' + JSON.serialize(file));
        ContentVersion cv = new ContentVersion();
        cv.VersionData = EncodingUtil.base64Decode(file);
        cv.Title = 'screenshot' + Datetime.now() + '.png';
        cv.PathOnClient = '/' + cv.Title;
        cv.FirstPublishLocationId = idx;
        insert cv;
        
        // Retrieve the inserted ContentVersion record.
        cv = [SELECT Id, Title, ContentDocumentId FROM ContentVersion WHERE Id = :cv.Id];
        return new Map<String, String>{
                'imgsrc' => '/sfc/servlet.shepherd/document/download/' + cv.ContentDocumentId,
                'title' => cv.Title,
                'cdId' => cv.ContentDocumentId
        };
    }
    
    /**
     * Updates the title of the latest ContentVersion associated with a given ContentDocument ID.
     *
     * @param cdId The ID of the ContentDocument to update.
     * @param title The new title to assign to the ContentVersion.
     */
    @RemoteAction
    global static void updateContentVersion(String cdId, String title) {
        ContentVersion cv = new ContentVersion();
        cv = [SELECT Id, Title, ContentDocumentId FROM ContentVersion WHERE ContentDocumentId = :cdId AND IsLatest = TRUE LIMIT 1];
        cv.Title = title + '.png';
        update cv;
    }
    
    /**
     * Deletes the ContentDocument and all associated versions using the given ContentDocument ID.
     *
     * @param cdId The ID of the ContentDocument to delete.
     */
    @RemoteAction
    global static void deleteScreeshot(String cdId) {
        delete [SELECT Id FROM ContentDocument WHERE Id = :cdId];
    }

}