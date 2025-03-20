image_blend=#886644
tgtX=x
tgtY=y
idleSeq = new behavior_sequence([
    new behavior(4),
    new behavior(1,function(){
        goto(random_range(-sprite_width*2,sprite_width*2),random_range(-sprite_height*2,sprite_height*2),self)
    })
])
gatherSeq = new behavior_sequence([
    new behavior(0, function(){
        if instance_exists(ResourceObj){
            var _tgt = instance_nearest(x,y,ResourceObj)
            goto(_tgt.x,_tgt.y)
        }
    })
])
returnSeq = new behavior_sequence([
    new behavior(0, function(){
        if instance_exists(HomeBaseObj){
            var _tgt = instance_nearest(x,y,HomeBaseObj)
            goto(_tgt.x,_tgt.y)
        }
    })
])
utilityModule = new utility_module([
    new directive("Idle", idleSeq,0.2),
    new directive("Gather", gatherSeq,0,0.1),
    new directive("Return", returnSeq)
])
function goto(_x,_y,_rel=noone){
    if _rel==noone{
        tgtX=_x
        tgtY=_y
    } else{
        if instance_exists(_rel){
            tgtX=_rel.x+_x
            tgtY=_rel.y+_y
        }
    }
}