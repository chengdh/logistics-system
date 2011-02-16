module RefoundsHelper
  #票据状态
  def refound_states_for_select
    Refound.state_machine.states.collect{|state| [state.human_name,state.value] }
  end

end
