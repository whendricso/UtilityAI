utilityModule.update()
var _mag = point_distance(x,x,tgtX,tgtY)
if (_mag) > 5
    move_towards_point(tgtX,tgtY,3)
else {
    hspeed=0
    vspeed=0
}