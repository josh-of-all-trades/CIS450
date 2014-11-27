(: XQuery main module :)
<products>
    {for $product in doc('input.xml')/database/PRODUCTS/row
    return <product>
        {<name>{$product/NAME/text()}</name>}
        {<price>{$product/PRICE/text()}</price>}
        {<desc>{$product/DESC/text()}</desc>}
        {for $store in doc('JoshRojasCIS450HW4_1.xml')/database/STORES/row
        return <store>
            attribute name
            {for $sells in doc('JoshRojasCIS450HW4_1.xml')/database/SELLS/row
                where $sells/SID = $store/SID and $sells/PID = $product/PID
                    return $store/NAME}
            attribute phone
            {for $sells in doc('JoshRojasCIS450HW4_1.xml')/database/SELLS/row
                where $sells/SID = $store/SID and $sells/PID = $product/PID
                    return $store/PHONES}
           attribute markup
           {for $sells in doc('JoshRojasCIS450HW4_1.xml')/database/SELLS/row
                where $sells/SID = $store/SID and $sells/PID = $product/PID
                    return $store/MARKUP}
        </store>}
    </product>}

</products>

.