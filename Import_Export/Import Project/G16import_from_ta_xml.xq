{let $root := doc("../project_data.xml")/tripster
 return <database>
     <users>
        {for $user in $root/user 
         return <tuple>
            <id></id>
            <pwd>{$user/login/text()}</pwd>
            <name>{$user/name/text()}</name>
            <affiliation>{$user/affiliation/text()}</affiliation>
            <join_date></join_date>
         </tuple>}
     </users>
     
     <friends>
        {for $user in $root/user/login/text()
         for $friend in $root/user[login/text() = $user]/friend/text()
         return <tuple>
            <friend_1>{$user}</friend_1>
            <friend_2>{$friend}</friend_2>
            <friend_date></friend_date>
         </tuple>
        }
     </friends>
     
     <locations>
         {for $loc in fn:distinct-values($root/user/trip/location/name/text())
         return <tuple>
            <id></id>
            <name>{$loc}</name>
         </tuple>}
     </locations>
     
     <items></items>
     
     <item_lists></item_lists>
     
     <for_trip></for_trip>
     
     <in_list></in_list>
     
     <dreams>
        {for $user in $root/user/login/text()
         for $dream in $root/user[login/text() = $user]/dream/text()
         return <tuple>
            <dreamer>{$user}</dreamer>
            <location>{$dream}</location>
            <rank></rank>
            <dream_date></dream_date>
         </tuple>
        }
     </dreams>
     
     <trips>
        {for $trip in $root/user/trip
         return <tuple>
            <id>{$trip/id/text()}</id>
            <owner></owner>
            <start_date></start_date>
            <end_date></end_date>
         </tuple> 
        }
     </trips>
     
     <albums>
        {for $trip in $root/user/trip/text()
         for $album in $root/user/trip[text() = $trip]/album
         return <tuple>
            <id>{$album/id/text()}</id>
            <trip>{$trip}</trip>
            <name>{$trip/name/text()}</name>
            <owner></owner>
            <start_date></start_date>
            <end_date></end_date>
         </tuple>
        }
     </albums>
     
     <media>
        {for $media in $root/user/trip/album/content
         return <tuple>
            <id>{$media/id/text()}</id>
            <owner></owner>
            <media_url>{$media/url/text()}</media_url>
            <is_video>{if ($media/type/text() = 'video') then 1 else 0}</is_video>
            <upload_date></upload_date>
         </tuple>
        }
     </media>
     
     <in_album>
        {for $album in $root/user/trip/album/id/text()
         for $media in $root/user/trip/album[id/text() = $album]/content/id/text()
         return <tuple>
            <album>{$album}</album>
            <media>{$media}</media>
         </tuple>}
     </in_album>
     
     <participate_trip>
        {for $user in $root/user/login/text()
         for $invite in $root/user[login/text() = $user]/invite
         return <tuple>
            <status>{$invite/status/text()}</status>
            <inviter>{$user}</inviter>
            <invitee>{$invite/friendid/text()}</invitee>
            <trip>{$invite/tripid/text()}</trip>
         </tuple>
        }
     </participate_trip>
     
     <trip_to>
         {for $trip in $root/user/trip/id/text()
          for $loc in $root/user/trip[id/text() = $trip]/location/name/text()
          return <tuple>
            <location>{$loc}</location>
            <trip>{$trip}</trip>
         </tuple>}
     </trip_to>
     
     <rate_media>
        {for $user in $root/user/login/text()
         for $rating in $root/user[login/text() = $user]/rateContent
         return <tuple>
            <media>{$rating/contentid/text()}</media>
            <rater>{$user}</rater>
            <rating>{$rating/score/text()}</rating>
         </tuple>
        }
     </rate_media>
     
     <comment_media>
        {for $user in $root/user/login/text()
         for $media in $root/user[login/text() = $user]/rateContent/contentid/text()
         for $comment in $root/user[login/text() = $user]/rateContent[contentid/text() = $media]/comment/text()
         return <tuple>
            <media>{$media}</media>
            <commenter>{$user}</commenter>
            <media_comment>{$comment}</media_comment>
         </tuple>
        }
     </comment_media>
     
     <rate_trip>
        {for $user in $root/user/login/text()
         for $rating in $root/user[login/text() = $user]/rateTrip
         return <tuple>
            <trip>{$rating/tripid/text()}</trip>
            <rater>{$user}</rater>
            <rating>{$rating/score/text()}</rating>
         </tuple>
        }
     </rate_trip>
     
     <comment_trip>
        {for $user in $root/user/login/text()
         for $trip in $root/user[login/text() = $user]/rateTrip/tripid/text()
         for $comment in $root/user[login/text() = $user]/rateTrip[tripid/text() = $trip]/comment/text()
         return <tuple>
            <trip>{$trip}</trip>
            <commenter>{$user}</commenter>
            <trip_comment>{$comment}</trip_comment>
         </tuple>
        }
     </comment_trip>
     
 </database>
 }
