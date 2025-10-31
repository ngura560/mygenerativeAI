obj Rectangle {
has width: float;
has height: float;



}

obj Area(Rectangle){
    def area (){
     result = self.width * self.height;

    print(f" The area is {result}");
    }
   
}

obj Perimeter(Rectangle){
    def perimeter (){
        result = 2 *(self.width + self.height);
    print(f" The perimeter is {result}");
    }
   
}
with entry{

rect_object= Rectangle (8.0,5.0);
rect_object.width = 8.0;
rect_object.height = 5.0;

  # Create Area and Perimeter objects that inherit from Rectangle
area_object = Area(rect_object.width, rect_object.height);
area_object.width = rect_object.width;
area_object.height = rect_object.height;
area_object.area();

peri_object = Perimeter(rect_object.width, rect_object.height);
peri_object.width = rect_object.width;
peri_object.height = rect_object.height;
peri_object.perimeter();

}