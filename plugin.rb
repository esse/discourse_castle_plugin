# name: Castle Plugin
# about: Record pageviews in castle.io
# version: 0.0.1
# authors: Piotr Szmielew

register_javascript <<JS 

    Discourse.Router.reopen({
      sendCastleEvent: function() {
        (function(e,t,n,r){function i(e,n){e=t.createElement("script");e.async=1;e.src=r;n=t.getElementsByTagName("script")[0];n.parentNode.insertBefore(e,n)}e[n]=e[n]||function(){(e[n].q=e[n].q||[]).push(arguments)};e.attachEvent?e.attachEvent("onload",i):e.addEventListener("load",i,false)})(window,document,"_castle","//d2t77mnxyo7adj.cloudfront.net/v1/c.js")
        _castle('setAppId', '<%= SiteSetting.castle_api_key %>');
        _castle('identify', '<%= current_user.external_id %>');
        _castle('secure', '<% OpenSSL::HMAC.hexdigest('sha256', SiteSetting.castle_app_secret, current_user.external_id.to_s) %>');
        _castle('trackPageview');
      }.on('didTransition')
    }); 
    
JS