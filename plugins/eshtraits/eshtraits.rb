$:.unshift File.dirname(__FILE__)

module AresMUSH
    module ESHTraits

        def self.plugin_dir
            File.dirname(__FILE__)
        end

        def self.shortcuts
            Global.read_config("eshtraits", "shortcuts")
        end

        def self.get_cmd_handler(client, cmd, enactor)
            case cmd.root
            when "personality"
                case cmd.switch
                when "set"
                    return SetPersonalityCmd
                when "clear"
                    return ClearPersonalityCmd
                else 
                    return PersonalityCmd
                end
            when "advantages"
                case cmd.switch
                when "set"
                    return SetAdvantagesCmd
                when "clear"
                    return ClearAdvantagesCmd
                else
                    return AdvantagesCmd
                end
            when "sheet"
                return SheetCmd
            end
        end

        nil
    end
end
