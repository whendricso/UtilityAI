# Utility AI for GameMaker
> Quickly add life to NPCs in complex gameplay situations
> Simple settings produce robust results
> AI adapts to changing game situations
> Optional custom interrupt logic 

## Introduction
1. Create **Behavior Sequences**, re-usable lists of methods each with an optional delay:
```js
idleSeq = new behavior_sequence([
    new behavior(0,function(){
        goto(x,y)
    }),
    new behavior(4,function(){
        goto(random_range(-sprite_width*2,sprite_width*2),random_range(-sprite_height*2,sprite_height*2),self)
    }),
    new behavior(2,function(){
        utilityModule.satisfy("Idle")
    })
])
```
2. Create a **Utility Module**, a high-level decisionmaker that tries to satisfy needs called `directive`s:
```js
utilityModule = new utility_module([
    new directive("Idle", idleSeq,0.2,0.05),
    new directive("Gather", gatherSeq,0,0.1,function(){return instance_exists(ResourceObj)},function(){return !collision_point(tgtX+8,tgtY+8,ResourceObj,false,true)}),
    new directive("Return", returnSeq),
    new directive("Recoup",recoupSeq,0,-0.001,function(){return instance_exists(HourglassObj)})
])
```
3. Feed that **Utility Module** some updates. These don't need to be in the "step" event but they can be!
```js
utilityModule.update()
```

That's it! The ai will check it's directives from first to last (in order!) and pick the one with the highest priority.

## Predicates
This module has two predicates:
1. `_predicate` is checked before a directive is selected, and must return true for the directive to be selected
2. `_breakoutPredicate` is checked during `update` and must return false otherwise the directive will abort and the AI will reconsider

Here we can see an example of both of these predicate definitions in this Directive definition:
```js
new directive(
  "Gather",//name
  gatherSeq,//sequence
  0,//valence
  0.1,//rate
  function(){//predicate
    return instance_exists(ResourceObj)
  },
  function(){//breakout predicate
    return !collision_point(tgtX+8,tgtY+8,ResourceObj,false,true)
  }
),
```
