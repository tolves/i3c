class Couriers < Enumerations::Base
  values AN_POST: { name: 'An Post' }, DHL: { name: 'DHL' }, FEDEX: { name: 'FEDEX' }, TNT: { name: 'TNT' }, UPS: { name: 'UPS' }, DPD: { name: 'DPD' }, FASTWAY: { name: 'FASTWAY' }, NIGHTLINE: { name: 'NIGHTLINE' }, OTHER: { name: 'OTHER' }
end