#include <iostream>
#include <stdlib.h>
using namespace std;

int main()
{
    int numOfRounds;
    char prisonerA; 
    char prisonerB; 
    int prisonerAYears;
    int prisonerBYears;
    int round; //broj runde

    prisonerAYears=0;
    prisonerBYears=0;
    round=1;

    cout<<endl;
    cout<<"Enter the number of ROUNDS you want to play: ";
    cin>>numOfRounds;
    cout<<endl;

while(numOfRounds>0)
{
    numOfRounds=numOfRounds-1;
    cout<<endl;
    cout<<"Game "<<round++<<endl;
    cout<<endl;

    cout<<"What is your decision? Confess or stay Silent?(C/S) : ";
    cin>>prisonerA;
    cout<<endl;

    if ((prisonerA=='C') || (prisonerA=='c')) 
    {
        prisonerB='S';
        prisonerAYears=prisonerAYears+5;
        prisonerBYears=prisonerBYears+0;
        cout<<"Prisoner A (you) chose: Confess. Prisoner B (the opponent) chose: Confess."<<endl;
        cout<<"Prisoner A (you) is currently in for: "<<prisonerAYears<<" years."<<endl;
        cout<<"Prisoner B (the opponent) is currently in for: "<<prisonerBYears<<" years."<<endl;
    }

    else if((prisonerA=='S') || (prisonerA=='s'))
    {
        prisonerB='S';
        prisonerAYears=prisonerAYears+3;
        prisonerBYears=prisonerBYears+3;
        cout<<"Prisoner A (you) chose: Silence. Prisoner B (the opponent) chose: Confess."<<endl;
        cout<<"Prisoner A (you) is currently in for: "<<prisonerAYears<<" years."<<endl;
        cout<<"Prisoner B (the opponent) is currently in for: "<<prisonerBYears<<" years."<<endl;
    }

}
cout<<endl;
cout<<"The rounds have come to an end."<<endl<<endl;
cout<<"Prisoner A (you) is currently in for: "<<prisonerAYears<<" years."<<endl;
cout<<"Prisoner B (the opponent) is currently in for: "<<prisonerBYears<<" years."<<endl<<endl;

if(prisonerAYears>prisonerBYears)
{

    cout<<"You have to stay in prison longer. You lose."<<endl;
}
if(prisonerAYears<prisonerBYears)
{

    cout<<"The opponent has to stay in prison longer. You win."<<endl;
}

if(prisonerAYears==prisonerBYears)
{

    cout<<"You both are staying in prison for the same amount of time. Its a tie."<<endl;
}
      return 0;
}
