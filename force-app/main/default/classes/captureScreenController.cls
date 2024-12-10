/**
 * captureScreenController
 * @date 06/03/2024
 * @createdBy wrnunzio
 */
global without sharing class captureScreenController {
    
    global String recordId { get; set; }
    global Case currentCase { get; set; }
    global Case currentCases { get; set; }
    global captureScreenController() {
        this.recordId = ApexPages.currentPage().getParameters().get('id');
        System.debug('##this.recordId## ' + this.recordId);
        Id idx = this.recordId;
        if (idx != null && idx.getSobjectType() != Case.getSObjectType()) {
            this.recordId = null;
            return;
        }
        if (idx != null) {
            this.currentCase = [SELECT Id, CaseNumber FROM Case WHERE Id = :idx];
        }
        System.debug('##this.currentCase## ' + this.currentCase);
    }
    
    @RemoteAction
    global static Object captureScreen(String file, String idx) {
        System.debug('##file## ' + file);
        System.debug('##file## ' + JSON.serialize(file));
        ContentVersion cv = new ContentVersion();
        cv.VersionData = EncodingUtil.base64Decode(file);
        cv.PathOnClient = '/';
        cv.Title = 'screenshot' + Datetime.now() + '.png';
        cv.FirstPublishLocationId = idx;
        insert cv;
        cv = [SELECT Id, Title, ContentDocumentId FROM ContentVersion WHERE Id = :cv.Id];
        return new Map<String, String>{
                'imgsrc' => '/sfc/servlet.shepherd/document/download/' + cv.ContentDocumentId,
                'title' => cv.Title,
                'cdId' => cv.ContentDocumentId
        };
    }
    @RemoteAction
    global static void updateContentVersion(String cdId, String title) {
        ContentVersion cv = new ContentVersion();
        cv = [SELECT Id, Title, ContentDocumentId FROM ContentVersion WHERE ContentDocumentId = :cdId AND IsLatest = TRUE LIMIT 1];
        cv.Title = title + '.png';
        update cv;
    }
    @RemoteAction
    global static void deleteScreeshot(String cdId) {
        delete [SELECT Id FROM ContentDocument WHERE Id = :cdId];
    }
    @AuraEnabled
    global static void captureScreenAura(String file) {
        System.debug('##file## ' + file);
        System.debug('##file## ' + JSON.serialize(file));
        ContentVersion cv = new ContentVersion();
        cv.VersionData = EncodingUtil.base64Decode(file);
        cv.PathOnClient = '/';
        cv.Title = 'screenshot' + Datetime.now() + '.png';
        cv.FirstPublishLocationId = '5000Y00000CwJhnQAF';
        insert cv;
    }

}