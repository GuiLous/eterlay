module Authenticatable
  extend ActiveSupport::Concern

  def authenticate_user!
    raise GraphQL::ExecutionError, "Você precisa estar logado para realizar esta ação" unless context[:current_user]
  end
end
