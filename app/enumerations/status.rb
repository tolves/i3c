class Status < Enumerations::Base
  values pending: { name: 'Pending' }, confirmed: { name: 'Confirmed' }, shipped: { name: 'Shipped' }, delivered: { name: 'Delivered' }, finished: { name: 'Finished' }
end