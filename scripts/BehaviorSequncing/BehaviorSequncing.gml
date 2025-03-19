function behavior_sequence(_behaviors=[])constructor{
    behaviors=_behaviors
    currentBehaviors=[]
    static gameSpeed = game_get_speed(gamespeed_fps)
    start = function(){
        currentBehaviors=[]
        for (var i = 0; i < array_length(behaviors); i++) {
            array_push(currentBehaviors,call_later(behaviors[i].delay,behaviors[i].callback))
        }
    }
    stop = function(){
        startTime=-1
        while array_length(currentBehaviors)>0{
            call_cancel( array_pop(currentBehaviors))
        }
    }
}
function behavior(_delay=0,_callback=function(){})constructor{
    delay=_delay
    callback=_callback
}