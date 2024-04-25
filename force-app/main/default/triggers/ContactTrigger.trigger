trigger ContactTrigger on Contact (after insert, after update, after delete, after undelete) {
    switch on trigger.operationType {
        when AFTER_INSERT {
            ContactTriggerHandler.afterInsertOperation(Trigger.new);
        }

        when AFTER_UPDATE{
            ContactTriggerHandler.afterUpdateOperation(Trigger.new, Trigger.oldMap);
        }

        when AFTER_DELETE{
            ContactTriggerHandler.afterDeteleOperation(Trigger.old);
        }

        when AFTER_UNDELETE{
            ContactTriggerHandler.afterUndeleteOperation(Trigger.new);
        }
    }
}