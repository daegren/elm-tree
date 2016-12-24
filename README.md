# Elm Tree

An implementation of a [Tree][wiki-tree] in elm. The goal of this project is to:

 * Implement basic list methods: `depth`, `height`, `add/removeChild`
 * Allow any value stored in a Node

## Tree
```elm

-- Tree is either a node or empty
type Tree v
    = Node v (List (Tree v))
    | Empty

```

### Usage

```elm

tree = Tree.addChild "captains" Tree.empty
-- tree == Node "captains" []

allCaptains =
  let
    _ = List.map (\captain -> Tree.addChild captain tree)
      [ "Malcolm Reynolds", "Jean-Luc Picard", "Turanga Leela" ]
  in
    tree
-- allCaptains ==
--     Node "captains"
--         [ Node "Malcolm Reynolds" []
--         , Node "Jean-Luc Picard" []
--         , Node "Turanga Leela" []
--         ]

getCaptain key =
  Tree.getChildByKey key allCaptains

getLeela =
  getCaptain "Truanga Leela"
-- Just (Node "Turanga Leela" [])

```

[wiki-tree]: https://en.wikipedia.org/wiki/Tree_(data_structure)
