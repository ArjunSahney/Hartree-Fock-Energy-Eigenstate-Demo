using Quiqbox

# Define the nuclear configuration of the H2 molecule
nuc = ["H", "H"]
bond_length = 3.0 # Angstrom
nucCoords = [[-bond_length/2, 0.0, 0.0], [bond_length/2, 0.0, 0.0]]

# Generate the basis set for the H2 molecule
bs = genBasisFunc.(nucCoords, "STO-3G", nuc) |> flatten

# Run the RHF calculation
resRHF = runHF(bs, nuc, nucCoords)

# Print the RHF results
println("RHF Results:")
println("Hartree–Fock Energy: ", resRHF.Ehf)
println("Coefficient Matrix: ", resRHF.C)
println("Orbital Energies: ", resRHF.Eo)
println("Occupation Numbers: ", resRHF.occu)

# Define the UHF configuration
HFc_UHF = HFconfig(HF=:UHF)

# Run the UHF calculation
resUHF = runHF(bs, nuc, nucCoords, HFc_UHF)

# Print the UHF results
println("\nUHF Results:")
println("Hartree–Fock Energy: ", resUHF.Ehf)
println("Coefficient Matrix: ", resUHF.C)
println("Orbital Energies: ", resUHF.Eo)
println("Occupation Numbers: ", resUHF.occu)

# Create a MatterByHF object for further data processing
mol = MatterByHF(resRHF)
