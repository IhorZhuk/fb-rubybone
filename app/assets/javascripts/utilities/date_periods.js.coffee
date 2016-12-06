FamilyBudget.Utilities.Dates =

  getThisMonth: ->
    now = new Date()
    date =
      from: (new Date(now.getFullYear(), now.getMonth(), 1)).toUTCString()
      to: (new Date(now.getFullYear(), now.getMonth() + 1, 0)).toUTCString()
    

  getLastMonth: ->
    now = new Date()
    date = 
      from: new Date(now.getFullYear(), now.getMonth() - 1, 1)
      to: new Date(now.getFullYear(), now.getMonth(), 0)

  getThisWeek: ->
    now = new Date()
    date = 
      from: new Date(now.setDate(now.getDate() - now.getDay()))
      to: new Date(now.setDate(now.getDate() - now.getDay()+6));

  getLastWeek: ->
    now = new Date()
    date = 
      from: new Date(now.setDate(now.getDate() - now.getDay() - 7))
      to: new Date(now.setDate(now.getDate() - now.getDay() - 1));
    