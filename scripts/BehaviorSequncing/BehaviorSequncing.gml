function behavior_sequence(_behaviors=[])constructor{
    behaviors=_behaviors
    currentBehaviors=[]
    start = function(){
        currentBehaviors=[]
        var _cumulativeDelay = 0
        for (var i = 0; i < array_length(behaviors); i++) {
            _cumulativeDelay += behaviors[i].delay
            if _cumulativeDelay > 0 {
                 var _tS = call_later(_cumulativeDelay,time_source_units_seconds,behaviors[i].callback)
                 array_push(currentBehaviors,_tS)
            } else {
                method_call(behaviors[i].callback)
            }
        }
    }
    stop = function(){
        while array_length(currentBehaviors)>0{
            call_cancel( array_pop(currentBehaviors))
        }
    }
}
function behavior(_delay=0,_callback=function(){})constructor{
    delay=_delay
    callback=_callback
}








