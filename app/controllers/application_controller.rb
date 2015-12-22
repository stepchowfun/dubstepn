include ApplicationHelper

class ApplicationController < ActionController::Base
  before_action :fix_protocol_and_host, :set_caching_headers

  private
    # use this instead of request.protocol to get the protocol.
    # if the user makes an HTTPS request, CloudFlare will translate that
    # into an HTTP request to the Rails server, so request.protocol will
    # be incorrect. this method accounts for that.
    def get_protocol
      # from cloudflare
      if request.headers['Cf-Visitor']
        cf_scheme = JSON.parse(request.headers['Cf-Visitor'])['scheme'].downcase
        if cf_scheme
          return "#{cf_scheme}://"
        end
      end

      return request.protocol
    end

    # use this method to disable caching for the browser, CDN, and any other routers.
    # for example, when the user is logged in, we don't want to cache anything that
    # is meant only for them.
    def disable_caching
      # set some headers to disable caching
      response.headers['Cache-Control'] = 'no-cache, no-store, max-age=0, must-revalidate'
      response.headers['Expires'] = 'Fri, 01 Jan 1990 00:00:00 GMT'
      response.headers['Pragma'] = 'no-cache'

      # allow cookies (in case enable_caching turned them off)
      request.session_options[:skip] = false
    end

    # use this method to enable caching for the browser, CDN, and any other routers.
    # for example, public pages should be cached so we don't have to render them every
    # time.
    def enable_caching
      # undo anything set by disable_caching
      response.headers.delete('Cache-Control')
      response.headers.delete('Expires')
      response.headers.delete('Pragma')

      # cache for 1 hour
      expires_in 1.hour, :public => true

      # don't cache cookies
      request.session_options[:skip] = true
    end

    # this method (used as a before_action) ensures that the protocol and host are correct
    def fix_protocol_and_host
      if Rails.env.production? && (get_protocol != APP_PROTOCOL || request.host != APP_HOST)
        # don't cache the redirection (otherwise might get infinite redirect loop)
        disable_caching

        redirect_to normalize_path(request.fullpath, :force_absolute => true), :status => 301
      end
    end

    # return whether the user is logged in
    def is_logged_in
      return !!(session[:login_time] && session[:login_time].to_datetime.advance(:hours => 12) >= DateTime.now)
    end

    # cache for 1 hour
    # used as a before action
    def set_caching_headers
      if is_logged_in || !request.get?
        disable_caching
      else
        enable_caching
      end
    end
end
