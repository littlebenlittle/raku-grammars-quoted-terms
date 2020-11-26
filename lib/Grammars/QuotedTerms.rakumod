
unit grammar Grammars::QuotedTerms:auth<github:littlebenlittle>:ver<0.0.0>;

token TOP { $<terms>=<.term>+ % \s+ }

proto token term {*}
      token term:sym<word>   { [\w|\-|\.]+                }
      token term:sym<single> { "'" $<term>=<-[']>* "'" }
      token term:sym<double> { '"' $<term>=<-["]>* '"' }

class Actions {
    method TOP($/) { make $<terms>».made }
    method term:sym<word>   ($/) { make $/.Str       } 
    method term:sym<single> ($/) { make $/<term>.Str }
    method term:sym<double> ($/) { make $/<term>.Str }
}

method parse($target, Mu :$actions = Actions, |c) {
    callwith $target, :$actions, |c
}
