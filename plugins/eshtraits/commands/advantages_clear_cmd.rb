module AresMUSH
    module ESHTraits
        class ClearAdvantagesCmd
            include CommandHandler

            attr_accessor :name, :advantages 

            def parse_args
                self.name = cmd.args || enactor_name
            end

            def required_args
                [ self.name ]
            end

            def handle 
                ClassTargetFinder.with_a_character(self.name, client, enactor) do |model|
                    if (enactor.name == model.name && !Chargen.check_chargen_locked(enactor))
                        model.update(advantages: nil)
                        client.emit_success t('eshtraits.advantages_cleared')
                    elsif (Chargen.can_approve?(enactor))
                        model.update(advantages: nil)
                        client.emit_success t('eshtraits.advantages_cleared')
                    else
                        client.emit_failure t('dispatcher.not_allowed')
                    end
                end
            end
        end
    end
end