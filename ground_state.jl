using Quiqbox

# Set up the molecule
nuc = ["H", "H"]
bondLength = 3.0  # in Angstrom
nucCoords = [[-bondLength/2, 0.0, 0.0], [bondLength/2, 0.0, 0.0]]

# Run RHF optimization
bsRHF = genBasisFunc.(nucCoords, "STO-3G", nuc) |> flatten
parsRHF = markParams!(bsRHF)
isConvergedRHF, EsRHF = optimizeParams!(parsRHF, bsRHF, nuc, nucCoords)
resRHFopt = runHF(bsRHF, nuc, nucCoords)
println("Optimized RHF energy: ", resRHFopt.Ehf, " Ha")

# Run UHF optimization
bsUHF = genBasisFunc.(nucCoords, "STO-3G", nuc) |> flatten
parsUHF = markParams!(bsUHF)
poCfg = POconfig(maxStep=20, threshold=(1e-6, 1e-4))
hfCfg = HFconfig(HF=:UHF)
scfCfg = SCFconfig((:ADIIS, :DIIS), (1e-4, 1e-8), Dict(1=>[:solver=>:LBFGS]))
isConvergedUHF, EsUHF = optimizeParams!(parsUHF, bsUHF, nuc, nucCoords, 
                                        poCfg, getCharge(nuc), 
                                        printInfo=true, infoLevel=1)
resUHFopt = runHF(bsUHF, nuc, nucCoords, hfCfg, getCharge(nuc), printInfo=true, infoLevel=2)
println("Optimized UHF energy: ", resUHFopt.Ehf, " Ha")
