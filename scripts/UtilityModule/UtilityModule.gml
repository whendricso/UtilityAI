function utility_module(_directives=[])constructor{
    directives=_directives
    currentDirective=undefined
    //@desc Utility Module reuires an update tick to be called any time you want to update it's state
    update = function(){
        if currentDirective != undefined {
            if !currentDirective.currentlyLocked{
                currentDirective=undefined
            }
        }
        for (var i=0;i<array_length(directives);i++){
            directives[i].update()
        }
        var _highest = find_highest_valence()
        if _highest != -1{
            if directives[ _highest] != currentDirective {
                if currentDirective == undefined || !directives[_highest].currentlyLocked
                    initialize_directive(_highest)
            }
        }
    }
    satisfy = function(_name,_amount=1){
        for (var i=0;i<array_length(directives);i++){
            if directives[i].name == _name
                directives[i].satisfy(_amount)
        }
    }
    find_highest_valence = function(){
        var _highestIndex=-1
        var _highestValence=-1
        for (var i=0;i<array_length(directives);i++){
            if directives[i].valence > _highestValence && directives[i].predicate() {
                _highestValence=directives[i].valence
                _highestIndex=i
            }
        }
        return _highestIndex
    }
    initialize_directive = function(_index){
        currentDirective=directives[_index]
        for (var i=0;i<array_length(directives);i++){
            if i==_index{
                directives[i].start()
            } else {
                directives[i].stop()
            }
        }
    }
    draw = function(_x,_y,_separation=16,_bgWidth=0){
        var _cumulativeOffset = 0
        _cumulativeOffset+=_separation
        if _bgWidth > 0 {
            draw_set_color(#333333)
            draw_set_alpha(0.35)
            draw_rectangle(_x+_separation,_y+_separation,_x+_separation/2+_bgWidth,_y+_separation*2+_separation*array_length(directives),false)
            draw_set_alpha(1)
        }
        draw_set_color(c_white)
        draw_text(_x,_y+_cumulativeOffset,$"Directive: {currentDirective==undefined?undefined:currentDirective.name}")
        for (var i = 0; i < array_length(directives); i++) {
            _cumulativeOffset+=_separation
            if directives[i].currentlyLocked
                draw_set_color(#98af6f)
            else
                draw_set_color(#aaaaaa)
            draw_text(_x,_y+_cumulativeOffset,$"{directives[i].name} Lck: {directives[i].currentlyLocked} V: {directives[i].valence}")
            draw_set_color(c_white)
        }
        draw_set_color(c_white)
    }
}
/**
 * A Directive Encapsulates the functionality for an AI desire and the ability to initiate a sequence or interrupt it
 * @param {string} _name The name of this directive
 * @param {Struct.behavior_sequence} _sequence A behaviour sequence to be associated with this directive 
 * @param {real} [_valence]=0 The urgency of this directive
 * @param {real} [_rate]=0 The rate of change/sec to this directive's valence
 * @param {function} [_predicate]=true A function that, when false will not be selected by the Utility Module
 * @param {function} [_breakoutPredicate]=true If this returns true, stop this directive during the update
 */
function directive(_name,_sequence,_valence=0,_rate=0,_predicate=function(){return true},_breakoutPredicate=function(){return false})constructor{
    name=_name
    valence=_valence
    rate=_rate
    currentlyLocked=false
    sequence=_sequence
    predicate=_predicate
    breakoutPredicate=_breakoutPredicate
    
    gameTime=current_time
    currentDelta=0
    
    //@desc satisfy the desire to pursue this directive and unlock it, allowing re-evaluation
    //@param {real} [_amount]=1 How much should we satisfy this Directive? Negative numbers increase desire instead
    satisfy = function(_amount=1){
        valence = clamp(valence-_amount,0,1)
        currentlyLocked=false
    }
    //@ignore
    update = function(){
        valence = clamp(valence+rate*(currentDelta/1000),0,1)
        currentDelta=current_time-gameTime
        gameTime=current_time
        if currentlyLocked && breakoutPredicate()
            stop()
    }
    start = function(){
        if !currentlyLocked
            sequence.start()
        currentlyLocked=true
    }
    stop = function(){
        if currentlyLocked
            sequence.stop()
        currentlyLocked=false
    }
}



