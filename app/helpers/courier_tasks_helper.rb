module CourierTasksHelper

  STATUS_LIST = [
    ["Создана","created", "orange"],
    ["Получена","accepted", "blue"],
    ["Выполнена","complete", "green"],
    ["Завершена","finished", "gray"],
  ]


  def human_attribute(attr)
    CourierTask.human_attribute_name(attr)
  end
  
  def task_statuses
    STATUS_LIST.map { |e| e[0..1] }
  end
  def human_status(n)
    STATUS_LIST.select { |e| e[1] == n }.first[0]
  end
  def color_status(n)
    STATUS_LIST.select { |e| e[1] == n }.first[2]
  end
end
