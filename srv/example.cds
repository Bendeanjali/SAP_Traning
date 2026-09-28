/*using{firstapp.db  as database} from '../db/example';
 

service Examples{
    entity CustomerSrv
        as projection on database.Customer;

        entity OrderSrv
        as projection on database.Order;

        entity OrderItemSrv
        as projection on database.OrderItem;

        entity ProductSrv 
        as projection on database.Product;

        action createCustomer(
            CustomerID :UUID,
            Name:String(30),
            City:String(10)

        )
        returns array of CustomerSrv;
        action createOrder(
            orders:many OrderSrv

        )

        returns many  OrderSrv;
        action createOrderItem(
            ItemID:Integer,
            Quantity:Integer

        )
        returns array of OrderItemSrv;

        action createProduct(
            ProductID :UUID,
            ProductName:String(10),
            Price:Integer
        )
        returns array of ProductSrv;

    action updateOrder(
            OrderID:UUID,
            OrderDate:Date

        )returns String;
    action deleteOrderItem(
        ItemID:UUID
       
    )
    returns String;


}*/