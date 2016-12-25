module Tree exposing (..)

import Dict exposing (Dict)


type Tree v
    = Node v (List (Tree v))
    | Leaf v
    | Empty


empty : Tree v
empty =
    Empty


init : a -> Tree a
init v =
    Leaf v


addChild : a -> Tree a -> Tree a
addChild key tree =
    case tree of
        Empty ->
            init key

        Leaf v ->
            Node v [ init key ]

        Node v children ->
            Node v (List.append children [ (init key) ])


addChildTree : Tree a -> Tree a -> Tree a
addChildTree subTree tree =
    case tree of
        Empty ->
            subTree

        Leaf v ->
            Node v [ subTree ]

        Node key children ->
            Node key (subTree :: children)


removeChild : a -> Tree a -> Tree a
removeChild key tree =
    case tree of
        Empty ->
            Empty

        Leaf v ->
            Leaf v

        Node v children ->
            let
                filterChildren child =
                    case child of
                        Empty ->
                            False

                        Leaf v ->
                            v /= key

                        Node v children ->
                            v /= key
            in
                Node v (List.filter filterChildren children)


map : (a -> b) -> Tree a -> Tree b
map f tree =
    case tree of
        Empty ->
            Empty

        Leaf key ->
            Leaf (f key)

        Node key children ->
            Node (f key) (List.map (map f) children)


getKey : Tree a -> Maybe a
getKey tree =
    case tree of
        Empty ->
            Nothing

        Leaf key ->
            Just key

        Node v children ->
            Just v


getChildByKey : a -> Tree a -> Maybe (Tree a)
getChildByKey key tree =
    case tree of
        Empty ->
            Nothing

        Leaf _ ->
            Nothing

        Node v children ->
            let
                filterChildren child =
                    case child of
                        Empty ->
                            False

                        Leaf v ->
                            v == key

                        Node v children ->
                            v == key
            in
                List.filter filterChildren children
                    |> List.head


depth : Tree a -> Int
depth tree =
    case tree of
        Empty ->
            0

        Leaf _ ->
            0

        Node v children ->
            let
                childResult =
                    List.map depth children

                d =
                    List.maximum childResult |> Maybe.withDefault 0
            in
                1 + d
