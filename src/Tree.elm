module Tree exposing (..)

import Dict exposing (Dict)


type Tree v
    = Node v (List (Tree v))
    | Empty


empty : Tree v
empty =
    Empty


init : a -> Tree a
init v =
    Node v []


addChild : comparable -> Tree comparable -> Tree comparable
addChild key tree =
    case tree of
        Empty ->
            init key

        Node v children ->
            Node v (List.append children [ (Node key []) ])


map : (a -> b) -> Tree a -> Tree b
map f tree =
    case tree of
        Empty ->
            Empty

        Node key children ->
            Node (f key) (List.map (map f) children)


getKey : Tree comparable -> Maybe comparable
getKey tree =
    case tree of
        Empty ->
            Nothing

        Node v children ->
            Just v


getChildByKey : comparable -> Tree comparable -> Maybe (Tree comparable)
getChildByKey key tree =
    case tree of
        Empty ->
            Nothing

        Node v children ->
            let
                filterChildren child =
                    case child of
                        Empty ->
                            False

                        Node v children ->
                            v == key
            in
                List.filter filterChildren children
                    |> List.head
