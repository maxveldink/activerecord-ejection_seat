# typed: true
# frozen_string_literal: true

module T
	module Private
		module Types
			class SimplePairUnion
				sig { params(attribute: T.untyped).void }
				def deserialize(attribute); end
			end
		end
	end
end
