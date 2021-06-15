@isTest
public with sharing class TestCheckingOrderRelatedList {
    @TestSetup static void makeData(){
         List<Account> accountsTest = new List<Account>();
         List<Order> ordersTest = new List<Order>();
        
         List<OrderItem> orderItems = new List<OrderItem>();
         for(integer i=0;i<10;i++){
            Account acc1 = new Account(Name = 'Test Account ' + i );
            accountsTest.add(acc1);
         }
        
        insert accountsTest;
        List<Contract> contractTest = new List<Contract>();
      integer i = 0 ;
      for(Account acc : [SELECT Id FROM Account]){
        Contract cnt = new Contract(Name ='testContract'+ i,AccountId = acc.Id, StartDate= Date.newInstance(2016, 06, 20),ContractTerm= 30,Status='Draft');
       contractTest.add(cnt);
        i++;
     }
     insert contractTest;
     
        for(Contract acc : [SELECT Id , AccountId FROM Contract]){
            
            Order od = new Order(Name = 'order n ' + i ,EndDate = Date.newInstance(2017, 06, 20),AccountId = acc.AccountId, Status='draft', EffectiveDate= Date.newInstance(2017, 03, 20),  Pricebook2Id = Test.getStandardPricebookId(), ContractId = acc.Id);
           
             ordersTest.add(od);
            i++;
         }
         insert ordersTest;

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
// assertbfn
    System.assert(result.getErrors().size() == 1);
    Order oc = [SELECT id,Status, (SELECT id FROM OrderItems) FROM Order Limit 1];
        System.assertEquals('Draft', oc.Status);
        
      
       }
}