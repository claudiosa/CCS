
// for => equal C
// js has break and continue

//while .... ==> equal C
// if you do not know when it stops ... no counter ...


// for in ... ===> to use in OBJECTS compounds

let obj_p = {
    name: 'claudio',
    age: 62,
    weight : 73
}

for(let var_property  in obj_p) {
    //console.log(var_property)
    console.log(obj_p[var_property])
    //console.log(obj_p.name)
    //console.log(obj_p.${var_property}) why not works???
}
