class HomeController < ApplicationController

  def sitemap
    @offers = Offer.where(active: true).pluck(:id, :updated_at)
    respond_to do |format|
        format.xml { render layout: false }
        format.txt { render layout: false }
    end
  end


  def show
  end


  def explain
  end

  def logincheck
    respond_to do |format|
      format.json do
        if current_user
          # email msg notification
          # if user is logged in and emailmsgnotification is not nil
          # then set it nil
          User.find(current_user.id).update(emailmsgnotification: nil) if current_user.emailmsgnotification != nil
          # this switch checks user login status, dependent from
          # the last time the script ran
          # to save db traffice the update value is set in the future :)
          current_user.update(updated_at: (Time.now + 6.seconds)) if current_user.updated_at < Time.now
          data = true # current_user is a global helper_method in ApplicationController
          render(json: data)
        else
          data = false # current_user is a global helper_method in ApplicationController
          render(json: data)
        end
      end
    end
  end

  def login
    redirect_to offers_overview_path if current_user
  end

  def agbdatenschutz
  end

  def impressum
  end

end
