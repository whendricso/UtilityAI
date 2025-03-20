function utility_module(_directives=[])constructor{
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
                if directives[i]!=currentDirective
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

    satisfy = function(_amount){
        valence = clamp(valence-_amount,0,1)
        currentlyLocked=false
    }
    update = function(){
        valence = clamp(valence+rate*(delta_time/1000000),0,1)
    }
    start = function(){
        if !lockable || !currentlyLocked
            sequence.start()
        if lockable
            currentlyLocked=true
    }
    stop = function(){
        currentlyLocked=false
        sequence.stop()
    }
}



