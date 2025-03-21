/// @desc A sequence of behaviours to run in order each with an optional delay 
/// @param {array} [_behaviors]=[] The array of behaviours
function behavior_sequence(_behaviors=[])constructor{
    behaviors=_behaviors
    currentBehaviors=[]
    //@desc Begins this sequence and stores references to the timers so that they can be stopped later 
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
    //@desc Stops all current timers running for this behaviour sequence 
    stop = function(){
        while array_length(currentBehaviors)>0{
            call_cancel( array_pop(currentBehaviors))
        }
    }
}
/**
 * A behaviour is just a function with an optional delay 
 * @param {real} [_delay]=0 If greater than 0 we will schedule this function for later. Time is in seconds 
 * @param {function} [_callback]=function The function literal that we should call. Extant functions must be placed in a wrapper 
 */
function behavior(_delay=0,_callback=function(){})constructor{
    delay=_delay
    callback=_callback
}








