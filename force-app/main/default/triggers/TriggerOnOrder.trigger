trigger TriggerOnOrder on Order (before Update , after delete) {
    if (Trigger.isUpdate) {
        system.debug('trigger' + trigger.new);
        system.debug('trigger' + trigger.oldMap);
        CheckingOrderAndAccountFields.CheckingOrderItem(trigger.New , trigger.oldMap);
        
}
if (Trigger.isDelete) {
    CheckingOrderAndAccountFields.UncheckTheCustomField(trigger.old);
}

}