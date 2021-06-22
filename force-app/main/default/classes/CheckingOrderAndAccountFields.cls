public with sharing class CheckingOrderAndAccountFields {
    public static void CheckingOrderItem(List<Order> newOrders, Map<Id,Order> oldOrders) {
       for (Order o : newOrders ){
            if (o.Status == 'Activated' && oldOrders.get(o.Id).Status =='Draft' && o.OrderItems.size() == 0 ){
                o.addError('Vous ne pouvez pas changer le statut !');
            }
       }
    }
    public static void UncheckTheCustomField ( List<Order> oldOrders){
           List<Account> accList=new List<Account>();
           Set<Id> accIds=new Set<Id>();
           Boolean updated=false;
           for(Order o:oldOrders){
               accIds.add(o.AccountId);
           }
           accList=[SELECT Id,Active__c ,(SELECT Id FROM Orders ) FROM Account WHERE Id IN :accIds];
           for(Account acc:accList){
               if(acc.Orders.size()==0){
                   acc.Active__c=false;
               }
           }
               update accList;
           
    }
    public static void checkAccountRelatedList(List<Account> accs ){
        
        List<Task> tskList=new List<Task>();
        
        for(Account acc:accs){
            if(acc.Tasks.size()==0 && acc.Orders.size()==0) {
                Task tsk = new Task();
                tsk.Subject = 'Call';
                tsk.Status = 'New';
                tsk.Priority = 'Normal';
               tsk.WhatId = acc.ID;
                tsk.OwnerId = acc.OwnerId;
                tsk.IsReminderSet = true;
                tsk.ReminderDateTime = System.today().addDays(5);
                tskList.add(tsk);
            }
        }
        if(tskList.size()>0){
            insert tskList;

        }
        
    }
}