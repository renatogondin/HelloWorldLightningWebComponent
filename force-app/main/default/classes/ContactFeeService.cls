public with sharing class ContactFeeService {

    @auraEnabled(cacheable=true)
    public static List<MetaContactDetailsObject> getContactCostsByAccount(String accountId){
        List<MetaContactDetailsObject> records = new List<MetaContactDetailsObject>();
        Contact contact = [SELECT Id, Name, Product__c, Home_Country__c FROM Contact WHERE AccountId = :accountId LIMIT 1];
        MetaContactDetailsObject record = new MetaContactDetailsObject();
        record.Id = contact.Id;
        record.name = contact.Name;
        record.calendar = getCalendarMonthValue(contact.Product__c, contact.Home_Country__c);
        record.fee = getFeeinOtherCurrenciesValue(contact.Product__c, contact.Home_Country__c);
        record.card = getCardReplacementValue(contact.Product__c, contact.Home_Country__c);
        records.add(record);
        return records;
    }

    //btw: querying against metadata without textArea fields won't bother to SOQL limits but only rows counting

    public static String getCalendarMonthValue(String product, String homeCountry){
        List<Cost_Per_Calendar_Month__mdt> records = [SELECT Id, Value__c FROM Cost_Per_Calendar_Month__mdt WHERE Type__c = :product AND Country__c = :homeCountry];
        return records[0].Value__c;
    }

    public static String getFeeinOtherCurrenciesValue(String product, String homeCountry){
        List<ATM_Fee_in_Other_Currencies__mdt> records = [SELECT Id, Value__c FROM ATM_Fee_in_Other_Currencies__mdt WHERE Type__c = :product AND Country__c = :homeCountry];
        return records[0].Value__c;
    }

    public static String getCardReplacementValue(String product, String homeCountry){
        List<Card_Replacement_Cost__mdt> records = [SELECT Id, Value__c FROM Card_Replacement_Cost__mdt WHERE Type__c = :product AND Country__c = :homeCountry];
        return records[0].Value__c;
    }

    public class MetaContactDetailsObject{
        @auraEnabled
        public String Id;
        @AuraEnabled
        public String name;
        @auraEnabled
        public String calendar;
        @auraEnabled
        public String fee;
        @auraEnabled
        public String card;
    }
}