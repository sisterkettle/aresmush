module AresMUSH
    module ESHTraits
        class AdvantagesCmd
            include CommandHandler

            attr_accessor :name, :advantages 

            def parse_args
                self.name = cmd.args || enactor_name
            end

            def handle 
                ClassTargetFinder.with_a_character(self.name, client, enactor) do |model|
                    template = BorderedDisplayTemplate.new model.advantages, "#{model.name}'s Advantages"
                    client.emit template.render
                end
            end
        end
    end
end