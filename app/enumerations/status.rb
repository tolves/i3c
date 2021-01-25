class Status < Enumerations::Base
  values unpaid: { name: 'Unpaid' }, paid: { name: 'Paid' }, confirmed: { name: 'Confirmed' }, shipped: { name: 'Shipped' }, delivered: { name: 'Delivered' }, finished: { name: 'Finished' }
end