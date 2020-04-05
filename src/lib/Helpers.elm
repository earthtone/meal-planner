module Helpers exposing (addToList, removeFromList, updateListItem)


type alias Index =
    Int


addToList : a -> List a -> List a
addToList item list =
    list ++ [ item ]


removeFromList : Index -> List a -> List a
removeFromList index list =
    let
        before n =
            List.take n list

        after n =
            List.drop (n + 1) list
    in
    before index ++ after index


updateListItem : Index -> a -> List a -> List a
updateListItem index item list =
    let
        before n =
            List.take n list

        after n =
            List.drop (n + 1) list
    in
    before index ++ [ item ] ++ after index
