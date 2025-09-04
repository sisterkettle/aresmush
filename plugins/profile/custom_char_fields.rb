module AresMUSH
  module Profile
    class CustomCharFields
      
      # Return a hash of custom fields formatted for display
      # Note: Viewer may be nil if someone's looking at the character page without being logged in
      # Example: return { goals: Website.format_markdown_for_html(char.goals) }
      def self.get_fields_for_viewing(char, viewer)
        return { advantages: Website.format_markdown_for_html(char.advantages), personality: Website.format_markdown_for_html(char.personality)}
      end
    
      # Return a hash of custom fields formatted for editing in the profile editor
      # Example: return { goals: Website.format_input_for_html(char.goals) }
      def self.get_fields_for_editing(char, viewer)
        return {}
      end

      # Return a hash of custom fields formatted for editing in chargen
      # Example: return { goals: Website.format_input_for_html(char.goals) }
      def self.get_fields_for_chargen(char)
        return { advantages: Website.format_input_for_html(char.advantages), personality: Website.format_input_for_html(char.personality)}
      end
      
      # Custom fields will be in char_data[:custom]
      # Example: char.update(goals: char_data[:custom][:goals])
      def self.save_fields_from_profile_edit(char, char_data)
        
      end
      
      # Save fields and return an array of any error messages.
      # Note Custom fields will be in chargen_data[:custom]
      # Example: char.update(goals: chargen_data[:custom][:goals])
      def self.save_fields_from_chargen(char, chargen_data)
        char.update(advantages: chargen_data['custom']['advantages'])
        char.update(personality: chargen_data['custom']['personality'])
        return []
      end
      # Saves fields from profile editing.
      #
      # @param [Character] char - The character being updated.
      # @param [Character] enactor - The character triggering the update.
      # @param [Hash] char_data - A hash of character fields and values. Your custom fields
      #    will be in char_data['custom']. Multi-line text strings should be formatted for MUSH.
      #
      # @return [Array] - A list of error messages. Return an empty array ([]) if there are no errors.
      # @example
      #        char.update(goals: Website.format_input_for_mush(char_data['custom']['goals']))
      #        return []
      def self.save_fields_from_profile_edit2(char, enactor, char_data)
        # By default, this calls the old method for backwards compatibility. The old one didn't
        # use enactor. Replace this with your own code.
        return CustomCharFields.save_fields_from_profile_edit(char, char_data)
      
    end
  end
end
