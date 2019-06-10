// --------------------------------------------------------------------------
// Licensed Materials - Property of IBM
//
// 5725-A06 5725-A29 5724-Y48 5724-Y49 5724-Y54 5724-Y55
// Copyright IBM Corporation 1998, 2013. All Rights Reserved.
//
// Note to U.S. Government Users Restricted Rights:
// Use, duplication or disclosure restricted by GSA ADP Schedule
// Contract with IBM Corp.
// --------------------------------------------------------------------------

// Problem 8 from Model Building in Mathematical Programming, 3rd ed.
//   by HP Williams
//
// Farm Planning 
//This model is described in the documentation. 
//See IDE and OPL > Language and Interfaces Examples.


int NbLands = ...;
range Lands = 1..NbLands;

int NbYears = ...;
range Years = 1..NbYears;

int NbAges = ...;
range Ages = 1..NbAges;
// Heifers are cows up to age 2
// Productive cows are past heifer age but not yet at selling age
range CowAges = 2..NbAges-1;

float InitCows[Ages] = ...;
float HeifSurvival = ...;
float CowSurvival = ...;
float CalfRate = ...;
float HeifFraction = ...;
float InitCap = ...;
float GrPerCow = ...;
float SbPerCow = ...;
float GrPerAcre[Lands] = ...;
float GrAcre[Lands] = ...;
float SbPerAcre = ...;
float HeifAcre = ...;
float CowAcre = ...;
float Acres = ...;
float HeifLabor = ...;
float CowLabor = ...;
float Labor = ...;
float GrLabor = ...;
float SbLabor = ...;
float DownCowChg = ...;
float UpCowChg = ...;
float BullockSellPrice = ...;
float HeifSellPrice = ...;
float CowSellPrice = ...;
float MilkPerCowPrice = ...;
float GrSellPrice = ...;
float SbSellPrice = ...;
float GrBuyPrice = ...;
float SbBuyPrice = ...;
float LbrFixCost = ...;
float LbrCost = ...;
float HeifCost = ...;
float CowCost = ...;
float GrGrowCost = ...;
float SbGrowCost = ...;
int   LoanTerm = ...;
float Repay = ...;

float InitCowsTotal = sum(j in CowAges) InitCows[j];

dvar float+ GrGrow[l in Lands][y in Years] in 0..GrPerAcre[l]*GrAcre[l];
dvar float+ GrBuy[Years];
dvar float+ GrSell[Years];
dvar float+ SbGrow[Years];
dvar float+ SbBuy[Years];
dvar float+ SbSell[Years];
dvar float+ Lbr[Years];
dvar float+ CapAdd[Years];
dvar float+ HeifSell[Years];
dvar float+ Cow[Ages,Years];
dvar float+ CowT[Years];
dvar float+ Heif[Years];
dvar float+ Pr[Years];

dexpr float objective =
  sum(y in Years) Pr[y]
    - Repay * (sum(y in Years) ((LoanTerm-NbYears-1+y) * CapAdd[y]));

maximize objective;

subject to {
  // Add a Total cows variable
  forall(y in Years)
    ctTotCow: CowT[y] == sum(j in CowAges) Cow[j][y];

  // Continuity - cows move from one age to the next
  forall(y in 1..NbYears-1) {
    Cow[1][y+1] == HeifSurvival * Heif[y];
    Cow[2][y+1] == HeifSurvival * Cow[1][y];
    forall(j in CowAges)
      Cow[j+1][y+1] == CowSurvival * Cow[j][y];
  }

  // Sell heifers as newborns
  forall(y in Years)
    ctHeifNew:  Heif[y] == CalfRate * HeifFraction * CowT[y] - HeifSell[y];

  // Initial conditions
  Cow[1][1] == HeifSurvival * InitCows[1];
  Cow[2][1] == HeifSurvival * InitCows[2];
  forall(j in 3..NbAges)
    Cow[j][1] == CowSurvival * InitCows[j];
 
  // Accommodation
  forall(y in Years)
    ctAccom: Heif[y] + Cow[1][y] + CowT[y]
       <= InitCap + sum(k in Years: k <= y) CapAdd[k];

  // Grain consumption
  forall(y in Years)
    ctGrainCon: CowT[y] * GrPerCow <= 
       sum(l in Lands) GrGrow[l,y] + GrBuy[y] - GrSell[y];
          
  // Sugar beet consumption
  forall(y in Years)
    ctSugBeet: CowT[y] * SbPerCow <=
       SbGrow[y] + SbBuy[y] - SbSell[y];

  // Acreage
  forall(y in Years)
    ctAcreage: sum(l in Lands) 1.0/GrPerAcre[l] * GrGrow[l][y] 
       + 1.0/SbPerAcre * SbGrow[y] + HeifAcre * Heif[y]
       + HeifAcre * Cow[1][y] 
       + CowAcre * CowT[y] <= Acres; 

  // Labor
  forall(y in Years)
    ctLabor: HeifLabor * Heif[y] + HeifLabor * Cow[1][y]
    + CowLabor * CowT[y]
    + GrLabor * (sum(l in Lands) 1.0/GrPerAcre[l] * GrGrow[l][y])
    + SbLabor * 1.0 / SbPerAcre * SbGrow[y]
    <= Labor + Lbr[y];

  // End total
  ctEndTot: InitCowsTotal * (1.0 - DownCowChg) 
      <= CowT[NbYears]
      <= InitCowsTotal * (1.0 + UpCowChg);

  // Profit
  forall(y in Years)
    ctProfit: Pr[y] == BullockSellPrice * CalfRate * (1.0 - HeifFraction) * CowT[y] 
             + HeifSellPrice * HeifSell[y]
             + CowSellPrice * Cow[NbAges][y]
             + MilkPerCowPrice * CowT[y] 
             + GrSellPrice * GrSell[y]
             + SbSellPrice * SbSell[y]
             - GrBuyPrice * GrBuy[y]
             - SbBuyPrice * SbBuy[y]
             - LbrCost * Lbr[y]
             - LbrFixCost
             - HeifCost * Heif[y]
             - HeifCost * Cow[1][y]
             - CowCost * CowT[y]
             - GrGrowCost * (sum(l in Lands) 1.0/GrPerAcre[l] * GrGrow[l][y])
             - SbGrowCost * (1.0/SbPerAcre) * SbGrow[y]
             - Repay * (sum(k in Years: k<=y) CapAdd[k]);

  // Profit can never be negative--variable declared >= 0 above
}

