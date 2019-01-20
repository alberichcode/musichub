class HomeController < ApplicationController
  skip_before_action :authenticate_tenant!, :only => [ :index ]
  def index
    redirect_to shots_path if current_user
    if current_user

      if session[:tenant_id]
        Tenant.set_current_tenant session[:tenant_id]
      else
        Tenant.set_current_tenant current_user.tenants.first
      end
      @tenant = Tenant.set_current_tenant
      params[:tenant_id] = @tenant.id

    end


  end
end
