/*namespace firstapp;

entity Photo{
    key Id:Integer;
    //AlbumId:Integer;
    //LocationId:Integer;
    Title:String(120);
    Description:String(255);
    Privacy:String(20);
    UploadDate:Date;
    View:Integer;
    ImagePath:String(50);
    comments:Composition of many Comment on comments.photo=$self;

    album:Association to one Album; // A single photo belongs to one album.
    loc:Association to one Location; //A single photo belongs to one loc.
    mem:Association to one Member; //A single photo belongs to one mem .
    comment : Association to many Comment on comment.photo = $self; // A photo can have many comments.
    tagPhotos : Association to many TagPhoto on tagPhotos.photo = $self; //A photo can have many tags.

}




entity Album{
    key Id:Integer;
    Title:String(120);
    Description:String(255);
    View:Integer;
    photos:Association to  many Photo on photos.album=$self; // One Album → Many Photos
}

entity Location{
    key Id:Integer;
    Name:String(200);
    Shortname:String(50);
    photos:Association to many Photo on photos.loc=$self; //One location can have many photos.
}

entity Tag{
    key Id:Integer;
    Title:String(120);
    photos:Association to  many TagPhoto on photos.tag=$self; // 
} 

entity TagPhoto{
    key Id:Integer;
    tag:Association to Tag;
    photo:Association to Photo;

}

entity Comment{
    Id:Integer;
    PhotoId:Integer;
    PostDate:Date;
    Content:String(255);
    photo : Association to one Photo;
    }

entity Member{
    key Id:Integer;
    Name:String(256);
    PhotoName:String(20);
    Email:String(200);
    Address:String(255);
    photos:Association to many Photo on photos.mem=$self; // One member can upload many photos.
}
*/