execute DISPLAY {   
  for(var y in Years)
    for(var l in Lands)
      if(GrGrow[l][y] >= 1e-6)
        writeln("GrGrow[", l, "][", y, "] = ", GrGrow[l][y]);
            
  writeln();
            
  for(y in Years)
    if(SbGrow[y] >= 1e-6)
      writeln("SbGrow[", y, "] = ", SbGrow[y]);
         
  writeln();
         
  for(y in Years)
    if(GrBuy[y] >= 1e-6)
      writeln("GrBuy[", y, "] = ", GrBuy[y]);
         
  writeln();
   
  for(y in Years)
    if(SbBuy[y] >= 1e-6)
      writeln("SbBuy[", y, "] = ", SbBuy[y]);
   
  writeln();
        
  for(y in Years)
    if(GrSell[y] >= 1e-6)
      writeln("GrSell[", y, "] = ", GrSell[y]);
   
  writeln();
         
  for(y in Years)
    if(SbSell[y] >= 1e-6)
      writeln("SbSell[", y, "] = ", SbSell[y]);
   
  writeln();
         
  for(y in Years)
    if(HeifSell[y] >= 1e-6)
      writeln("HeifSell[", y, "] = ", HeifSell[y]);
   
  writeln();
         
  for(y in Years)
    writeln("Pr[", y, "] = ", Pr[y]);
}


tuple PrSolutionT{ 
	int Years; 
	float value; 
};
{PrSolutionT} PrSolution = {<i0,Pr[i0]> | i0 in Years};
tuple CapAddSolutionT{ 
	int Years; 
	float value; 
};
{CapAddSolutionT} CapAddSolution = {<i0,CapAdd[i0]> | i0 in Years};
tuple CowTSolutionT{ 
	int Years; 
	float value; 
};
{CowTSolutionT} CowTSolution = {<i0,CowT[i0]> | i0 in Years};
tuple CowSolutionT{ 
	int Ages; 
	int Years; 
	float value; 
};
{CowSolutionT} CowSolution = {<i0,i1,Cow[i0][i1]> | i0 in Ages,i1 in Years};
tuple HeifSolutionT{ 
	int Years; 
	float value; 
};
{HeifSolutionT} HeifSolution = {<i0,Heif[i0]> | i0 in Years};
tuple HeifSellSolutionT{ 
	int Years; 
	float value; 
};
{HeifSellSolutionT} HeifSellSolution = {<i0,HeifSell[i0]> | i0 in Years};
tuple GrGrowSolutionT{ 
	int Lands; 
	int Years; 
	float value; 
};
{GrGrowSolutionT} GrGrowSolution = {<i0,i1,GrGrow[i0][i1]> | i0 in Lands,i1 in Years};
tuple GrBuySolutionT{ 
	int Years; 
	float value; 
};
{GrBuySolutionT} GrBuySolution = {<i0,GrBuy[i0]> | i0 in Years};
tuple GrSellSolutionT{ 
	int Years; 
	float value; 
};
{GrSellSolutionT} GrSellSolution = {<i0,GrSell[i0]> | i0 in Years};
tuple SbGrowSolutionT{ 
	int Years; 
	float value; 
};
{SbGrowSolutionT} SbGrowSolution = {<i0,SbGrow[i0]> | i0 in Years};
tuple SbBuySolutionT{ 
	int Years; 
	float value; 
};
{SbBuySolutionT} SbBuySolution = {<i0,SbBuy[i0]> | i0 in Years};
tuple SbSellSolutionT{ 
	int Years; 
	float value; 
};
{SbSellSolutionT} SbSellSolution = {<i0,SbSell[i0]> | i0 in Years};
tuple LbrSolutionT{ 
	int Years; 
	float value; 
};
{LbrSolutionT} LbrSolution = {<i0,Lbr[i0]> | i0 in Years};


