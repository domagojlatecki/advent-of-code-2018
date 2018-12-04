using System;
using System.Linq;
using System.Collections.Generic;
using System.Text.RegularExpressions;

namespace Day4Task1
{
    class Day4Task1Main
    {
        static void Main()
        {
            String line;
            Regex regex = new Regex(@"\[(\d{4})-(\d{2})-(\d{2}) (\d{2}):(\d{2})\] (.+)", RegexOptions.Compiled);
            var items = new List<(int year, int month, int day, int hour, int minute, string message)>();

            while ((line = Console.ReadLine()) != null)
            {
                Match match = regex.Matches(line)[0];
                GroupCollection groups = match.Groups;
                int year = Int32.Parse(groups[1].Value);
                int month = Int32.Parse(groups[2].Value);
                int day = Int32.Parse(groups[3].Value);
                int hour = Int32.Parse(groups[4].Value);
                int minute = Int32.Parse(groups[5].Value);
                string message = groups[6].Value;

                items.Add((year, month, day, hour, minute, message));
            }

            var ordered = items.OrderBy(i => i.year).ThenBy(i => i.month).ThenBy(i => i.day).ThenBy(i => i.hour).ThenBy(i => i.minute).ToList();
            var guardIdToSleepSchedule = new Dictionary<int, Dictionary<int, int>>();

            int currentGuard = -1;
            int startSleepHour = -1;
            int startSleepMinute = -1;
            Regex guardIdRegex = new Regex(@"Guard #(\d+) begins shift", RegexOptions.Compiled);

            foreach (var tuple in ordered)
            {
                if (tuple.message == "falls asleep")
                {
                    startSleepMinute = tuple.minute;
                    startSleepHour = tuple.hour;
                }
                else if (tuple.message == "wakes up")
                {
                    if (!guardIdToSleepSchedule.ContainsKey(currentGuard))
                    {
                        var sleepSchedule = new Dictionary<int, int>();

                        for (int i = 0; i < 60; i ++)
                        {
                            sleepSchedule.Add(i, 0);
                        }

                        guardIdToSleepSchedule.Add(currentGuard, sleepSchedule);
                    }

                    var currentGuardSleepSchedule = guardIdToSleepSchedule[currentGuard];
                    int endSleepMinute = tuple.minute;
                    int endSleepHour = tuple.hour;

                    if (endSleepHour == 1)
                    {
                        endSleepMinute = 60;
                    }

                    if (endSleepHour == 0)
                    {
                        if (startSleepHour == 23)
                        {
                            startSleepMinute = 0;
                        }

                        for (int i = startSleepMinute; i < endSleepMinute; i++)
                        {
                            currentGuardSleepSchedule[i] += 1;
                        }
                    }
                }
                else
                {
                    currentGuard = Int32.Parse(guardIdRegex.Matches(tuple.message)[0].Groups[1].Value);
                }
            }

            int max = 0;
            int sleepiestGuard = 0;
            int sleepiestMinute = 0;

            foreach (var entry in guardIdToSleepSchedule)
            {
                int maxCount = 0;
                int minute = 0;

                foreach (var count in entry.Value)
                {
                    if (count.Value > maxCount)
                    {
                        maxCount = count.Value;
                        minute = count.Key;
                    }
                }

                if (maxCount > max)
                {
                    sleepiestGuard = entry.Key;
                    sleepiestMinute = minute;
                    max = maxCount;
                }
            }

            Console.WriteLine(sleepiestMinute * sleepiestGuard);
        }
    }
}
