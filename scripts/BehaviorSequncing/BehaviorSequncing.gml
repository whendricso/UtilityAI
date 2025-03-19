function behavior_sequence(_behaviors=[])constructor{
    behaviors=_behaviors
    currentBehaviors=[]
    startTime=-1
    static gameSpeed = game_get_speed(gamespeed_fps)
    start = function(){
        startTime=current_time
        array_copy(currentBehaviors,0,behaviors,0,array_length(behaviors))
    }
    update = function (){
        if startTime != -1{
            if array_length(currentBehaviors) > 0 {
                currentBehaviors[0].delay -= delta_time/gameSpeed
                if currentBehaviors[0].delay <= 0 {
                    method_call(currentBehaviors[0].callback)
                    array_delete(currentBehaviors,0,1)
                }
            } else {
                stop()
            }
        }
    }
    stop = function(){
        startTime=-1
        currentBehaviors=[]
    }
}
function behavior(_delay=0,_callback=function(){})constructor{
    delay=_delay
    callback=_callback
}