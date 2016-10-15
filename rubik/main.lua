
-- indices -> estado
function indices_para_estado(i)
	return {
		pQuinas = indice_para_permutacao(i.pQuinas, 8),
		oQuinas = indice_para_orientacao(i.oQuinas, 3, 8),
		pMeios = indice_para_permutacao(i.pMeios, 12),
		oMeios = indice_para_orientacao(i.oMeios, 2, 12),
	}
end
function mul(e, movimento)
	return {
		pQuinas = pQuinasTrans[e.pQuinas][movimento],
		oQuinas = oQuinasTrans[e.oQuinas][movimento],
		pMeios = pMeiosTrans[e.pMeios][movimento],
		oMeios = oMeiosTrans[e.oMeios][movimento],
	}
end
movimentos = {
	["U"] = { pQuinas = { ... }, oQuinas = { ... }, ... },
	["U2"] = { pQuinas = { ... }, oQuinas = { ... }, ... },
	["U’"] = { pQuinas = { ... }, oQuinas = { ... }, ... },
	... },
	["B2"] = { pQuinas = { ... }, oQuinas = { ... }, ... },
	["B’"] = { pQuinas = { ... }, oQuinas = { ... }, ... },
}

oQuinasTrans = {}
for i = 0, 3^8 - 1 do
	local estado = indices_para_estado({ oQuinas = i })

	oQuinasTrans[i] = {}
	for nome, mov in pairs(movimentos) do
		oQuinasTrans[i][nome] =
		estado_para_indices(mul(estado, mov)).oQuinas
	end
end
iId = estado_para_indices(id)

quinasDist = {}
quinasDist[iId.pQuinas][iId.oQuinas] = 0

local distancia = 0
local visitados = 0
while visitados < 8! * 3^7 do
	for i = 0, 8! - 1 do
		for j = 0, 3^7 - 1 do
			if quinasDist[i][j] == distancia then
				for nome, _ in pairs(movimentos) do
					local pProx = pQuinasTrans[i][nome]
					local oProx = oQuinasTrans[j][nome]
					if not quinasDist[pProx][oProx] then
						quinasDist[pProx][oProx] = distancia + 1
						visitados = visitados + 1
					end
				end
			end
		end
	end
end
function solucao(e)
	for i = 0, inf do
		local sol = {}
		if busca(e, i, sol) then
			return sol
		end
	end
end

function busca(e, prof, sol)
	if prof == 0 then
		return i == iId
	end

	if quinasDist[e.cQuinas][e.pQuinas][e.oQuinas] > prof or
		meios1Dist[e.cMeios1][e.pMeios1][e.oMeios1] > prof or
		meios2Dist[e.cMeios2][e.pMeios2][e.oMeios2] > prof then
		return false
	end

	for nome, _ in pairs(movimentos) do
		table.insert(sol, nome)
		if busca(mul(e, nome), prof - 1, sol) then

			return true
		end
		table.remove(sol)
	end
end
