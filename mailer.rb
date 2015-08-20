require 'mail'
 
class Mailer
  DISTRO_LIST = ["blake41@gmail.com", "steven.nunez@gmail.com", "joemburgess@gmail.com"]
  attr_reader(:options)

  def initialize
    # :domain               => 'your.host.name',
    @options = { :address              => "smtp.gmail.com",
            :port                 => 587,
            :user_name            => ENV['USERNAME'],
            :password             => ENV['GOOGLE_PASS'],
            :authentication       => 'plain',
            :enable_starttls_auto => true  }
    set_mail_defaults
  end

  def set_mail_defaults
    options = self.options
    Mail.defaults do
      delivery_method :smtp, options
    end
  end

  def send_to_distro(body_text, subject_text)
    DISTRO_LIST.each do |client|
      send(client, body_text, subject_text)
    end
  end

  def send(to_client, body_text, subject_text)
    Mail.deliver do
           to(to_client)
         from 'blake41@gmail.com'
      subject(subject_text)
         body(body_text)
    end
  end

end