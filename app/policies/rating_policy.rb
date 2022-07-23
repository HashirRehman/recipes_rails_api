class RatingPolicy < ApplicationPolicy
  def index?
    true
  end

  def show?
    true
  end

  def create?
    true
  end

  def update?
    record.user_id == user.id
  end

  def delete?
    record.user_id == user.id
  end
end
