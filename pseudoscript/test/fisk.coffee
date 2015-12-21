# PseudoScript

sjön = [
    {art: 'gös', vikt: 1.3, insjöfisk: true, rutten: true}
    {art: 'aborre', vikt: 0.8, insjöfisk: true, rutten: false},
    {art: 'gädda', vikt: 3.2, insjöfisk: false, rutten: false}
]

for fisk in sjön

  # kinda pseudo
  console.log ''
  console.log fisk.art

  # pseudo++
  console.log fisk.vikt

  # conditions
  if fisk.vikt > 1
    console.log "Stor fisk"
  else
    console.log "Liten fisk"

  if fisk.rutten then console.log "Släng den!" else console.log "Spisa med behag!"

# Functions
begränsa = (vikt, max) ->
  if vikt > max
      return 3
  else
      return vikt

fisk =
    art: 'torsk'
    vikt: 4

console.log('')
console.log  begränsa fisk.vikt ,  3
console.log fisk.vikt * 2 + 3

temperaturen = 24
väder =
    fint: true
    varmt: if temperaturen > 20 then true else false

console.log "Väderrapport: "
if väder.fint and väder.varmt then console.log "Ut and njut in solen!" else console.log "Nog bäst att stanna inne idag."

###
kastade = 'Kjell'
console.log "vem var det som kasta?"
console.log  kastade
###

