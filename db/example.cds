/*namespace firstapp.db;



entity Customer{
    key CustomerID :UUID;
    Name:String(30);
    City:String(10);
    orders:Association to many Order on orders.customers=$self;

}

entity Order{
    key OrderID :Integer;   
    OrderDate:Date;
    customers:Association  to one Customer;
    orderitems:Association to many OrderItem on orderitems.order=$self;
    //key CustomerID:Integer;

}

entity OrderItem{
    key ItemID:UUID;
    Quantity:Integer;
    order:Association to one Order;
    products:Association to one Product;

}

entity Product{

    key ProductID :UUID;
    ProductName:String(10);
    Price:Integer;
    orderitems:Association to many OrderItem on orderitems.products=$self;

}*/