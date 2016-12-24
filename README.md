# Elm Tree

An implementation of a [Tree][wiki-tree] in elm.

[![Build Status](https://travis-ci.org/daegren/elm-tree.svg?branch=master)](https://travis-ci.org/daegren/elm-tree)

The goal of this project is to:

 * Implement basic list methods: `depth`, `height`, `add/removeChild`
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

tree = Tree.addChild "captains" Tree.empty
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

[wiki-tree]: https://en.wikipedia.org/wiki/Tree_(data_structure)
