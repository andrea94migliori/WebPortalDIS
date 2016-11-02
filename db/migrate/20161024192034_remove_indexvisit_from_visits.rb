class RemoveIndexvisitFromVisits < ActiveRecord::Migration
  def change
      remove_index :visits, name: 'index_visits_on_idVisit'
  end
end
