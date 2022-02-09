## PAML: Phylogenetic Analysis Using Maximum Likelihood
PAML, maximum likelihood kullanarak farklı farklı evrimsel modelleri test etmeye yarayan bir program paketi.

### Codeml
Farklı codon modellerini karşılatırarak evrimsel hipotezleri test etmeye yarayan bir PAML programı.

Codeml çalıştırmak için üç farklı dosya gerekiyor:


 * PAML kontrol dosyası (.ctl)
 * CDS alignment (fasta)
 * Ağaç dosyası (newick formatında)
 
 ##### PAML kontrol dosyası
 
 Gerekli PAML/codeml parametrelerini barındıran dosya. Modeller için tüm parametreleri bu dosya içinde belirtiyoruz.
 
 Modeller için en önemli iki parametre **NSsites** ve ve **model** parametreleri. 
 
 NSsites ile protein sekansları içindeki farkl codon bölgelerine ait parametreleri değiştirebiliyoruz.
 model parametresi ise ağaç üerindeki farklı dallara ait parametreleri değiştirebiliyoruz. 
 
 
 codeml-M1278.ctl
 ```bash
       seqfile = PBANKA_030280.pal2nal.paml * sequence data filename
     treefile = tree.txt      * tree structure file name
      outfile = mlc-M1278           * main result file name

      runmode = 0  * 0: user tree;  1: semi-automatic;  2: automatic
                   * 3: StepwiseAddition; (4,5):PerturbationNNI; -2: pairwise

      seqtype = 1  * 1:codons; 2:AAs; 3:codons-->AAs
    CodonFreq = 2  * 0:1/61 each, 1:F1X4, 2:F3X4, 3:codon table

        clock = 0  * 0:no clock, 1:clock; 2:local clock; 3:CombinedAnalysis

        model = 0  * models for codons: 0:one, 1:b, 2:2 or more dN/dS ratios for branches

      NSsites = 0 1 2 7 8 * 0:one w;1:neutral;2:selection; 3:discrete;4:freqs;
                   * 5:gamma;6:2gamma;7:beta;8:beta&w;9:beta&gamma;
                   * 10:beta&gamma+1; 11:beta&normal>1; 12:0&2normal>1;
                   * 13:3normal>0

        icode = 0  * 0:universal code; 1:mammalian mt; 2-10:see below

    fix_omega = 0  * 1: omega or omega_1 fixed, 0: estimate 
        omega = .4 * initial or fixed omega, for codons or codon-based AAs

    cleandata = 0  * remove sites with ambiguity data (1:yes, 0:no)?

* Genetic codes: 0:universal, 1:mammalian mt., 2:yeast mt., 3:mold mt.,
* 4: invertebrate mt., 5: ciliate nuclear, 6: echinoderm mt., 
* 7: euplotid mt., 8: alternative yeast nu. 9: ascidian mt., 
* 10: blepharisma nu.
* These codes correspond to transl_table 1 to 11 of GENEBANK.
 
 ```
 

#### CDS alignment

PBANKA_030280.pal2nal.paml
```bash
   6    195
PBANKA_030280
GAGAAAAAAGCATCAATTGTTTCTGAACTGTCTCAAAGGTGTGCAGAAAATAAACAAGAT
ACAGATGCAAATGTAGATGCAGATACAGATGTAGATGATGTAGATGTAGATACAGATTCT
GAAAATGTTGAAGCGAATAGTGGAATGATTGAAGTTACGAAAAGGGAGCCAGTAGTAGAT
GGCGAGAATGGAAAA
PCHAS_030500
GAGAAAAAAGCATCTACTATTTCTGAAGTATCTCAAAAGTGTGCAGAAAATAAAGAACAG
GAAGAGGAAGAGGAAGAACCGTTAACAAATAGTAAGTCAAGTGATAGTTATATTAAGGAA
AAGGACACTAATGAAAATACAGAAATAATTGATGCTACAAAAAGAGAGTCGGTAGCAGAT
GATGAAAATGAAAAA
PY00902
GAGAAAGAAGCACCAATTGTTTCTGAACAGTCTCGGGGGCGTGCAGAAAATGAAGAAAAT
GAAGATGTAGAAAATGCAGCAGAAGAAGATGCAGAAGCTGTAGCAGAATATGTAGAAGCT
GAAGATGACGAAGTGAACAATGGAATGATTGAAGTTACGAAAAGGGAGCCAATAGTAGAT
GATGAGAATGGTAAA
PKH_041470
AAAGAGATAGAGGTGGAGCTAAAAGAAGAAGAGGAGGAATGCACAGAAGAGGTTACTCAA
GAGGAAGAATCCAATGGTGCCTCTGGTGAAGAATCACAGAGTCACGAAAAAAAGGATAGC
CATCTCAGCGTAGCAAACAATAAATTGGAACAAATGGACAAGAGAACTAAGTTAAAAAAA
AAAGAGAAAAAAAAG
PVX_003685
GAAGCGATGGAGGTGGGAGTAAAGGGGCAAGAGGAGAAACACCCCGAAGGGGTTATTCAA
GAGGAAAAAAACAGTGGCCCCCTCGGTGAAGAACCATCGAGTCACGAAAAAGGGGATAAC
CATCTCGGGGCAGCAAACAGTAAGTTGGGGCAAATAGACAAAAAAACGAAGTTAAAAAAA
AAGGAGAAGAAGAAG
PF3D7_0205100
GAAGAGGAAAATATTTTATATAAGGAGGAGCATAAGGATGAAGAGGAAAACATTTTATAT
AAGGAGGAGGAAAATAAGGATATTCATAAGGAAGAAGAGGCAGATGATGATGATGATGAT
GAAGATGGAAAGGAAAATGTGAGTATAGATAATGTAGAAAAGAAGGAAAACAATGTTTCT
AATGAAAAAAAAAAA
```

#### ağaç dosyası


tree.txt
```bash
(((2,(3,1)),6),5,4);
```

#### codeml yürütmek
NEOGENE üzerinde PAML bonobo, chimp ve macaque sunucularında yüklü.

 codeml.sh
 ```bash
#!/bin/bash -l
#SBATCH -p chimp
#SBATCH -n 1
#SBATCH -t 1-00:00:00
#SBATCH -J codeml
#SBATCH -o slurm-%j-%N-%u.out
#SBATCH -e slurm-%J-%N-%u.err

codeml=/usr/local/sw/paml4.9e/bin/codeml
controlfile=/mnt/NEOGENE1/home/${username}/codeml/codeml-M1278.ctl

$codeml $controlfile

```

### Sonuçların yorumlandırılması

Yürüdükten sonra paml bize çeşitli output dosyaları veriyor. 

Bu doslayarda control dosyasında verdiğimiz out dosyası log likelihood değerlerini içeriyor. 

Yürüttüğümüz farklı modellerin değerleri için

```bash
grep lnL mlc-M1278
```

χ 2 = 2×(Model1_loglikelihood + model2_loglikelihood)
