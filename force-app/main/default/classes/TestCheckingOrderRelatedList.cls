@isTest
public with sharing class TestCheckingOrderRelatedList {
    @TestSetup static void makeData(){
         List<Account> accountsTest = new List<Account>();
         List<Order> ordersTest = new List<Order>();
         List<OrderItem> orderItems = new List<OrderItem>();
         for(integer i=0;i<10;i++){
            Account acc1 = new Account(Name = 'Test Account ' + i, Chiffre_d_affaire__c= 10 );
            accountsTest.add(acc1);
         }
        
        insert accountsTest;
      integer i = 0 ;
        for(Account acc : [SELECT Id FROM Account]){
            Order od = new Order(Name = 'order n ' + i ,AccountId = acc.Id, Status='draft', EffectiveDate= Date.newInstance(2021, 04, 1),  Pricebook2Id = Test.getStandardPricebookId(), ShipmentCost__c = 10 );
            ordersTest.add(od);
            i++;
         }
         insert ordersTest;
        
         

        Product2 pd1 = new Product2(Name = 'Chemise Verte longue XYX', Family = 'Chemise');
        insert pd1;
 
        //Create the PricebookEntry 
        PricebookEntry pbe = new PricebookEntry(
            Pricebook2Id = Test.getStandardPricebookId(),
            Product2Id = pd1.Id,
            UnitPrice = 1020,
            IsActive = true
        );
        insert pbe;
}
       @isTest
       public static CheckingOrderItemTest(){
           
       }
}