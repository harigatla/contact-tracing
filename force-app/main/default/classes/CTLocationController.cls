public with sharing class CTLocationController {

    public static List<Location__c> getRecentStatusChanges(){
        return [SELECT Id, Name, Address__c, Pincode__c, Red_Score__c, Status_Update_Date__c, Status__c FROM Location__c ORDER BY Status_Update_Date__c DESC NULLS LAST LIMIT 100];
    }

    public static List<Location__c> searchLocations(String searchTerm){
        searchTerm = searchTerm + '%';
        return [SELECT Id, Name, Address__c, Pincode__c, Red_Score__c, Status_Update_Date__c, Status__c FROM Location__c WHERE Name LIKE :searchTerm OR Pincode__c LIKE :searchTerm OR Address__c LIKE :searchTerm ORDER BY Status_Update_Date__c DESC ];
    }

    public static Location__c getLocationById(String locationId){
        List<Location__c> locations = [SELECT Id, Name, Address__c, Pincode__c, Red_Score__c, Status_Update_Date__c, Status__c FROM Location__c WHERE Id =:locationId]; 
        if(locations != null && locations.size()>0){
        return locations[0];
        }
    return null;
    }

    public static Map<String,Integer> getStatusCount(){
        Map<String,Integer> statusCountMap = new Map<String,Integer>();
        for(AggregateResult ar: [SELECT Count(Id) total, Status__c FROM Location__c GROUP BY Status__c]){
            String healthStatus = String.valueOf(ar.get('Status__c'));
            Integer locationCount = Integer.valueOf(ar.get('total'));
            statusCountMap.put(healthStatus, locationCount);
        }
        return statusCountMap;
    }
}