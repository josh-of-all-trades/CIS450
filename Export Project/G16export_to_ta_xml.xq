(: XQuery main module :)
<tripster xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
    xsi:noNamespaceSchemaLocation="ta_tripster.xsd">
    {for $user in doc('G16_export.xml')/database/USERS/tuple
    return <user>
        {<login> {$user/NAME/text()} </login>}
        {<email> {$user/NAME/text()} </email>}
        {<name> {$user/NAME/text()} </name>}
        {<affiliation> {$user/AFFILIATION/text()}</affiliation>}
        {<interests> {'None'} </interests>}
        {for $f in doc('G16_export.xml')/database/FRIENDS/tuple[FRIEND_1 = $user/ID]
        return <friend> 
            {for $u in doc('G16_export.xml')/database/USERS/tuple
            where $u/ID = $f/FRIEND_2
            return $u/NAME/text()}
        </friend>}
        {for $t in doc('G16_export.xml')/database/TRIPS/tuple
        where $t/OWNER = $user/ID
        return <trip> {
            {<id> {$t/ID/text()} </id>},
            {<name> {'Trip'} </name>},
            {<feature> {'None'} </feature>},
            {<privacyFlag> {'public'} </privacyFlag>},
            {for $album in doc('G16_export.xml')/database/ALBUMS/tuple
            where $album/TRIP = $t/ID
            return <album> {
                {<id> {$album/ID/text()} </id>},
                {<name> {$album/NAME/text()} </name>},
                {<privacyFlag> {'public'} </privacyFlag>},
                {for $content in doc('G16_export.xml')/database/MEDIA/tuple,
                $in_album in doc('G16_export.xml')/database/IN_ALBUM/tuple
                where $content/ID = $in_album/MEDIA and $album/ID = $in_album/ALBUM
                return <content>{
                {<id> {$content/ID/text()} </id>},
                {<source> {'G16'} </source>},
                {<type> {if ($content/IS_VIDEO = 1) then 'video' else 'photo'} </type>},
                {<url> {$content/MEDIA_URL/text()} </url> }
                } </content>}
            } </album>},
            {for $loc in doc('G16_export.xml')/database/LOCATIONS/tuple,
            $trip_to in doc('G16_export.xml')/database/TRIP_TO/tuple
            where $trip_to/TRIP = $t/ID and $loc/ID = $trip_to/LOCATION
            return <location> {
                {<name> {$loc/NAME} </name>},
                {<type> {'default'} </type>}
            } </location> } 
        } </trip>}
        (:This is where I stopped :)
    </user>}
</tripster>
