module Spec
  module Integration
    module DSL
      include Spec::Integration::Matchers
      include NavigationExampleMethods
      include FormExampleMethods
      
      include ActionController::RecordIdentifier
      
      class IntegrationExample < Spec::Rails::Example::RailsExampleGroup # :nodoc:
        include Spec::Integration::DSL
        include ActionController::Integration::Runner
        
        def method_missing(sym, *args, &block)
          return Spec::Matchers::Be.new(sym, *args) if sym.starts_with?("be_")
          return Spec::Matchers::Has.new(sym, *args) if sym.starts_with?("have_")
          super
        end
        
        Spec::Example::ExampleGroupFactory.register(:integration, self)
      end
      
    end
  end
end