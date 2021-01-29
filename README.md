# README

This is a web application that provides customisation services for gaming PC.

- Auto migration after deployment add buildpacks: https://github.com/gunpowderlabs/buildpack-ruby-rake-deploy-tasks
- set config vars: DEPLOY_TASKS db:migrate
- Set master key: RAILS_MASTER_KEY


- [x] Category view meta_data, edit, delete
- [x] Product view meta_data, edit, delete
- [x] Rich text editor
- [x] Users CRUD
- [x] update product quantity while check cart
- [x] polymorphic list, cart&order
- [x] AJAX: cart quantity change
- [x] cart: save to session if not logged in
- [x] welcome#index div#products overload with div#selected
- [x] image for product
- [x] welcome controller, ajax select components
- [x] Order CRUD
- [x] divide admin controllers&user controllers
- [x] Address validate(frontend)
- [x] amount price calculate
- [x] cancancan setting to all controllers
- [ ] statistics
- [ ] test cases
- [ ] Accessories
- [ ] filter for tables
- [ ] recommendation in index
- [x] Product Warehouse operation (fast inbound)
- [x] Product inventory - 1 when ordered (outbound)
- [ ] Account profile
- [ ] Orders statistics
- [ ] Order cancel, shipped status update
- [x] paypal sandbox
- [ ] email async
- [ ] update order information to paypal by api
- [x] replace inbound with inventory