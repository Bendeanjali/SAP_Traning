const cds=require('@sap/cds');
const {uuid,exists,decodeURI,isdir,read}=cds.utils;
const { mkdirp } = require('@sap/cds/lib/utils/cds-utils');
//const {uuid,exists,decodeURI,isdir,read}=cds.utils;

module.exports = cds.service.impl(async function () {

    const { EmployeeSrv } = this.entities;
    const { AddressSrv } = this.entities;
    const{ ProductSrv } = this.entities;
    const { PurchaseOrderSrv, BusinessPartnerSrv,PurchaseItemSrv } = this.entities;
    // Implementation of an action
    // There are 3 generic handlers
    // .before() : Pre-check and validation
    // .on() : Performing DB operations
    // .after() : To save / close connections
    this.before('UPDATE',EmployeeSrv,async(request,response) =>{
        const salaryAmount=request.data.salaryAmount;
        if(salaryAmount >100000){
            request.error(500,'Please get the approval from your line manager');
        }

    })
    this.before('UPDATE', PurchaseOrderSrv, async (req) => {

        const grossAmt = req.data.Gross_Amt;
        const currency = req.data.CURRENCY_code;

        if (currency === 'USD' && grossAmt > 15000) {
        req.error(400, 'Please contact your Line Manager.');
        }
        if (currency === 'EUR' && grossAmt > 10000) {
            req.error(400, 'Please contact your Regional Head.');
        }

        });

    this.before('UPDATE', 'EmployeeSrv', async (req) => {

    const mobile = req.data.phoneNumber;

    if (mobile) {

        const isValidCountryCode =
            mobile.startsWith('+1') || 
            mobile.startsWith('+44');    

        if (!isValidCountryCode) {
            req.error(
                400,
                'We cannot update the mobile number. Only US and GB country codes are allowed.'
            );
        }
    }
    });

    this.before('UPDATE', 'BusinessPartnerSrv', async (req) => {

    const companyName = req.data.Company_name;

    if (companyName && /[.,-]/.test(companyName)) {
        req.error(
            400,
            'Invalid company name'
        );
    }

});
this.before('UPDATE', 'PurchaseItemSrv', async (req) => {

    const position = req.data.Po_Item; // or po_Items_position

    if (position !== undefined) {

        // Check if numeric
        if (isNaN(position)) {
            return req.reject(
                400,
                'Item position must be a number and should be a multiple of 10.'
            );
        }

        // Check multiple of 10
        if (Number(position) % 10 !== 0) {
            return req.reject(
                400,
                'Item position must be a number and should be a multiple of 10.'
            );
        }
    }
});

    
    this.on("createEmployee", async (request, response) => {

        // Step - 2 : Get the data which is coming from the API
        const empData = request.data;

        // Step - 3 : Instantiate the transaction object
        const objTransaction = cds.tx(request);

        // Step - 4 : Insert the record into database
        let returnData = await objTransaction.run([
            INSERT.into(EmployeeSrv).entries(empData)
        ]).then((resolve, reject) => {
            if (typeof(resolve) !== undefined) {
                return request.data;
            } else {
                request.error(500, "Error in inserting data into the database");
            }
        }).catch(err => {
            request.error("There is an error : ", err.toString());
        })

        // Step - 5 : Return the data
        return returnData;
    }),

    this.on("createAddresses", async (request, response) => {

        // Step - 2 : Get the data which is coming from the API
        const empData = request.data;

        // Step - 3 : Instantiate the transaction object
        const objTransaction = cds.tx(request);

        // Step - 4 : Insert the record into database
        let returnData = await objTransaction.run([


            INSERT.into(AddressSrv).entries(empData)
        ]).then((resolve, reject) => {
            if (typeof(resolve) !== undefined) {
                return request.data;
            } else {
                request.error(500, "Error in inserting data into the database");
            }
        }).catch(err => {
            request.error("There is an error : ", err.toString());
        })

        // Step - 5 : Return the data
        return empData;
    })
    this.on("updateEmployee", async (request, response) => {
    const {
         Node_key,
        salaryAmount,
        Price
    } = request.data;

    try {
        const objTransaction = cds.tx(request);

        await objTransaction.update(EmployeeSrv).with({
            salaryAmount: salaryAmount,
            Currency_code: Currency_code
        }).where({
            ID: ID
        });

        return "Successfully updated.";
    } catch (error) {
        request.error("Error : ", error)
    }
    })
     this.on("createProducts", async (request, response) => {

        // Step - 2 : Get the data which is coming from the API
        const proData = request.data;

        // Step - 3 : Instantiate the transaction object
        const objTransaction = cds.tx(request);

        // Step - 4 : Insert the record into database
        let returnData = await objTransaction.run([
            INSERT.into(ProductSrv).entries(proData)
        ]).then((resolve, reject) => {
            if (typeof(resolve) !== undefined) {
                return request.data;
            } else {
                request.error(500, "Error in inserting data into the database");
            }
        }).catch(err => {
            request.error("There is an error : ", err.toString());
        })

        // Step - 5 : Return the data
        return returnData;
    })
    this.on("updateProducts", async (request, response) => {
    const {
        Node_key,
        Currency_code,
        Price
    } = request.data;

    try {
        const objTransaction = cds.tx(request);

        await objTransaction.update(ProductSrv).with({
             Currency_code:  Currency_code,
            Price: Price
        }).where({
            Node_key: Node_key
        });

        return "Successfully updated.";
    } catch (error) {
    console.error("Full Error:", error);
    request.reject(500, error.message);
}
    })

    this.on('deleteEmployee', async (request, response) => {
    const {
        ID
    } = request.data;
    try {
        const objTransaction = cds.tx(request);
        await objTransaction.delete(EmployeeSrv).where({
            ID: ID

        })
        return "Successfully deleted.";

    } catch (error) {
        request.error("Error : ", error);

    }

})
this.on('getHighestSalaryEmployee',async (req,res) => {
    try{
        const tran=cds.tx(req);
        const response=await tran.read(EmployeeSrv).orderBy({
            salaryAmount:'desc'
        }).limit(10);
        return response;
    }
    catch(error){
        req.error("Error",error);
    }
    
})

this.on('getHighestPricedProduct',async (req,res) => {
    try{
        const tran=cds.tx(req);
        const response=await tran.read(ProductSrv).orderBy({
            Price:'desc'
        }).limit(10);
        return response;
    }
    catch(error){
        req.error("Error",error);
    }
    
})

this.on('discountPrice', async(request, response) => {
 
    try {
 
        // Step-1 : Get the parameter form the entity
        const ID = request.params[0];
 
        // Step-2 : Creating object for transaction service using request
        const transaction = cds.tx(request);
 
        // Step-3 : Update the purchase order service
        await transaction.update(PurchaseOrderSrv).with({
            Gross_Amt : {
                '-=' : 1000
            },
           Net_Amt : {
                '-=' : 800
            },
            Tax_amt : {
                '-=' : 200
            }
        }).where(ID)
 
        const updatePOInfo = await transaction.read(PurchaseOrderSrv);
 
        return updatePOInfo;
 
    } catch (error) {
        return "Error : " + error.toString();
    }
 
});
 
this.on('largestOrder',async(req,res)=>{
    try{
        const tran=cds.tx(req);

        const rep=await tran.read(PurchaseOrderSrv).orderBy({
           Gross_Amt:'desc'
        }).limit(5);
            return rep;
    }
    catch(error){
        return "Error"+error.toString();
    }
});
    this.on('increasePrice',async(req)=>{
        try{
            const ID=req.params[0];
            const tran=cds.tx(req);
            await tran.update(ProductSrv).with({
                Price:{
                    '*=':1.10
                }
            }).where(ID);
            return await tran.read(ProductSrv);
        }
            catch(error){
                return "Error"+error.toString();
            }
        
    });

    this.on('getTopProducts',async(req)=> {
        try{
            const tran=cds.tx(req);
            const prod=await tran.read(ProductSrv).orderBy({
                Price:'desc'
            }).limit(5);

            return prod;
        }
        catch(error){
            req.error("Error:",error);
        }
    })

    this.on('IncreasePrice', async (req) => {
    try {

        const key = req.params[0];
        const txn = cds.tx(req);

        const pro = await txn.run(
            SELECT.one
                .from(ProductSrv)
                .where(key)
        );

        const curr = Number(pro.Price);
        const newPrice = Number((curr * 2).toFixed(2));

        await txn.update(ProductSrv)
            .with({
                Price: newPrice
            })
            .where(key);

        const upd = await txn.read(ProductSrv)
            .where(key);

        return upd;

    } catch (error) {
        return "Error: " + error.toString();
    }
});


 this.on('increasedsalary',async(req)=>{
        try{
            const ID=req.params[0];
            const tran=cds.tx(req);
            await tran.update(EmployeeSrv).with({
                salaryAmount:{
                    '*=':1.15
                }
            }).where(ID);
            return await tran.read(EmployeeSrv);
        }
            catch(error){
                return "Error"+error.toString();
            }
        
    });
        this.on('top20employee',async(req)=> {
        try{
            const tran=cds.tx(req);
            const salary=await tran.read(EmployeeSrv).orderBy({
                salaryAmount:'desc'
            }).limit(5);

            return salary;
        }
        catch(error){
            req.error("Error:",error);
        }
    })

    const { uuid, exists, decodeURI, isdir, mkdirp } = cds.utils;

this.on('getUtilities', async (req) => {

    let vUUID = uuid(),
        vpackageContent = null,
        vInput = "%3525#",
        uri,
        dirExists = false,
        isFileExists = false;

    if (await exists('srv/request.http')) {
        isFileExists = true;
    }

    if (await isdir('app')) {
        dirExists = true;
    }

    try {
        uri = decodeURI(vInput);
        await mkdirp('srv/lib');
    } catch (err) {
        uri = vInput;
    }

    vpackageContent = await cds.utils.read('package.json');

    return {
        uuid: vUUID,
        uri: uri,
        isFileExists: isFileExists,
        dirExists: dirExists,
        packageInfo: vpackageContent
    };
});
    
    
})
