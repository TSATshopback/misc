//USAGE mongo <dn name> findDuplicateFB.js
//USAGE mongo SG2018-01-28 findDuplicateFB.js

const mapper = function() {
    if (this.socialMedia !== undefined  ){
        emit( this.socialMedia.facebook.id, 1);
    }
}


const reducer = function(key,values) {
    var result = {
         fbid : undefined,
         count: 0
    }

    result.fbid = key ;
    result.count= values.length ;
    return result;
}

print("start map-reduce");
db.accounts.mapReduce(mapper, reducer, {out: { merge:"findDupMP"} } )
print("done map-reduce");
print("total accounts");
print(db.accounts.count());
print("total FB");
print(db.findDupMP.find({"value":1}).count());
print("possibile FB duplicate")
print(db.findDupMP.find( { "value": { $not : { $eq : 1} } }  ).count())

