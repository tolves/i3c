class Status < Enumerations::Base
  values unpaid: { name: 'Unpaid' }, pending: { name: 'Pending' }, confirmed: { name: 'Confirmed' }, shipped: { name: 'Shipped' }, delivered: { name: 'Delivered' }, finished: { name: 'Finished' }
end