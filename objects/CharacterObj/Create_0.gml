image_blend=#886644
tgtX=x
tgtY=y
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
recoupSeq = new behavior_sequence([
    new behavior(0,function(){
        if instance_exists(HourglassObj){
            var _tgt = instance_nearest(x,y,HourglassObj)
            goto(_tgt.x,_tgt.y)
        }
    })
])

utilityModule = new utility_module([
    new directive("Idle", idleSeq,0.2,0.05),
    new directive("Gather", gatherSeq,0,0.1,function(){return instance_exists(ResourceObj)},function(){return !collision_point(tgtX+8,tgtY+8,ResourceObj,false,true)}),
    new directive("Return", returnSeq),
    new directive("Recoup",recoupSeq,0,-0.001,function(){return instance_exists(HourglassObj)})
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