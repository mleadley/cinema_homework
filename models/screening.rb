require_relative "cinema_model"
require_relative "../db/sql_runner"

class Screening < CinemaModel
  @table = "screenings"
  @columns = ["id", "film_id", "date_time", "available_tickets"]

  attr_reader :id
  attr_accessor :film_id, :date_time, :available_tickets

  def initialize(options)
    set_instance_variables(options)
  end

  def remove_ticket
    avail_int = @available_tickets.to_i
    return false if avail_int <= 0
    @available_tickets = avail_int - 1
    update
    return true
  end

  def film
    sql = "SELECT * FROM films WHERE id = $1"
    result = SqlRunner.run(sql, [@film_id])
    return Film.new(result[0])
  end
end
