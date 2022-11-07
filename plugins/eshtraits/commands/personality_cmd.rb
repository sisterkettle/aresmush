module AresMUSH
    module ESHTraits
        class PersonalityCmd
            include CommandHandler

            attr_accessor :name, :personality

            def parse_args
                self.name = cmd.args || enactor_name
            end

            def handle 
                ClassTargetFinder.with_a_character(self.name, client, enactor) do |model|
                    template = BorderedDisplayTemplate.new model.personality, "#{model.name}'s Personality"
                    client.emit template.render
                end
            end
        end
    end
end
