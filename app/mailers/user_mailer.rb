class UserMailer < ApplicationMailer
  default from: 'hallo@hitchi.de'
  def welcome_email(user, matches, seeks)
    if ENV["HITCHIMAILER"] == "production"
      @hitchiurl = "https://www.hitchi.de/mitfahrgelegenheit/"
    elsif ENV["HITCHIMAILER"] == "staging"
      @hitchiurl = "http://hitchi-staging.herokuapp.com/mitfahrgelegenheit/"
    else
      @hitchiurl = "http://localhost:3000/mitfahrgelegenheit/"
    end
    @user = user
    @matches = matches
    @seeks = seeks
    if @user.email
        mail(to: @user.email, subject: 'hitchi - diese Anzeigen könnten dir gefallen!')
    end
  end

  def msg_notification_email(user)
    @user = user
    if @user.email && @user.emailmsgnotification.nil? && @user.updated_at < (Time.zone.now - 1.minute)
      mail(to: @user.email, subject: 'hitchi.de - Du hast eine neue Nachricht')
      @user.update(emailmsgnotification: Time.zone.now)
    end
  end

  def notification_email(user, offer)
    if ENV["HITCHIMAILER"] == "production"
      @hitchiurl = "http://www.hitchi.de/mitfahrgelegenheit/"
    elsif ENV["HITCHIMAILER"] == "staging"
      @hitchiurl = "http://hitchi-staging.herokuapp.com/mitfahrgelegenheit/"
    else
      @hitchiurl = "http://localhost:3000/mitfahrgelegenheit/"
    end
    @user = user
    @offer = offer
    if @user.email
        mail(to: @user.email, subject: 'Mitfahrgelegenheit: ' + @offer.departurelocal + " nach " + @offer.destinationlocal + " - " + @offer.departuredate.strftime("%d.%m.%Y"))
    end
  end

end
