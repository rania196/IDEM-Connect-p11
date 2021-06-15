trigger TriggerOnOrder on Order (before Update , after delete) {
    if (Trigger.isUpdate) {
        CheckingOrderAndAccountFields.CheckingOrderItem(trigger.New , trigger.oldMap);
        
}
if (Trigger.isDelete) {
    CheckingOrderAndAccountFields.UncheckTheCustomField(trigger.old);
}

}