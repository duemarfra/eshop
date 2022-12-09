class ItemPolicy < BasePolicy
  def new
    Current.user.business?
  end

  def create
    Current.user.business?
  end

  def edit
    record.owner?
  end

  def update
    record.owner?
  end

  def destroy
    record.owner?
  end
end
