class InvitationsController < Devise::InvitationsController

    skip_before_action :resource_from_invitation_token, only: [:edit]
    before_action :scoped_resource_from_invitation_token, only: [:edit]

    private
    def scoped_resource_from_invitation_token

        unless params[:invitation_token] && self.resource = User.find_by_invitation_token(params[:invitation_token], true)
            set_flash_message(:alert, :invitation_token_invalid) if is_flashing_format?
            redirect_to after_sign_out_path_for(resource_name)
        end

    end

end
