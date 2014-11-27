for $product in doc('input.xml')/products/product
return if ($product/stores/store/markup = 25)
then <prod>{<name>$product/NAME</name>,
      <price>$product/PRICE</price>
      }</prod>
else {}