# Boolean Network Regulatory Rules

20-node network constructed in BoolNet v2.1.9. All rules from primary experimental literature.

## Rules
```
KRAS    = KRAS              # Input — constitutively ON in PDAC
TP53    = TP53              # Input/drug target
Hypoxia = Hypoxia           # Environmental input
HIF1A   = KRAS | Hypoxia   # Kaelin & Ratcliffe 2008
CA9     = HIF1A             # Swietach et al. 2007
CA12    = HIF1A             # Swietach et al. 2007
MAP3K7  = KRAS | RELA       # Ninomiya-Tsuji et al. 1999
CHUK    = MAP3K7            # Karin et al. 2002
RELA    = (CA9|MAP3K7|CHUK) & !TP53  # Basseres & Baldwin 2006
CCND1   = RELA | KRAS       # Basseres & Baldwin 2006
CDK4    = CCND1 & !TP53     # Sherr & Roberts 1999
TTK     = CDK4              # Lossaint et al. 2011
BCL2    = RELA & !TP53      # Czabotar et al. 2014
BCL2L1  = RELA              # Czabotar et al. 2014
BAX     = TP53 & !BCL2      # Czabotar et al. 2014
APAF1   = BAX               # Llambi et al. 2011
CASP9   = APAF1 & !BCL2L1  # Marsden et al. 2002
FADD    = !BCL2             # Cory et al. 2003
CASP8   = FADD              # Cory et al. 2003
CASP3   = CASP9 | CASP8    # Death output node
```

## Drug Perturbations
- SLC-0111: fixGenes(CA9 = 0)
- Palbociclib: fixGenes(CDK4 = 0)
- Gemcitabine: fixGenes(TP53 = 1)
- Triple: fixGenes(CA9=0, CDK4=0, TP53=1)

## Death Attractor Definition
CASP3 = 1 OR (CASP9 = 1 AND BCL2L1 = 0)
