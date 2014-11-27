{let $root := doc("../project_data.xml")/tripster
 return <database>
     <users>
        {for $user at $pos in $root/user
         return <tuple>
            <id>{$pos}</id>
            <pwd>password</pwd>
            <name>{$user/name/text()}</name>
            <affiliation>{$user/affiliation/text()}</affiliation>
         </tuple>}
     </users>
     
     <friends>
        {for $user at $pos1 in $root/user
         for $friend at $pos2 in $root/user
         for $friendship in $root/user[login/text() = $user/login/text()]/friend[text() = $friend/login/text()]
         return <tuple>
            <friend_1>{$pos1}</friend_1>
            <friend_2>{$pos2}</friend_2>
         </tuple>
        }
     </friends>
     
     <locations>
         {for $loc at $pos in fn:distinct-values($root/user/trip/location/name/text())
         return <tuple>
            <id>{$pos}</id>
            <name>{$loc}</name>
         </tuple>}
     </locations>
     
     <items></items>
     
     <item_lists></item_lists>
     
     <for_trip></for_trip>
     
     <in_list></in_list>
     
     <dreams>
        {for $user at $u_pos in $root/user/login/text()
         for $dream in $root/user[login/text() = $user]/dream/text()
         for $loc at $l_pos in fn:distinct-values($root/user/trip/location/name/text())
         where $loc = $dream
         return <tuple>
            <dreamer>{$u_pos}</dreamer>
            <location>{$l_pos}</location>
            <rank>1</rank>
         </tuple>
        }
     </dreams>
     
     <trips>
        {for $user at $pos in $root/user/login/text()
         for $trip in fn:distinct-values($root/user[login/text() = $user]/trip/id/text())
         return <tuple>
            <id>{$trip}</id>
            <owner>{$pos}</owner>

         </tuple> 
        }
     </trips>
     
     <albums>
        {for $user in $root/user/login/text()
         for $trip in $root/user[login/text() = $user]/trip
         for $id in fn:distinct-values($root/user/trip[id/text() = $trip/id/text()]/id/text())
         for $album in $root/user/trip[text() = $trip/id/text()]/album
         return <tuple>
            <id>{$album/id/text()}</id>
            <trip>{$id}</trip>
            <name>{$trip/name/text()}</name>
            <owner>{$user}</owner>
         </tuple>
        }
     </albums>
     
     <media>
        {for $user at $pos in $root/user/login/text()
         for $media in $root/user[login/text() = $user]/trip/album/content
         return <tuple>
            <id>{$media/id/text()}</id>
            <owner>{$pos}</owner>
            <media_url>{$media/url/text()}</media_url>
            <is_video>{if ($media/type/text() = 'video') then 1 else 0}</is_video>
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
        {for $user at $u_pos in $root/user/login/text()
         for $invittee at $i_pos in $root/user/login/text()
         for $invite in $root/user[login/text() = $user]/invite
         where $invite/friendid/text() = $invittee
         return <tuple>
            <status>{$invite/status/text()}</status>
            <inviter>{$u_pos}</inviter>
            <invitee>{$i_pos}</invitee>
            <trip>{$invite/tripid/text()}</trip>
         </tuple>
        }
     </participate_trip>
     
     <trip_to>
         {for $trip in $root/user/trip/id/text()
          for $loc at $pos in $root/user/trip[id/text() = $trip]/location/name/text()
          return <tuple>
            <location>{$pos}</location>
            <trip>{$trip}</trip>
         </tuple>
         }
     </trip_to>
     
     <rate_media>
        {for $user at $pos in $root/user/login/text()
         for $rating in $root/user[login/text() = $user]/rateContent
         return <tuple>
            <media>{$rating/contentid/text()}</media>
            <rater>{$pos}</rater>
            <rating>{if ($rating/score/text() > 5) then 1 else $rating/score/text()}</rating>
         </tuple>
        }
     </rate_media>
     
     <comment_media>
        {for $user at $pos in $root/user/login/text()
         for $media in $root/user[login/text() = $user]/rateContent/contentid/text()
         for $comment in $root/user[login/text() = $user]/rateContent[contentid/text() = $media]/comment/text()
         where $comment != 'NULL' and $comment != 'null'
         return <tuple>
            <media>{$media}</media>
            <commenter>{$pos}</commenter>
            <media_comment>{$comment}</media_comment>
         </tuple>
        }
     </comment_media>
     
     <rate_trip>
        {for $user at $pos in $root/user/login/text()
         for $rating in $root/user[login/text() = $user]/rateTrip
         return <tuple>
            <trip>{$rating/tripid/text()}</trip>
            <rater>{$pos}</rater>
            <rating>{if ($rating/score/text() > 5) then 1 else $rating/score/text()}</rating>
         </tuple>
        }
     </rate_trip>
     
     <comment_trip>
        {for $user at $pos in $root/user/login/text()
         for $trip in $root/user[login/text() = $user]/rateTrip/tripid/text()
         for $comment in $root/user[login/text() = $user]/rateTrip[tripid/text() = $trip]/comment/text()
         where $comment != 'NULL' and $comment != 'null'
         return <tuple>
            <trip>{$trip}</trip>
            <commenter>{$pos}</commenter>
            <trip_comment>{$comment}</trip_comment>
         </tuple>
        }
     </comment_trip>
     
 </database>
 }
