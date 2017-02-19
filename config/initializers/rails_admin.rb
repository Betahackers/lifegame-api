RailsAdmin.config do |config|

  ### Popular gems integration

  ## == Devise ==
  # config.authenticate_with do
  #   warden.authenticate! scope: :user
  # end
  # config.current_user_method(&:current_user)

  ## == Cancan ==
  # config.authorize_with :cancan

  ## == Pundit ==
  # config.authorize_with :pundit

  ## == PaperTrail ==
  # config.audit_with :paper_trail, 'User', 'PaperTrail::Version' # PaperTrail >= 3.0.0

  ### More at https://github.com/sferik/rails_admin/wiki/Base-configuration

  ## == Gravatar integration ==
  ## To disable Gravatar integration in Navigation Bar set to false
  # config.show_gravatar true

  config.actions do
    dashboard # mandatory
    index # mandatory
    new
    export
    bulk_delete
    show
    edit
    delete

    ## With an audit adapter, you can add:
    # history_index
    # history_show
  end


  %w(Answer Card Ending Point).each do |imodel|
      config.model "#{imodel}" do
        list do
          exclude_fields :updated_at
          exclude_fields :created_at
        end
      end
    end

  config.excluded_models << "Game"
  config.label_methods << :text

  config.model 'Card' do
    list do
      exclude_fields :image_url
    end
    edit do
      exclude_fields :image_url
      exclude_fields :answers
    end
    weight -100
  end
  config.model 'Answer' do
    list do
      field :card
      field :kind
      field :text
      field :points
      exclude_fields :id
    end
    weight -80

  end
  config.model 'Point' do
    edit do
      field :answer do
        read_only true
      end
      field :slug do
        read_only true
      end
      field :value
    end
    weight -50

  end



  config.authenticate_with do
    authenticate_or_request_with_http_basic('Site Message') do |username, password|
      username == 'myrandomstory' && password == ENV['ADMIN_PASSWORD']
    end
  end

end