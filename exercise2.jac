obj Rectangle{
has height:float;
has width:float;

#calculating area and perimerter of a rectangle
 def calculation () {
    area = self.height * self.width;
    perimeter = 2 * (self.height * self.width);

    print(f" The Area of the rectangle is: {area}");
    print(f" The Perimeter of the rectangel is:{perimeter}");

 }


}

with entry{
rect_object = Rectangle(width = 20, height = 10);
rect_object.calculation();



}