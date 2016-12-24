module Tests exposing (..)

import Test exposing (..)
import Expect
import Fuzz exposing (list, int, tuple, string)
import String
import Tree exposing (Tree)


all : Test
all =
    describe "Tree test suite"
        [ describe "Unit test"
            [ test "empty tree" <|
                \() ->
                    Expect.equal Tree.empty Tree.Empty
            , describe "adding children"
                [ test "on empty tree returns new tree with key as root" <|
                    \() ->
                        let
                            tree =
                                Tree.addChild "test" Tree.Empty
                        in
                            Expect.equal (Tree.getKey tree |> Maybe.withDefault "") "test"
                , describe "exiting tree"
                    [ test "adds to existing children" <|
                        \_ ->
                            let
                                tree =
                                    Tree.addChild "ships" Tree.Empty
                                        |> Tree.addChild "Firefly"
                            in
                                Expect.equal (Tree.getChildByKey "Firefly" tree) (Just (Tree.addChild "Firefly" Tree.Empty))
                    , test "merge two trees" <|
                        \_ ->
                            let
                                tree =
                                    Tree.addChild "ships" Tree.Empty

                                firefly =
                                    Tree.addChild "Firefly" Tree.Empty
                                        |> Tree.addChild "Malcolm Reynols"
                                        |> Tree.addChild "Derrial Book"
                                        |> Tree.addChild "Hoban Washburne"

                                mergedTree =
                                    Tree.addChildTree firefly tree
                            in
                                Expect.equal (Tree.getChildByKey "Firefly" mergedTree) (Just firefly)
                    ]
                ]
            ]
          --     [ test "Addition" <|
          --         \() ->
          --             Expect.equal (3 + 7) 10
          --     , test "String.left" <|
          --         \() ->
          --             Expect.equal "a" (String.left 1 "abcdefg")
          --     , test "This test should fail - you should remove it" <|
          --         \() ->
          --             Expect.fail "Failed as expected!"
          --     ]
          -- , describe "Fuzz test examples, using randomly generated input"
          --     [ fuzz (list int) "Lists always have positive length" <|
          --         \aList ->
          --             List.length aList |> Expect.atLeast 0
          --     , fuzz (list int) "Sorting a list does not change its length" <|
          --         \aList ->
          --             List.sort aList |> List.length |> Expect.equal (List.length aList)
          --     , fuzzWith { runs = 1000 } int "List.member will find an integer in a list containing it" <|
          --         \i ->
          --             List.member i [ i ] |> Expect.true "If you see this, List.member returned False!"
          --     , fuzz2 string string "The length of a string equals the sum of its substrings' lengths" <|
          --         \s1 s2 ->
          --             s1 ++ s2 |> String.length |> Expect.equal (String.length s1 + String.length s2)
          --     ]
        ]
