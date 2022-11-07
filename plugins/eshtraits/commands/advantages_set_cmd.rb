module AresMUSH
    module ESHTraits
        class SetAdvantagesCmd
            include CommandHandler

            attr_accessor :name, :advantages 

            def parse_args
                if (cmd.args =~ /.+=.+/)
                    args = cmd.parse_args(ArgParser.arg1_equals_arg2)

                    self.name = titlecase_arg(args.arg1)
                    self.advantages = args.arg2

                else

                    self.name = enactor_name
                    self.advantages = cmd.args
                end
            end

            def required_args
                [ self.name, self.advantages ]
            end

            def handle 
                ClassTargetFinder.with_a_character(self.name, client, enactor) do |model|
                    if (enactor.name == model.name && !Chargen.check_chargen_locked(enactor))
                        model.update(advantages: self.advantages)
                        client.emit_success t('eshtraits.advantages_set')
                    elsif (Chargen.can_approve?(enactor))
                        model.update(advantages: self.advantages)
                        client.emit_success t('eshtraits.advantages_set')
                    else
                        client.emit_failure t('dispatcher.not_allowed')
                    end
                end
            end
        end
    end
end

