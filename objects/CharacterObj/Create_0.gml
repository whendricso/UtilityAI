image_blend=#886644
utilityModule = new utility_module([
new directive("Idle", new behavior_sequence([new behavior(4)])),
new directive("Gather", new behavior_sequence([new behavior(0,function(){
    var _tgt = instance_nearest(x,y,ResourceObj)
    goto(_tgt.x,_tgt.y,3,self)})]),0,0.1),
new directive("Return",new behavior_sequence([new behavior(0,function(){
    var _tgt = instance_nearest(x,y,HomeBaseObj)
    goto(_tgt.x,_tgt.y,3,self)})]))
])