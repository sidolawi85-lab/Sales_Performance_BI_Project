// Create a numeric column to sort weekdays in proper order (Mon → Sun)
DayOrder =
SWITCH(
    TRUE(),  // Evaluate conditions sequentially
    'Turnover October 2025'[day] = "MON", 1,   // Monday = 1
    'Turnover October 2025'[day] = "TUE", 2,   // Tuesday = 2
    'Turnover October 2025'[day] = "WED", 3,   // Wednesday = 3
    'Turnover October 2025'[day] = "THU", 4,   // Thursday = 4
    'Turnover October 2025'[day] = "FRI", 5,   // Friday = 5
    'Turnover October 2025'[day] = "SAT", 6,   // Saturday = 6
    'Turnover October 2025'[day] = "SUN", 7    // Sunday = 7
)
