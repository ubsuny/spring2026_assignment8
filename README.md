---
geometry:
- margin=1.25in
mainfont: Palatino
header-includes: 
- \usepackage[document]{ragged2e}
---

# Assignment 8

### Instructions
- PHY411: Do problems 1–3
- PHY 506: Do problems 1-3 (harder versions)

Accept the assignment from github classroom: https://classroom.github.com/a/tK--iBmU. This will create a new repository for you on github, titled something like `compphys-assignment8-username`.
You should submit your code through github classroom, and your writeup through UBLearns. If you prefer, you can do your writeup "in-line" in your notebooks (using Markdown cells), convert the notebook to HTML/PDF/etc., and upload the converted notebooks.


\newpage


## Problem 1: Helium atom with LCAO
*25 points*

Similarly to the hydrogen atom we studied in class, compute the first two energy eigenvalues for the helium atom with the LCAO (linear combination of atomic orbitals) method, using combinations of gaussian functions as the trial wavefunctions. 

Do your work in `Problem1/Problem1.ipynb`.

\newpage


## Problem 2: Variational MC
*25 points*

In class, we used variational MC to find the ground state of the quantum harmonic oscillator. Adapt the QHO example to the case of:

- PHY411 students: hydrogen atom
- PHY506 students: helium atom.

Specifically, compute the energy of the spherically symmetric ground state, and plot the wave function as a function of radius ($r$). 
Be careful about "cusp" positions! 

Do your work in `Problem2/Problem2.ipynb`. 

\newpage

## Problem 3: Z boson production


Consider the process of dilepton production at the Large Hadron Collider:

$$
pp \rightarrow Z \rightarrow e^+ e^-
$$

where $p$ denotes the incoming protons, $Z$ is the $Z$ boson, and $e^{\pm}$ are electrons and positrons. Using the VEGAS algorithm for integration, compute: (a) the differential cross section as a function of $\cos\theta$ (or equivalently, $\eta=-\ln(\tan(\theta/2))$) (15 points) and (b) the total cross section (10 points). 

In class, we covered a simpler version of this process, $e^+e^- \rightarrow Z \rightarrow e^+e^-$. To adapt the in-class computation, we have to account for the composite nature of the proton by integrating (incoherently) over the set of initial state particles inside the proton, aka the "partons." Specifically:

- PHY411 students: consider only up quark/antiquarks in the initial state.
- PHY506 students: consider up, down, and strange quark/antiquarks in the initial state.

### Details

The center-of-mass collision energy of the proton-proton system is $s=(p_i+p_j)^2=(E_i+E_j)^2 - (\vec{p}_i +\vec{p}_j)^2$, where $p_{i,j}$ are the 4-momenta, $E_{i,j}$ are the energies, and $\vec{p}_{i,j}$ are the 3-momenta of the two protons. Let's assume $s=7\,\text{TeV}$ (the LHC energy in 2011). 

However, any given collision involves two partons from each proton, and thus the energy corresponds to only a fraction of $s$. Recall that $x_1$ and $x_2$ denote the momentum fractions of the partons. The 4-momenta of the partons is given by $x_i p_i$, and the actual collision energy is $\hat{s} = x_1 x_2 s < 7\,\text{TeV}$. 

#### Equation 1

The "master formula" for the parton-level differential cross section (already written in the starter code!) is:

$$
\frac{d\sigma}{d\Omega} = \frac{N^{\text{final}}_c}{N^{\text{initial}}_c} \frac{1}{256\pi^2 \hat{s}} \frac{\hat{s}^2}{(\hat{s}-M_Z^2)^2 + \hat{s} \Gamma_Z} \left[ (L^2+R^2)(L'^2+R'^2)(1+\cos\theta) + (L^2-R^2)(L'^2-R'^2) 2 \cos\theta \right]
$$

where:

- $M_Z=91.1876\,\text{GeV}$ is the mass of the $Z$ boson;
- $\Gamma_Z=2.4952\,\text{GeV}$ is the decay width of the $Z$ boson;
- $\sin^2\theta_W=0.22305$ = weak mixing angle (mixing angle between photon and $Z$ boson);
- $G_F=1.1663787\times 10^{-5}\,\text{GeV}^{-2}$ = Fermi constant;
- $N_c^{\text{initial,final}}$ are the number of colors of the partons in the initial or final state;
   - The initial state is quarks, so $N_c^{\text{initial}}=3$
   - The final state is electrons, so $N_c^{\text{final}}=1$
- $L,R$ are functions of the initial state particles, and $L',R'$ are functions of the final state particles, given by:
   - $L = \sqrt{\frac{8G_F m_Z^2}{\sqrt{2}}} (T_3 - \sin^2\theta_W Q)$
   - $R = -\sqrt{\frac{8G_Fm_Z^2}{\sqrt{2}}} \sin^2\theta_W Q$
      - $T_3$ = weak isospin operator
      - $Q$ = charge operator.

Important: this is the differential cross section for fixed collision energy, $\hat{s}$. For proton-proton collisions, $x_1$ and $x_2$ are not in our control (i.e., they are random numbers), so this formula is not terribly useful by itself. We have to average over the parton distribution functions. 

#### Equation 2

The momentum fractions $x_1$ and $x_2$ follow probability distributions called **parton distribution functions**. These are empirically determined from a combination of experimental measurements (notably electron-proton colliders, but also some proton-proton collider measurements) and perturbative QCD methods. We will use the so-called "MSTW 2008 parton distribution functions." 

The formula for averaging over the parton distribution functions is:

$$
\frac{d\sigma}{d\Omega} = \sum_{a_1,a_2} \int_0^1 dx_2 \int_0^1 dx_1 f_{a_1}^{h_1}(x_1,M^2) f_{a_2}^{h_2}(x_2,M^2) E_Q \frac{d\sigma^{a_1a_2}}{d^3 Q}(x_1 p_1,x_2p_2, M^2)
$$

where:

- $a_{1,2}$ are the indices of the incoming parton species (i.e., the sum accounts for the possible initial states: up quark/antiquarks, down quark/antiquarks, strange quark/antiquarks, ...);
- $p_{1,2}$ are the 4-momenta of the incoming protons (equal and opposite, each carries half the total energy $s=7\,\text{TeV}$, momentum is along the $z$ direction);
- $f_{a_i}^{h_i}(x,M^2)$ are the MSTW parton distribution functions for each parton species $a_i$ within the composite particle $h_i$ (here, $h_i$ is always a proton, so you can ignore it);
- $x_{1,2}$ are the fractions of the proton momentum carried by that parton;
- $\frac{d\sigma}{d^3 Q}$ is the parton-level differential cross section, given by Equation 1. 

Hint: the mass of the $Z$ boson is very small compared to the total collision energy, and the parton distribution functions are strongly peaked at low values of $x_i$. Plan your phase space accordingly, and watch out for divergences. 


