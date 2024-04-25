trigger CTPersonTrigger on Person__c (before insert, after insert, before update, after update, before delete, after delete, after undelete) {
    switch on trigger.operationType {
        when  BEFORE_INSERT{
            CTPersonTriggerHandler.beforeInsert(trigger.new);
        }
        when BEFORE_UPDATE {
            CTPersonTriggerHandler.beforeUpdate(trigger.new, trigger.oldMap);       
        }
        when AFTER_UPDATE {
            CTPersonTriggerHandler.afterUpdate(trigger.new, trigger.oldMap);
        }
    }
}