# Elm Tree

An implementation of a [Tree][wiki-tree] in elm.

[![Build Status](https://travis-ci.org/daegren/elm-tree.svg?branch=master)](https://travis-ci.org/daegren/elm-tree)

The goal of this project is to:

 * Implement basic tree methods: `depth`, `height`, `add/removeChild`
 * Store values as actual values, avoid serialization at all costs.

## Tree
```elm

-- Tree is either a node or empty
type Tree v
    = Node v (List (Tree v))
    | Leaf v
    | Empty

```

### Usage

```elm

tree = Tree.init "captains"
-- tree == Leaf "captains"

allCaptains =
    let
        _ = List.map (\captain -> Tree.addChild captain tree)
            [ "Malcolm Reynolds", "Jean-Luc Picard", "Turanga Leela" ]
    in
        tree
-- allCaptains ==
--     Node "captains"
--         [ Leaf "Malcolm Reynolds"
--         , Leaf "Jean-Luc Picard"
--         , Leaf "Turanga Leela"
--         ]

getCaptain key =
    Tree.getChildByKey key allCaptains

getLeela =
    getCaptain "Truanga Leela"
-- Just (Leaf "Turanga Leela")

```

Multi-typed trees can be achieved using a `Union Type`

```elm
type Value
    = String String
    | Int Int
    | Bool Bool

stringAndIntTree =
    Tree.init (String "Philip J. Fry")
        |> Tree.addChildTree
            (Tree.init (String "isOwnGrandfather")
                |> Tree.addChild (Bool True)
            )
-- Node (String "Philip J. Fry")
--   [ Node (String "isOwnGrandfather")
--     [ Leaf (Bool True) ]
--   ]

```

[wiki-tree]: https://en.wikipedia.org/wiki/Tree_(data_structure)
