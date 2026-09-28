namespace firstapp.aspects;

using{ Currency } from'@sap/cds/common';

type Guid : UUID;
type PhnNumber:String(32);
type Email:String(225);
type Role:String(2);
type String32:String(32);
type String64:String(64);
type String255:String(255);

type Gender:String(1) enum{
    male='M';
    female='F';
    undisclosed='D';
}

type AmountT:Decimal(10,2) @(
    Semantics.amount.currencyCode:'CURRENCY_CODE',
    sap.unit:'CURRENCY_CODE'

);

aspect Amount{
    Gross_Amt:AmountT;
    Net_Amt:AmountT;
    Tax_amt:AmountT;
    CURRENCY:Currency;
}

aspect Address{
    Street:String255;
    Postal:String(12);
    City:String255;
    Country:String255;
    Building:String255;
}