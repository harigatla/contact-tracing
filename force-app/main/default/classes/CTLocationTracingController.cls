public with sharing class CTLocationTracingController {
    
    public static List<Location_Tracing__c> getVisitors(String locationId){
        return [SELECT Id, Name, Person__c, Location__c, Visit_Date__c, Person__r.Token__c, Person__r.Health_Status__c 
                FROM Location_Tracing__c 
                WHERE Location__c =:locationId 
                ORDER BY Visit_Date__c DESC];
    }

    public static List<Location_Tracing__c> getLocationsByPersonIds(Set<Id> personIds){
        return [SELECT Id, Name, Person__c, Location__c, Visit_Date__c, Person__r.Token__c, Person__r.Health_Status__c 
                FROM Location_Tracing__c 
                WHERE Person__c IN:personIds 
                AND Visit_Date__c = LAST_N_DAYS:10];
    }

    public static List<Location_Tracing__c> getLocationByLocationIds(Set<Id> locationIds){
        return [SELECT Id, Name, Person__c, Location__c, Visit_Date__c, Person__r.Token__c, Person__r.Health_Status__c 
        FROM Location_Tracing__c 
        WHERE Location__c IN:locationIds 
        AND Person__r.Health_Status__c = 'Green'
        AND Visit_Date__c = LAST_N_DAYS:10];   
    }

    public static List<Location_Tracing__c> checkDuplicates(List<Location_Tracing__c> newLocationTraces){
        Set<Id> locationId = new Set<Id>();
        Set<Id> personId = new Set<Id>();
        for(Location_Tracing__c trace : newLocationTraces){
            locationId.add(trace.Location__c);
            personId.add(trace.Person__c);
        }
        Map<Id,Set<Id>> existingMapRecordsMap = new Map<Id,Set<Id>>();
        List<Location_Tracing__c> duplicateRecords = new List<Location_Tracing__c>();
        List<Location_Tracing__c> existingLocationTracingRecords = [SELECT Id, Name, Person__c, Location__c, Visit_Date__c, Person__r.Token__c, Person__r.Health_Status__c 
                                                                    FROM Location_Tracing__c WHERE Location__c IN: locationId AND Person__c IN:personId];
        if(existingLocationTracingRecords!=null && existingLocationTracingRecords.size()>0){
            for(Location_Tracing__c trace : existingLocationTracingRecords){
                if(!existingMapRecordsMap.containsKey(trace.Location__c)){
                    existingMapRecordsMap.put(trace.Location__c, new Set<Id>());
                }
                existingMapRecordsMap.get(trace.Location__c).add(trace.Location__c);
            }
        
            for(Location_Tracing__c locationTracingRecord : newLocationTraces){
                if (existingMapRecordsMap.containsKey(locationTracingRecord.Location__c) && existingMapRecordsMap.get(locationTracingRecord.Location__c).contains(locationTracingRecord.Person__c)) {
                duplicateRecords.add(locationTracingRecord);
                }
            }
        }
        return duplicateRecords;
    }

    public static void updateRedScore(Set<Id> locationIds){
        List<Location__c> locationToUpdate = new List<Location__c>();
        AggregateResult[] redPeopleLocation=[SELECT Location__c, Count(Id) total FROM Location_Tracing__c
                                            WHERE Person__r.Health_Status__c = 'red'
                                            AND Visit_Date__c = LAST_N_DAYS:10
                                            AND Location__c IN:locationIds 
                                            GROUP BY Location__c];
        for (AggregateResult ar : redPeopleLocation) {
            String locationId = String.valueOf(ar.get('Location__c'));
            Integer redScore = Integer.valueOf(ar.get('total'));
            String status = getStatus(RedScore);
            locationToUpdate.add(new Location__c(Id=locationId, Red_Score__c = redScore, Status__c=status));
        }

        if (locationToUpdate.size()>0 && locationToUpdate != null) {
            update locationToUpdate;
        }
    }

    public static String getStatus(Integer redScore){
        if (redScore == 0) {
            return 'Green';
        } else if(redScore <= 5) {
            return 'Yellow';
        }else if(redScore <= 10) {
            return 'Orange';
        } else {
            return 'Red';
        }
    }
}