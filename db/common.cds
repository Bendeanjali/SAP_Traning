namespace first.common;

using {Country,Currency} from '@sap/cds/common';

aspect address{
   drno:String(50);
   street:String(50);
   landmark:String(100);
   city:String(50);
   region:String(50);
   state:String(50);
   postal:Integer;
   country:Country;
}   
type AmountT : Decimal(10,2) @(
    Semantics.amount.currencyCode : 'CURRENCY_CODE',
    sap.unit : 'CURRENCY_CODE'
);

aspect fee{
    
    currency:Currency;
    gross_frr:AmountT;
    total_fee:AmountT;
    tax:AmountT;

}
Type Gender:String(20) enum{
    F='Female';
    M='Male';

}
type phnno:String(20) @assert.format: '^(?:(?:\+|00)?91[\-\s]?)?[6-9]\d{9}$';

