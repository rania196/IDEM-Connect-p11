global with sharing class BatchProcessAcc implements Database.Batchable<sObject> {
    
        global Database.QueryLocator start(Database.BatchableContext BC) {
                // collect the batches of records or objects to be passed to execute
                
String query = 'SELECT Id,OwnerId ,(SELECT OwnerId,WhatId,Priority,Status,Subject FROM Tasks),(SELECT Id FROM Orders) FROM Account';
                return Database.getQueryLocator(query);
            }
            
            global void execute(Database.BatchableContext BC, List<Account> accList) {
               
                // process each batch of records
                CheckingOrderAndAccountFields.checkAccountRelatedList(accList);
            }   
            
            global void finish(Database.BatchableContext BC) {
                    // execute any post-processing operations
          }
        }