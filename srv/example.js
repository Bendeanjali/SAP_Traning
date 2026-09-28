/*const cds = require('@sap/cds');

module.exports = cds.service.impl(async function () {

    const { CustomerSrv, OrderSrv, OrderItemSrv, ProductSrv } = this.entities;

    this.on("createCustomer", async (req) => {

        const custData = req.data;
        try {      
            const conn=cds.tx(req);
            await conn.insert(custData).into(CustomerSrv);
            return custData;
        } catch (error) {
            req.error("error",error);

        }

    });

    this.on("createOrder", async (req) => {

        const orders = req.data;
        try {      
            const conn=cds.tx(req);
            await conn.insert(orders).into(OrderSrv);
            return orders;
        } catch (error) {
            req.error("error",error);

        }

    });
    this.on("createOrderItem",async (req) => {
        const ordiData=req.data;
        try{
            const conn=cds.tx(req);
            await conn.insert(ordiData).into(OrderItemSrv);
            return ordiData;
        }
        catch(error){
            req.error("error",error);
        }
        
    })

    this.on("updateOrder",async (req) => {
        const {
            OrderID,
            OrderDate
        }=req.data;

        try{
            const conn=cds.tx(req);
            await conn.update(OrderSrv).with({
                OrderDate : OrderDate
            }).where({OrderID:OrderID})
            return "Successfully Upadted";
        }
        catch(error){
            req.error("error",error);
        }

        
    })


    this.on('deleteOrderItem',async (req) => {
        const {ItemID}=req.data;
        try{
            const tran=cds.tx(req);
            await tran.delete(OrderItemSrv).where({ItemID:ItemID});
            return "Sucessfully Deleted "
        }
        catch(error){
        console.error(error);
        req.error(500, error.message);
}
        
    })
})

*/

/*module.exports =cds.service.impl(async function() {
    const { productsrv} = this.entities;
    this.on('addproducts', async(request,Response)=>{
        const prodata = request.data;
        try{
        const conn =cds.tx(request);
        await conn.insert(prodata).into(productsrv);
        return prodata;
        }
        catch(error)
        {
            request.error("error",error);
        }
 
    })
 
   
})*/