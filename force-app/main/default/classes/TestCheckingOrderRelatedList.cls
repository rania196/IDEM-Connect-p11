@isTest
public with sharing class TestCheckingOrderRelatedList {
    @TestSetup static void makeData(){
         List<Account> accountsTest = new List<Account>();
         List<Order> ordersTest = new List<Order>();
         List<OrderItem> orderItems = new List<OrderItem>();

         for(integer i=0;i<10;i++){
            Account acc1 = new Account(Name = 'Test Account ' + i);
            acc1.Active__c = false;
            accountsTest.add(acc1);
         }
        
        insert accountsTest;
        
     integer i = 0 ;
        for(Account acc : accountsTest){
            
            Order od = new Order(Name = 'order n ' + i ,AccountId = acc.Id, Status='draft', EffectiveDate= Date.today(),  Pricebook2Id = Test.getStandardPricebookId());
           
             ordersTest.add(od);
            i++;
         }
         insert ordersTest;
         
         for(Account acc : accountsTest){
             acc.Active__c = true ;
         }
         System.debug(accountsTest[0].Active__c + 'status Account');

        Product2 pd1 = new Product2(Name = 'Chemise Verte longue XYX', Family = 'Chemise');
        insert pd1;
 
        
}
       @isTest
        static void CheckingOrderItemTest(){
        Order o = [SELECT id,Status, (SELECT id FROM OrderItems) FROM Order Limit 1];
        o.Status = 'Activated';
        Test.startTest();
         Database.SaveResult result = Database.update(o,false);
         Test.stopTest();
       System.assertEquals('Vous ne pouvez pas changer le statut !',result.getErrors()[0].getMessage());
       }
        @isTest
       static void TestUncheckTheCustomField(){
           Account acc = [SELECT Id,Active__c FROM Account Limit 1];
           Order od = [SELECT id FROM Order Limit 1];
           Test.startTest();
           Database.DeleteResult result = Database.delete(od);
           Test.stopTest();
          System.assertEquals(false, acc.Active__c);
          System.debug(acc.Active__c);

       }
}