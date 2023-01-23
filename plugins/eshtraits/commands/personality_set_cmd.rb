module AresMUSH
    module ESHTraits
        class SetPersonalityCmd
            include CommandHandler

            attr_accessor :name, :personality

            def parse_args
                if (cmd.args =~ /.+=.+/)
                    args = cmd.parse_args(ArgParser.arg1_equals_arg2)

                    self.name = titlecase_arg(args.arg1)
                    self.personality = args.arg2

                else

                    self.name = enactor_name
                    self.personality = cmd.args
                end
            end

            def required_args
                [ self.name, self.personality ]
            end

            def handle 
                ClassTargetFinder.with_a_character(self.name, client, enactor) do |model|
                    if (enactor.name == model.name && !Chargen.check_chargen_locked(enactor))
                        model.update(personality: self.personality)
                        client.emit_success t('eshtraits.personality_set')
                    elsif (Chargen.can_approve?(enactor))
                        model.update(personality: self.personality)
                        client.emit_success t('eshtraits.personality__set')
                    else
                        client.emit_failure t('dispatcher.not_allowed')
                    end
                end
            end
        end
    end
end

