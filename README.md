# Quiqbox Example: Hartree-Fock Calculations for H2 Molecule

This example demonstrates how to use Quiqbox to run restricted closed-shell Hartree–Fock (RHF) and unrestricted open-shell Hartree–Fock (UHF) calculations for the H2 molecule. It also shows how to optimize the basis set parameters using Quiqbox's built-in functions `markParams!` and `optimizeParams!`.

The code defines the nuclear configuration of the H2 molecule with a bond length of 3.0 Angstrom, generates the STO-3G basis set, marks the basis set parameters for optimization, optimizes the marked parameters, runs the RHF and UHF calculations with the optimized basis set, and prints the results. Finally, it creates a `MatterByHF` object from the RHF results for further data processing if needed.


