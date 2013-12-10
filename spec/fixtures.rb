# coding: us-ascii

module Module::Mixy::RspecHelpers
  Ancestor = Module.new do
    def public_func
      :ret_public_func_on_ancestor
    end

    def not_want_public_func
      :ret_not_want_public_func_on_ancestor
    end
  end

  HasPublicAndPrivate = Module.new do
    include Ancestor
    
    def public_func
      :ret_public_func_on_has_public_and_private
    end

    private

    def private_func
      :ret_private_func_on_has_public_and_private
    end
  end

  HasPublic = Module.new do
    def public_func
      :ret_public_func_on_has_public
    end
  end

  HasPrivate = Module.new do
    private

    def private_func
      :ret_private_func_on_has_private
    end
  end
end