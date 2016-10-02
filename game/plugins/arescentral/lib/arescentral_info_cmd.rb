module AresMUSH
  module AresCentral
    class AresCentralInfoCmd
      include CommandHandler
      include CommandRequiresLogin
      
      def check_can_manage
        return t('dispatcher.not_allowed') if !Manage::Api.can_manage_game?(enactor)
        return nil
      end
            
      def handle
        text = "#{t('arescentral.game_id')} #{Game.master.api_game_id}"
        text << "%R#{t('arescentral.api_key')} #{Game.master.api_key}"
        client.emit BorderedDisplay.text text
      end      
    end
  end
end