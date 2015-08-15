Deface::Override.new(
  :virtual_path => 'spree/admin/shared/_menu',
  :name => 'add_spree_delayed_job_to_admin_tabs',
  :insert_bottom => "[data-hook='admin_tabs']",
  :text => %q{
    <%= tab :batch_jobs, :route => :admin_delayed_jobs %>
  })

