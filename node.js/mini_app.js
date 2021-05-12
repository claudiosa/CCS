


/// Syncron or sequential code
process.stdout.write(" Initializing ..............\n")


const frases = [
    "Devemos agradecer (sempre)?",  
    "Mantenha sua humildade para com as pessoas?",
    "Devemos criticar as pessoas?",
    "Devemos ajudar as pessoas? Quantos ajudei hoje?"
];

const respostas = [
    "Sempre agradeça as pessoas",
    "Mantenha-se humilde",
    "Criticar só quando solicitada a opinião",
    "Todo dia se ajuda a alguém"
];


const ask = (index = 0) => {
    process.stdout.write(frases[index] + "::> ")

}


//ask(2)
ask()

// AUX ARRAY
const ANSWER = []
// on ... keeps the process alive ....
// keep alive waiting for ENTER ... from keyboard
process.stdin.on ("data", data => { 
       // trim ... remove blank spaces
    if (ANSWER.length < frases.length)
    {
        // to be improve here
        ask(ANSWER.length)
        process.stdout.write("\nSugestão: ")
        process.stdout.write(respostas[ANSWER.length])
        ANSWER.push(data.toString().trim())
    } else
    {
    //process.stdout.write(ANSWER)
    process.exit()
    }

 }
)
// listening ....
process.on ('exit', () => {
    process.stdout.write("When the finish ... a call back!!! ")
    process.stdout.write("FINISHED ")
}
)