/*using{firstapp.db as database} from '../db/application'

service CatalogService{
    entity EmployeeSrv as projection on database.master.Employees;
    entity ProductSrv as projection on database.master.Products;
    entity BusinessPartnerSrv as projection on database.master.BusinessPartners;
    entity AddressSrv as projection on database.master.Addresses;

    entity PurchaseOrderSrv as projection on database.transaction.PurchaseOrders;
    entity PurchaseItemSrv as projection on database.transaction.PurchaseItems;


}*/

using { firstapp as database } from '../db/application';

using{firstapp.aspects as aspect} from'../db/aspects';


service CatalogService {

   /*@Capabilities:{
    InsertRestrictions.Insertable : true,
    UpdateRestrictions.Updatable : true,
    DeleteRestrictions.Deletable : true,
    ReadRestrictions.Readable : true
    }*/

//start projecting the entities
    entity EmployeeSrv

        as projection on database.master.Employees{
            *
        }actions{
            action increasedsalary() returns array of EmployeeSrv;

            function top20employee() returns array of EmployeeSrv;
        }


    entity ProductSrv

        as projection on database.master.Products{
            *
        }actions{
            action increasePrice() returns array of ProductSrv;

            action IncreasePrice() returns array of ProductSrv;

            function getTopProducts() returns array of ProductSrv;

            function getHighestPricedProduct() returns array of ProductSrv;
        }

    entity BusinessPartnerSrv

        as projection on database.master.BusinessPartners;


    entity AddressSrv

        as projection on database.master.Addresses;




    entity PurchaseItemSrv

        as projection on database.Transaction.PurchaseItems;
    

    entity PurchaseOrderSrv as projection on database.Transaction.PurchaseOrders {
            *
        }actions {
 
            // Declare instance bounded action
            action discountPrice() returns array of PurchaseOrderSrv;
 
            // Declare instance bounded function
            function largestOrder() returns array of PurchaseOrderSrv;
 
    };

    action createEmployee(
        
        Currency_code: String(3),
        ID:UUID,
        accountNumber: aspect.String32,
        bankId: String(16),
        bankName: aspect.String64,
        email: aspect.Email,
        gender: aspect.Gender,
        language: String(2),
        loginName: String(16),
        nameFirst: aspect.String64,
        nameInitials: aspect.String64,
        nameLast: aspect.String64,
        nameMiddle: aspect.String64,
        phoneNumber: aspect.PhnNumber,
        salaryAmount: aspect.AmountT
)


 returns array of EmployeeSrv;

    action createAddresses(
         Node_key:aspect.Guid,
        Address_type:aspect.String32,
        Val_strt:Date,
        Val_end:Date,
        Latitude:Decimal,
        Longitude:Decimal
    )
    returns array of AddressSrv;

    action updateEmployee(
        ID:UUID,
        salaryAmount:aspect.AmountT,
        Currency_code:String(3)
    )
    returns String;

    action createProducts(
        Node_key:aspect.Guid,
        Product_Id:aspect.String32,
        Type_code:String(2),
        Category:aspect.String32,
        Description:aspect.String255,
        Tax_tarif_code:Integer,
        Measure_unit:String(2),
        Weight_measure:Decimal(5, 2),
        Weight_unit:String(2),
        Price:Decimal(15,2),
        Currency_code:String(5),
        Width:Decimal(5,2),
        Depth:Decimal(5,2),
        Height:Decimal(5,2),
        Dim_unit:String(2)
    )
    returns array of ProductSrv;
    
    action updateProducts(
        Node_key:aspect.Guid,
        Currency_code:String(3),
        Price:Decimal(15,2)
    )
    returns String;

    action deleteEmployee(
        ID:UUID
        )
    returns String;

    action deleteProduct(
           Currency_code:String(5)

    );

    //function getHighestSalaryEmployee() returns array of EmployeeSrv;

    //function getHighestPricedProduct() returns array of ProductSrv;

    function getUtilities() returns String;


}

