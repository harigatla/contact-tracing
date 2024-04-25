public with sharing class CTPeopleTracingController {

    public static List<People_Tracing__c> getTraces(String personId){
        return [SELECT Id, Name, Contact_Date__c, Contact_Type__c, Person_1__c, Person_1__r.Health_Status__c, Person_1__r.Token__c, Person_2__c, Person_2__r.Health_Status__c, Person_2__r.Token__c 
                FROM People_Tracing__c 
                WHERE Person_1__c = :personId OR Person_2__c = :personId 
                ORDER BY Contact_Date__c DESC];
    }

    public static List<People_Tracing__c> checkDuplicates(List<People_Tracing__c> newPeopleTraces){
        set<Id> personIds = new set<Id>();
        for( People_Tracing__c trace: newPeopleTraces){
            personIds.add(trace.Person_1__c);
            personIds.add(trace.Person_2__c);
        }
        Map<Id, set<Id>> existingPeopleTracingMap = new Map<Id, set<Id>>();
        List<People_Tracing__c> duplicates = new List<People_Tracing__c>();
        List<People_Tracing__c> existingRecords = [SELECT Id, Person_1__c, Person_2__c 
                                                    FROM People_Tracing__c
                                                    WHERE Person_1__c =:personIds OR Person_2__c =:personIds];
        if(existingPeopleTracingMap != null && existingPeopleTracingMap.size()>0){
            for(People_Tracing__c trace : existingRecords){          
                if(!existingPeopleTracingMap.containsKey(trace.Person_1__c)){
                    existingPeopleTracingMap.put(trace.Person_1__c, new Set<Id>());
                }
                existingPeopleTracingMap.get(trace.Person_1__c).add(trace.Person_2__c);
                if(!existingPeopleTracingMap.containsKey(trace.Person_2__c)){
                    existingPeopleTracingMap.put(trace.Person_1__c, new Set<Id>());
                }
                existingPeopleTracingMap.get(trace.Person_2__c).add(trace.Person_1__c);
            }
            for(People_Tracing__c trace: newPeopleTraces){
                if((existingPeopleTracingMap.containsKey(trace.Person_1__c) && existingPeopleTracingMap.get(trace.Person_1__c).contains(trace.Person_2__c))
                    ||
                    (existingPeopleTracingMap.containsKey(trace.Person_2__c) && existingPeopleTracingMap.get(trace.Person_2__c).contains(trace.Person_1__c))
                ){
                    duplicates.add(trace);
                }
            }
        }
        return duplicates;
    }
}