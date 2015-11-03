require 'mechanize'

module MangaEdenRipper
  class Session
    attr_reader :agent
    extend Forwardable

    def_delegators :@agent, :get, :post

    def initialize(username:, password:)
      @username = username
      @password = password
      @agent = Mechanize.new
      login
    end

    def login
      # login_url = 'https://bato.to/forums/index.php?app=core&module=global&section=login'
      # login_form = agent.get(login_url).form(id: 'login')
      # login_form.field('ips_username').value = @username
      # login_form.field('ips_password').value = @password
      # login_form.submit
    end
  end

  def self.session
    @session ||= Session.new(
      username: ENV['MANGA_EDEN_USERNAME'],
      password: ENV['MANGA_EDEN_PASSWORD']
    )
  end
end
