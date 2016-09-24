module AresMUSH
  module Rooms
    class WorkCmd
      include CommandHandler
      include CommandRequiresLogin
      include CommandWithoutArgs

      def check_work_set
        return t('rooms.work_not_set') if client.char.work.nil?
        return nil
      end
      
      def check_can_go_work
        return t('dispatcher.not_allowed') if !Rooms.can_go_home?(client.char)
        return nil
      end
      
      def handle
        char = client.char
        char.room.emit_ooc t('rooms.char_has_gone_work', :name => char.name)
        Rooms.move_to(client, char, char.work)
      end
    end
  end
end
