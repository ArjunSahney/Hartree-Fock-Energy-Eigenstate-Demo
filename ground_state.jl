using Quiqbox

# Define the nuclear configuration of the H2 molecule
nuc = ["H", "H"]
bond_length = 3.0  
nucCoords = [[-bond_length/2, 0.0, 0.0], [bond_length/2, 0.0, 0.0]]

# Generate basis set
bs = genBasisFunc.(nucCoords, "STO-3G", nuc) |> flatten

# Mark params for optimization
pars = markParams!(bs, true)

# Optimize the marked parameters
isConverged, Es = optimizeParams!(pars, bs, nuc, nucCoords, POconfig(maxStep=10))

# Run the RHF calculation with the optimized basis set
resRHF_opt = runHF(bs, nuc, nucCoords)

# Print the RHF results with the optimized basis set
println("RHF Results (Optimized Basis Set):")
println("Hartree–Fock Energy: ", resRHF_opt.Ehf)
println("Coefficient Matrix: ", resRHF_opt.C)
println("Orbital Energies: ", resRHF_opt.Eo)
println("Occupation Numbers: ", resRHF_opt.occu)

# Define the SCF configuration for UHF
SCFc = SCFconfig()
HFc = HFconfig(HF=:UHF, C0=:GWH, SCF=SCFc)

# Run the UHF calculation with the optimized basis set
resUHF_opt = runHF(bs, nuc, nucCoords, HFc)

# Printing UHF results
println("\nUHF Results (Optimized Basis Set):")
println("Hartree–Fock Energy: ", resUHF_opt.Ehf)
println("Coefficient Matrix: ", resUHF_opt.C)
println("Orbital Energies: ", resUHF_opt.Eo)
println("Occupation Numbers: ", resUHF_opt.occu)

# Create a MatterByHF object in case you need further data processing
mol_opt = MatterByHF(resRHF_opt)