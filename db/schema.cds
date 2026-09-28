/*namespace firstapp;

type ![Employeename] :String(50); // identifier
// type namstr:String(100);
using { first.common as common  } from './common';

using {managed,temporal} from '@sap/cds/common';

// Example1
entity Stud: common.address,common.fee,managed,temporal{
    key StudentId:Integer;
    StudentName:String(50);
    FatherName:String(50);
    MotherName:String(50);
    Phoneno:String(20);
    Gender:common.Gender;
    
}

entity Students {
    key StudentId:Integer;
    StudentName:String(50);
    FatherName:String(50);
    MotherName:String(50);
    Phoneno:String(20);
    
    abc:Association to one Classes;
    

}
 /*entity Classes:managed,temporal{
    key ClassId:Integer;
    ClassName:String(50);
    TeacherName:String(50);
 }*//*
 entity Classes : managed, temporal {
    key ClassId : Integer;
    ClassName : String(50);
    TeacherName : String(50);

}
//Example2
entity Student2{
    key StudentId:Integer;
    StudentName:String(50);
    FatherName:String(50);
    MotherName:String(50);
    Phoneno:String(20);
    Fee:Decimal;
    Currency:String(10);
    City:String(50);
    Country:String(50);
    book:Association to many libraries on book.parent = $self;

}
 entity libraries{
   key BookId:Integer;
   Bookname:String(50);
   AuthorName:String(50);
   Issuedate:Date;
   Returndate:Date;
   price:Integer;
   count:Integer;
   parent :Association to Student2;
 }

//Example3
 entity Employees{
    key employeeId:Integer;
    employeeName:String(50);
    salary:String(10);
    department:String(50);
    currencyCode:String(100);
    city:String(100);
    country:String(100);
    division:Association to one Divisions;
 
 
 }
 entity Divisions{
    key divisionId:Integer;
    divisionName:String(100);
    city:String(100);
    country:String(100);
 }
 //Example4

 entity Studentdetails{
   key Studid:Integer;
   StudentName:String(50);
   Totalmark:Decimal;
   mark:Association to one Student2;

 }



 */