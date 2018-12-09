import java.util.regex.Matcher;
import java.util.regex.Pattern;
import java.util.stream.LongStream;

public class Day9Task2 {
    public static void main(String[] args) {
        Pattern pattern = Pattern.compile("([0-9]+) players; last marble is worth ([0-9]+) points");
        Matcher matcher = pattern.matcher(args[0]);

        matcher.find();

        int numPlayers = Integer.parseInt(matcher.group(1));
        int numMarbles = Integer.parseInt(matcher.group(2)) * 100;

        class Entry {
            Entry previous;
            Entry next;
            int value;

            Entry(int value) {
                this.value = value;
            }
        }

        Entry marble0 = new Entry(0);
        Entry marble1 = new Entry(1);

        marble0.previous = marble1;
        marble0.next = marble1;
        marble1.previous = marble0;
        marble1.next = marble0;

        Entry currentMarble = marble1;
        int currentPlayer = 1;
        long[] scores = new long[numMarbles];
        int size = 2;

        for (int marble = 2; marble <= numMarbles; marble++) {
            if (marble % 23 == 0) {
                Entry toRemove = currentMarble;

                for (int j = 0; j < 7; j++) {
                    toRemove = toRemove.previous;
                }

                Entry before = toRemove.previous;
                Entry after = toRemove.next;

                before.next = after;
                after.previous = before;
                toRemove.next = null;
                toRemove.previous = null;

                size -= 1;
                scores[currentPlayer] += marble + toRemove.value;
                currentMarble = after;
            } else {
                Entry entry = new Entry(marble);
                Entry skip1 = currentMarble.next;
                Entry skip2 = skip1.next;

                skip1.next = entry;
                skip2.previous = entry;

                entry.previous = skip1;
                entry.next = skip2;

                currentMarble = entry;
                size += 1;
            }

            currentPlayer = (currentPlayer + 1) % numPlayers;
        }

        long highscore = LongStream.of(scores).max().orElse(0L);

        System.out.println(highscore);
    }
}
