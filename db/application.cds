namespace firstapp;

using{ cuid,Currency } from '@sap/cds/common';

using{firstapp.aspects as aspect} from'./aspects';

context master{
    entity BusinessPartners{
        key Node_key:aspect.Guid;
        Bp_Role:aspect.Role;
        Email:aspect.Email;
        Mobile:aspect.PhnNumber;
        Fax:aspect.String32;
        Web:aspect.String255;
        Bp_Id:aspect.Guid;
        Company_name:aspect.String255;
        AD:Association to  Addresses;

    }

    entity Addresses:aspect.Address{
        key Node_key:aspect.Guid;
        Address_type:aspect.String32;
        Val_strt:Date;
        Val_end:Date;
        Latitude:Decimal;
        Longitude:Decimal;
        BP:Association to one BusinessPartners on BP.AD=$self;
    }

    entity Products{
        key Node_key:aspect.Guid;
        Product_Id:aspect.String32;
        Type_code:String(2);
        Category:aspect.String32;
        Description:aspect.String255;
        Tax_tarif_code:Integer;
        Measure_unit:String(2);
        Weight_measure:Decimal(5, 2);
        Weight_unit:String(2);
        Price:Decimal(15,2);
        Currency_code:String(5);
        Width:Decimal(5,2);
        Depth:Decimal(5,2);
        Height:Decimal(5,2);
        Dim_unit:String(2);
        Suppliers:Association to BusinessPartners;
    }   
    entity Employees:cuid{
        Firstn:aspect.String64;
        Lastn:aspect.String64;
        nameInitials  : aspect.String64;
        nameMiddle    : aspect.String64;
        gender        : aspect.Gender;
        language      : String(2);
        loginName     : String(16);
        phoneNumber   : aspect.PhnNumber;
        email         : aspect.Email;
        Currency      : Currency;
        salaryAmount  : aspect.AmountT;
        accountNumber :aspect.String32;
        bankId        : String(16);
        bankName      : aspect.String64;

    }



}

context Transaction {
 
    entity PurchaseOrders : aspect.Amount {
        key Node_key         : aspect.Guid;
            PO_ID            : aspect.Guid;
 
            // Managed Association
            Partner      : Association to master.BusinessPartners;
            Lifecycle : String(1);
            Overall   : String(1);
            Items            : Association to many PurchaseItems
                                   on Items.Parent = $self;
    }
 
    entity PurchaseItems : aspect.Amount {
        key Node_key    : aspect.Guid;
 
            Parent     : Association to PurchaseOrders;
 
            Po_Item : Integer;
            Product   : Association to master.Products;
    }
 
}
