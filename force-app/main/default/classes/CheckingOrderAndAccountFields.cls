public with sharing class CheckingOrderAndAccountFields {
    public static void CheckingOrderItem(List<Order> newOrders, List<Order> oldOrders) {
       integer i=0;
       for (Order o : newOrders ){
            if (o.Status == 'Activated' && oldOrders[i].Status =='Draft' && o.Order_Item__c == 0 ){
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
}
