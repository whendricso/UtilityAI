function utility_module(_directives)constructor{
    directives=_directives
    currentDirective=undefined
    update = function(){
        for (var i=0;i<array_length(directives);i++){
            directives[i].update()
        }
        var _highest = find_highest_valence()
        if _highest != -1{
            if directives[ _highest] != currentDirective {
                if currentDirective == undefined || !directives[_highest].currentlyLocked
                    initialize_directive(_highest)
            }
            if currentDirective != undefined {
                if !currentDirective.currentlyLocked {
                    currentDirective.stop()
                }
            }
        }
    }
    satisfy = function(_name,_amount){
        for (var i=0;i<array_length(directives);i++){
            if directives[i].name == _name
                directives[i].satisfy(_amount)
        }
    }
    find_highest_valence = function(){
        var _highestIndex=-1
        var _highestValence=-1
        for (var i=0;i<array_length(directives);i++){
            if directives[i].valence > _highestValence {
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
}
function directive(_name,_sequence,_valence=0,_rate=0,_lockable=true)constructor{
    name=_name
    valence=_valence
    rate=_rate
    currentlyLocked=false
    sequence=_sequence
    lockable=_lockable

    static gameSpeed = game_get_speed(gamespeed_fps)
    satisfy = function(_amount){
        valence = clamp(valence-_amount,0,1)
        currentlyLocked=false
    }
    update = function(){
        valence = clamp(valence+rate*(delta_time/1000000),0,1)
        sequence.update()
        if sequence.startTime == -1
            stop()
    }
    start = function(){
        if lockable {
            currentlyLocked=true
            sequence.start()
        }
        if !lockable || !currentlyLocked
            sequence.start()
    }
    stop = function(){
        currentlyLocked=false
        sequence.stop()
    }
}



