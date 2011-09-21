#!/usr/local/bin/ruby
#
# Bereken vanuit je bruto, je sociale zekerheid en je netto
#
# Usage: ./belastingen.rb 30000

jaarloon = ARGV.first.to_i
vapz = [jaarloon*0.0817, 2853].min
vjaarloon = jaarloon - vapz
sociaal = jaarloon*0.22
vsociaal = vjaarloon*0.22
bruto = jaarloon-sociaal
vbruto = vjaarloon-vsociaal
vrijstelling = 6430

def belasting(bruto)

  bar1 = 7900
  bar2 = 11240
  bar3 = 18730
  bar4 = 34330

  schijf1 = [bruto, bar1].min
  schijf2 = [0, [bruto, bar2].min - bar1].max
  schijf3 = [0, [bruto, bar3].min - bar2].max
  schijf4 = [0, [bruto, bar4].min - bar3].max
  schijf5 = [0, bruto-bar4].max

  belastingen = schijf1*0.25 +
                schijf2*0.30 + 
                schijf3*0.40 + 
                schijf4*0.45 +
                schijf5*0.50
  belastingen
end

last = belasting(bruto) - belasting(vrijstelling)
vlast = belasting(vbruto) - belasting(vrijstelling)
netto = bruto - last
vnetto = vbruto - vlast

puts "Without VAPZ:"
puts "  Jaarloon: #{jaarloon} (#{jaarloon/12} p/m)"
puts "  Sociale zekerheid (22%): #{sociaal}"
puts "  Bruto (Jaarloon - Sociale zekerheid): #{bruto}"
puts "  Personenbelasting: #{last} (#{last/12} p/m)"
puts "  ---------------------------------"
puts "  Netto: #{netto} (#{netto/12} p/m)"
puts
puts "With VAPZ (#{vapz}):"
puts "  Jaarloon: #{vjaarloon} (#{vjaarloon/12} p/m)"
puts "  Sociale zekerheid (22%): #{vsociaal}"
puts "  Bruto (Jaarloon - Sociale zekerheid): #{vbruto}"
puts "  Personenbelasting: #{vlast} (#{vlast/12} p/m)"
puts "  ---------------------------------"
puts "  Netto: #{vnetto} (#{vnetto/12} p/m) + #{vapz} = #{vnetto+vapz} (+#{vnetto+vapz-netto})"
puts
puts "Estonia:"
puts "  Sociale zekerheid (33%): #{jaarloon*0.33}"
puts "  Personenbelasting (20%): #{jaarloon*0.67*0.2}"
puts "  Netto: #{jaarloon*0.67*0.8}"
