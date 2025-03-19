global.timeSource = undefined
function goto(_x,_y,_spd,_me){
    if global.timeSource != undefined {
        if time_source_exists(global.timeSource)
            time_source_destroy(global.timeSource)
    }
    global.timeSource=time_source_create(time_source_game,1,time_source_units_frames,goto_process,[_x,_y,_spd,_me])
    time_source_start(global.timeSource)
}
function goto_process(_x,_y,_spd,_me){
    var _xTarget=_x
    var _yTarget=_y
    var _speed=_spd
    move_towards_point(_xTarget,_yTarget,_speed)
    if point_distance(_me.x,_me.y,_xTarget,_yTarget) <= _speed{
        time_source_stop(global.timeSource)
        time_source_destroy(global.timeSource)
    }
}