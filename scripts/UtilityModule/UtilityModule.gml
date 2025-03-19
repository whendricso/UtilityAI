function utility_module(_directives)constructor{
    directives=_directives
    currentDirective=undefined
    highestValence=0
    update = function(){
        var _nextDirectiveIndex=-1
        for (var i=0;i<array_length(directives);i++){
            directives[i].update()
            if directives[i].valence > highestValence {
                highestValence=directives[i].valence
                _nextDirectiveIndex=i
            }
        }
        if _nextDirectiveIndex != -1{
            var _lock = false
            if currentDirective != undefined {
                if !currentDirective.currentlyLocked {
                    currentDirective.stop()
                    _lock = true
                }
            }
            if (!_lock){
                currentDirective=directives[_nextDirectiveIndex]
                directives[_nextDirectiveIndex].start()
            } 
        }
    }
    satisfy = function(_name,_amount){
        for (var i=0;i<array_length(directives);i++){
            if directives[i].name == _name
                directives[i].satisfy(_amount)
        }
    }
}
function directive(_name,_sequence,_valence=0,_rate=0)constructor{
    name=_name
    valence=_valence
    rate=_rate
    currentlyLocked=false
    sequence=_sequence
    satisfy = function(_amount){
        valence = clamp(valence-clamp(_amount,-1,1),0,1)
        currentlyLocked=false
    }
    update = function(){
        valence = clamp(valence+rate*delta_time,0,1)
        sequence.update()
    }
    start = function(){
        currentlyLocked=true
        sequence.start()
    }
    stop = function(){
        currentlyLocked=false
        sequence.stop()
    }
}