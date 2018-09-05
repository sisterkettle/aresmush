module AresMUSH
  module Channels
    class ChatTalkRequestHandler
      def handle(request)
        enactor = request.enactor
        channel = Channel.find_one_by_name(request.args[:channel])
        message = request.args[:message]
        
        if (!enactor)
          return { error: t('webportal.login_required') }
        end
        
        error = Website.check_login(request)
        return error if error
                
        if (!channel)
          return { error: t('webportal.not_found') }
        end

        options = Channels.get_channel_options(enactor, channel)
        message = Channels.pose_to_channel channel, enactor.name, message, options.title   
        
        {
          message: Website.format_markdown_for_html(message)
        }
      end
    end
  end
end


